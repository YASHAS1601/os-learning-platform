import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/wrong_question_model.dart';
import '../services/os_mnemonic_service.dart';

/// Central repository managing personalized student mistake logs, hints, and mnemonics.
/// Persists locally so the student retains their personalized review topics offline and online.
class PersonalizedLearningRepository {
  static final PersonalizedLearningRepository instance = PersonalizedLearningRepository._internal();
  PersonalizedLearningRepository._internal();

  factory PersonalizedLearningRepository() => instance;

  static const String _storageKey = 'riyah_personalized_wrong_questions_v1';

  final List<WrongQuestionModel> _cache = [];
  bool _isLoaded = false;

  Future<void> _ensureLoaded() async {
    if (_isLoaded) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = prefs.getString(_storageKey);
      if (jsonStr != null && jsonStr.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(jsonStr);
        _cache.clear();
        for (final item in decoded) {
          if (item is Map<String, dynamic>) {
            _cache.add(WrongQuestionModel.fromJson(item));
          }
        }
      }
    } catch (e) {
      debugPrint('Error loading personalized learning questions: $e');
    } finally {
      _isLoaded = true;
    }
  }

  Future<void> _saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(_cache.map((q) => q.toJson()).toList());
      await prefs.setString(_storageKey, encoded);
    } catch (e) {
      debugPrint('Error saving personalized learning questions: $e');
    }
  }

  /// Record an incorrect question from Learn topic practice or Practice quiz runner
  Future<WrongQuestionModel> recordWrongQuestion({
    required String questionId,
    required String topicId,
    required String topicName,
    required String categoryId,
    required String questionText,
    required List<String> options,
    required int correctOptionIndex,
    required int userSelectedOptionIndex,
    required String explanation,
    String? customHint,
    String? customMnemonic,
  }) async {
    await _ensureLoaded();

    final hint = customHint ??
        OsMnemonicService.getHint(
          topicId: topicId,
          topicName: topicName,
          questionText: questionText,
          explanation: explanation,
        );

    final mnemonic = customMnemonic ??
        OsMnemonicService.getMnemonic(
          topicId: topicId,
          topicName: topicName,
          questionText: questionText,
          explanation: explanation,
        );

    final existingIndex = _cache.indexWhere((q) => q.questionId == questionId);

    final wrongModel = WrongQuestionModel(
      id: existingIndex != -1
          ? _cache[existingIndex].id
          : 'wq_${DateTime.now().millisecondsSinceEpoch}_$questionId',
      questionId: questionId,
      topicId: topicId,
      topicName: topicName,
      categoryId: categoryId,
      questionText: questionText,
      options: options,
      correctOptionIndex: correctOptionIndex,
      userSelectedOptionIndex: userSelectedOptionIndex,
      explanation: explanation,
      hint: hint,
      mnemonic: mnemonic,
      timestamp: DateTime.now(),
      isMastered: false, // reset mastered if missed again
    );

    if (existingIndex != -1) {
      _cache[existingIndex] = wrongModel;
    } else {
      _cache.insert(0, wrongModel);
    }

    await _saveToStorage();
    return wrongModel;
  }

  /// Get all wrong questions pending review
  Future<List<WrongQuestionModel>> getPendingQuestions() async {
    await _ensureLoaded();
    return _cache.where((q) => !q.isMastered).toList();
  }

  /// Get all wrong questions, optionally including mastered ones
  Future<List<WrongQuestionModel>> getAllQuestions({bool includeMastered = false}) async {
    await _ensureLoaded();
    if (includeMastered) {
      return List.unmodifiable(_cache);
    }
    return _cache.where((q) => !q.isMastered).toList();
  }

  /// Get pending wrong questions for a specific topic
  Future<List<WrongQuestionModel>> getQuestionsForTopic(String topicId) async {
    await _ensureLoaded();
    return _cache.where((q) => q.topicId == topicId && !q.isMastered).toList();
  }

  /// Group pending wrong questions by Topic ID
  Future<Map<String, List<WrongQuestionModel>>> getQuestionsGroupedByTopic() async {
    await _ensureLoaded();
    final Map<String, List<WrongQuestionModel>> grouped = {};
    for (final q in _cache.where((q) => !q.isMastered)) {
      grouped.putIfAbsent(q.topicId, () => []).add(q);
    }
    return grouped;
  }

  /// Mark question as mastered once correctly solved in Personalized Quiz
  Future<void> markQuestionMastered(String questionId) async {
    await _ensureLoaded();
    final index = _cache.indexWhere((q) => q.questionId == questionId);
    if (index != -1) {
      _cache[index] = _cache[index].copyWith(isMastered: true);
      await _saveToStorage();
    }
  }

  /// Toggle mastered state for a question
  Future<void> toggleMastered(String questionId) async {
    await _ensureLoaded();
    final index = _cache.indexWhere((q) => q.questionId == questionId);
    if (index != -1) {
      _cache[index] = _cache[index].copyWith(isMastered: !_cache[index].isMastered);
      await _saveToStorage();
    }
  }

  /// Seed initial sample mistakes if empty for immediate exploration
  Future<void> seedSampleMistakesIfEmpty() async {
    await _ensureLoaded();
    if (_cache.isNotEmpty) return;

    await recordWrongQuestion(
      questionId: 'bas_1_q4',
      topicId: 'bas_1',
      topicName: 'What is an Operating System?',
      categoryId: 'cat_basics',
      questionText: 'What separates system software like an OS from user application software?',
      options: [
        'System software uses more RAM than applications',
        'Application software runs before the OS boots',
        'System software does not require a CPU to execute',
        'System software directly interacts with hardware and operates in privileged kernel mode'
      ],
      correctOptionIndex: 3,
      userSelectedOptionIndex: 0,
      explanation: 'System software runs in privileged kernel mode with full hardware access, whereas user application software runs in restricted user mode.',
    );

    await recordWrongQuestion(
      questionId: 'bas_3_q2',
      topicId: 'bas_3',
      topicName: 'Dual-Mode Operation',
      categoryId: 'cat_basics',
      questionText: 'Which CPU instruction can only be executed in Kernel Mode?',
      options: [
        'Adding two integers',
        'Direct hardware I/O instructions (in/out) and disabling interrupts',
        'Calling a user-defined function',
        'Allocating memory using malloc() in C'
      ],
      correctOptionIndex: 1,
      userSelectedOptionIndex: 3,
      explanation: 'Privileged instructions such as modifying interrupt masks, accessing I/O ports, and halting the CPU can strictly be executed only in Kernel Mode (Ring 0).',
    );
  }

  /// Clear all errors for a specific topic
  Future<void> clearTopic(String topicId) async {
    await _ensureLoaded();
    _cache.removeWhere((q) => q.topicId == topicId);
    await _saveToStorage();
  }

  /// Total count of pending questions needing review
  Future<int> getPendingCount() async {
    await _ensureLoaded();
    return _cache.where((q) => !q.isMastered).length;
  }
}

