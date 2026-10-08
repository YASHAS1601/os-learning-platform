import 'package:flutter/foundation.dart';
import '../../../core/services/supabase_service.dart';
import '../models/quiz_result_model.dart';

/// Repository for saving and retrieving quiz results in Supabase
class QuizResultRepository {
  final SupabaseService _supabaseService;

  QuizResultRepository({SupabaseService? supabaseService})
      : _supabaseService = supabaseService ?? SupabaseService.instance;

  /// Save a completed quiz result
  Future<QuizResultModel?> saveQuizResult({
    required String quizName,
    required int score,
    required int totalQuestions,
  }) async {
    if (!_supabaseService.isInitialized) return null;
    final uid = _supabaseService.userId;
    if (uid == null) return null;

    try {
      final result = QuizResultModel(
        userId: uid,
        quizName: quizName,
        score: score,
        totalQuestions: totalQuestions,
        createdAt: DateTime.now(),
      );

      final response = await _supabaseService.client
          .from('quiz_results')
          .insert(result.toJson())
          .select()
          .single();

      return QuizResultModel.fromJson(response);
    } catch (e) {
      debugPrint('Error saving quiz result: $e');
      return null;
    }
  }

  /// Get all quiz results for current user
  Future<List<QuizResultModel>> getQuizResults() async {
    if (!_supabaseService.isInitialized) return [];
    final uid = _supabaseService.userId;
    if (uid == null) return [];

    try {
      final response = await _supabaseService.client
          .from('quiz_results')
          .select()
          .eq('user_id', uid)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => QuizResultModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error fetching quiz results: $e');
      return [];
    }
  }

  /// Get best score for a specific quiz
  Future<QuizResultModel?> getBestScore(String quizName) async {
    if (!_supabaseService.isInitialized) return null;
    final uid = _supabaseService.userId;
    if (uid == null) return null;

    try {
      final response = await _supabaseService.client
          .from('quiz_results')
          .select()
          .eq('user_id', uid)
          .eq('quiz_name', quizName)
          .order('score', ascending: false)
          .limit(1)
          .maybeSingle();

      if (response == null) return null;
      return QuizResultModel.fromJson(response);
    } catch (e) {
      debugPrint('Error getting best score: $e');
      return null;
    }
  }

  /// Get recent quiz results (limit N)
  Future<List<QuizResultModel>> getRecentResults({int limit = 5}) async {
    if (!_supabaseService.isInitialized) return [];
    final uid = _supabaseService.userId;
    if (uid == null) return [];

    try {
      final response = await _supabaseService.client
          .from('quiz_results')
          .select()
          .eq('user_id', uid)
          .order('created_at', ascending: false)
          .limit(limit);

      return (response as List)
          .map((json) => QuizResultModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error fetching recent quiz results: $e');
      return [];
    }
  }
}
