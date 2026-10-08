import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/chat_message.dart';
import '../models/tutor_context_model.dart';
import '../models/tutor_mode.dart';

class RiyahException implements Exception {
  final String message;
  final String code;
  final int? statusCode;

  const RiyahException(this.message, {this.code = 'UNKNOWN', this.statusCode});

  @override
  String toString() => message;
}

abstract class AITutorServiceInterface {
  Future<ChatMessage> sendMessage({
    required String prompt,
    required TutorMode mode,
    TutorContextModel? context,
  });

  Future<ChatMessage> explainSimply({
    required String topic,
    TutorContextModel? context,
  });

  Future<ChatMessage> solveWithMe({
    required String problem,
    TutorContextModel? context,
  });

  Future<ChatMessage> generatePractice({
    required String topic,
    TutorContextModel? context,
  });

  Future<ChatMessage> generateQuiz({
    required String topic,
    TutorContextModel? context,
  });

  Future<ChatMessage> explainCode({
    required String codeSnippet,
    TutorContextModel? context,
  });
}

class AITutorService implements AITutorServiceInterface {
  /// Configurable Production Render Base URL (override via --dart-define=BACKEND_URL=...)
  static const String productionBaseUrl = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: 'https://os-learning-platform-backend.onrender.com',
  );

  /// Local Development Fallback Base URL
  static const String defaultBaseUrl = 'http://10.241.58.252:3000';

  final String? customBaseUrl;
  final http.Client _client;

  String? _resolvedBaseUrl;

  AITutorService({
    this.customBaseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  List<String> get _candidateUrls {
    if (customBaseUrl != null && customBaseUrl!.isNotEmpty) {
      return [customBaseUrl!];
    }
    return [
      defaultBaseUrl,            // LAN IP http://10.241.58.252:3000 (preferred for local development)
      if (productionBaseUrl.isNotEmpty) productionBaseUrl, // Render production URL fallback
      'http://localhost:3000',    // ADB reverse / local host
      'http://10.0.2.2:3000',     // Android emulator
    ];
  }

  String _mapModeToKey(TutorMode mode) {
    switch (mode) {
      case TutorMode.askTutor:
        return 'ask_tutor';
      case TutorMode.explainSimply:
        return 'explain_simply';
      case TutorMode.solveWithMe:
        return 'solve_with_me';
      case TutorMode.generatePractice:
        return 'generate_practice';
      case TutorMode.quizMe:
        return 'quiz_me';
      case TutorMode.explainCode:
        return 'explain_code';
    }
  }

  @override
  Future<ChatMessage> sendMessage({
    required String prompt,
    required TutorMode mode,
    TutorContextModel? context,
  }) async {
    final payload = {
      'message': prompt,
      'mode': _mapModeToKey(mode),
      'topic': context?.topicTitle ?? '',
      'subtopic': context?.subtopicTitle ?? '',
      'question': context?.questionText ?? '',
      'userAnswer': context?.selectedAnswer ?? '',
      if (context?.categoryName != null) 'categoryName': context!.categoryName,
      if (context?.correctAnswer != null) 'correctAnswer': context!.correctAnswer,
      if (context?.difficulty != null) 'difficulty': context!.difficulty,
    };

    final candidates = _resolvedBaseUrl != null
        ? [_resolvedBaseUrl!, ..._candidateUrls.where((u) => u != _resolvedBaseUrl)]
        : _candidateUrls;

    String lastError = '';

    for (final baseUrl in candidates) {
      final uri = Uri.parse('$baseUrl/api/riyah/chat');

      if (kDebugMode) {
        print('[RIYAH] Trying candidate URL: $baseUrl');
      }

      try {
        final response = await _client
            .post(
              uri,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(payload),
            )
            .timeout(const Duration(seconds: 60));

        if (kDebugMode) {
          print('[RIYAH] [$baseUrl] Status: ${response.statusCode} | Content-Type: ${response.headers['content-type']}');
          final snippet = response.body.length > 200 ? '${response.body.substring(0, 200)}...' : response.body;
          print('[RIYAH] [$baseUrl] Body snippet: $snippet');
        }

        Map<String, dynamic> data;
        try {
          final decoded = jsonDecode(response.body);
          if (decoded is Map<String, dynamic>) {
            data = decoded;
          } else {
            lastError = 'JSON response from $baseUrl is not a Map object.';
            if (kDebugMode) print('[RIYAH] $lastError');
            continue;
          }
        } on FormatException catch (fe) {
          lastError = 'FormatException at $baseUrl: ${fe.message}';
          if (kDebugMode) print('[RIYAH] $lastError');
          continue;
        }

        if (response.statusCode == 200 && data['success'] == true) {
          _resolvedBaseUrl = baseUrl;

          final replyText = ((data['response'] ?? data['message'] ?? data['reply']) as String? ?? '').trim();
          if (replyText.isEmpty) {
            throw const RiyahException(
              'Received empty response from Riyah backend.',
              code: 'EMPTY_RESPONSE',
              statusCode: 200,
            );
          }

          return ChatMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            text: replyText,
            sender: MessageSender.riyah,
            timestamp: DateTime.now(),
            mode: mode,
            context: context,
          );
        } else {
          final errorMessage = data['error'] as String? ??
              'Riyah backend returned HTTP status ${response.statusCode}.';
          final errorCode = data['code'] as String? ?? 'SERVER_ERROR';

          throw RiyahException(
            errorMessage,
            code: errorCode,
            statusCode: response.statusCode,
          );
        }
      } on SocketException catch (e) {
        lastError = 'SocketException at $baseUrl: ${e.message}';
        if (kDebugMode) print('[RIYAH] $lastError');
        continue;
      } on http.ClientException catch (e) {
        lastError = 'ClientException at $baseUrl: ${e.message}';
        if (kDebugMode) print('[RIYAH] $lastError');
        continue;
      } on TimeoutException catch (e) {
        lastError = 'TimeoutException (60s) at $baseUrl: ${e.message}';
        if (kDebugMode) print('[RIYAH] $lastError');
        continue;
      } catch (e) {
        if (e is RiyahException) rethrow;
        if (e.toString().contains('TimeoutException')) {
          lastError = 'TimeoutException (60s) at $baseUrl';
          if (kDebugMode) print('[RIYAH] $lastError');
          continue;
        }
        rethrow;
      }
    }

    throw RiyahException(
      'Cannot reach Riyah backend. Tried: ${candidates.join(", ")}. Last error: $lastError',
      code: 'BACKEND_UNREACHABLE',
    );
  }

  @override
  Future<ChatMessage> explainSimply({
    required String topic,
    TutorContextModel? context,
  }) {
    return sendMessage(
      prompt: "Explain $topic simply",
      mode: TutorMode.explainSimply,
      context: context,
    );
  }

  @override
  Future<ChatMessage> solveWithMe({
    required String problem,
    TutorContextModel? context,
  }) {
    return sendMessage(
      prompt: "Guide me through: $problem",
      mode: TutorMode.solveWithMe,
      context: context,
    );
  }

  @override
  Future<ChatMessage> generatePractice({
    required String topic,
    TutorContextModel? context,
  }) {
    return sendMessage(
      prompt: "Generate practice question for $topic",
      mode: TutorMode.generatePractice,
      context: context,
    );
  }

  @override
  Future<ChatMessage> generateQuiz({
    required String topic,
    TutorContextModel? context,
  }) {
    return sendMessage(
      prompt: "Quiz me on $topic",
      mode: TutorMode.quizMe,
      context: context,
    );
  }

  @override
  Future<ChatMessage> explainCode({
    required String codeSnippet,
    TutorContextModel? context,
  }) {
    return sendMessage(
      prompt: "Explain code:\n$codeSnippet",
      mode: TutorMode.explainCode,
      context: context,
    );
  }
}

/// Alias for replaceable Riyah backend service abstraction
typedef RiyahService = AITutorService;
