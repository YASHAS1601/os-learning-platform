import 'package:flutter/foundation.dart';
import '../../../core/services/supabase_service.dart';
import '../models/user_progress.dart';

/// Repository for handling user progress operations in Supabase
class UserProgressRepository {
  final SupabaseService _supabaseService;

  UserProgressRepository({SupabaseService? supabaseService})
      : _supabaseService = supabaseService ?? SupabaseService.instance;

  /// Get all topic progress records for the logged in user
  Future<List<UserProgress>> getProgress() async {
    if (!_supabaseService.isInitialized) return [];
    final uid = _supabaseService.userId;
    if (uid == null) return [];

    try {
      final response = await _supabaseService.client
          .from('user_progress')
          .select()
          .eq('user_id', uid);

      return (response as List)
          .map((json) => UserProgress.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error getting user progress: $e');
      return [];
    }
  }

  /// Get progress for a specific topic
  Future<UserProgress?> getTopicProgress(String topic) async {
    if (!_supabaseService.isInitialized) return null;
    final uid = _supabaseService.userId;
    if (uid == null) return null;

    try {
      final response = await _supabaseService.client
          .from('user_progress')
          .select()
          .eq('user_id', uid)
          .eq('topic', topic)
          .maybeSingle();

      if (response == null) return null;
      return UserProgress.fromJson(response);
    } catch (e) {
      debugPrint('Error getting topic progress: $e');
      return null;
    }
  }

  /// Upsert (save/update) topic progress
  Future<UserProgress?> saveProgress({
    required String topic,
    required bool completed,
    int progress = 100,
  }) async {
    if (!_supabaseService.isInitialized) return null;
    final uid = _supabaseService.userId;
    if (uid == null) return null;

    try {
      final data = {
        'user_id': uid,
        'topic': topic,
        'completed': completed,
        'progress': progress,
        'updated_at': DateTime.now().toIso8601String(),
      };

      final response = await _supabaseService.client
          .from('user_progress')
          .upsert(
            data,
            onConflict: 'user_id,topic',
          )
          .select()
          .single();

      return UserProgress.fromJson(response);
    } catch (e) {
      debugPrint('Error saving topic progress: $e');
      return null;
    }
  }

  /// Mark topic as completed
  Future<UserProgress?> markTopicCompleted(String topic) async {
    return saveProgress(topic: topic, completed: true, progress: 100);
  }
}
