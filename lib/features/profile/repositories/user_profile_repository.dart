import 'package:flutter/foundation.dart';
import '../../../core/services/supabase_service.dart';
import '../models/user_profile.dart';

/// Repository for handling profiles table operations in Supabase
class UserProfileRepository {
  final SupabaseService _supabaseService;

  UserProfileRepository({SupabaseService? supabaseService})
      : _supabaseService = supabaseService ?? SupabaseService.instance;

  /// Fetch user profile from Supabase profiles table
  Future<UserProfile?> getProfile([String? targetUserId]) async {
    if (!_supabaseService.isInitialized) return null;
    final uid = targetUserId ?? _supabaseService.userId;
    if (uid == null) return null;

    try {
      final response = await _supabaseService.client
          .from('profiles')
          .select()
          .eq('id', uid)
          .maybeSingle();

      if (response == null) {
        // Auto create profile fallback
        final user = _supabaseService.currentUser;
        if (user != null) {
          await _supabaseService.ensureUserProfileCreated(user);
          return getProfile(uid);
        }
        return null;
      }
      return UserProfile.fromJson(response);
    } catch (e) {
      debugPrint('Error fetching profile: $e');
      return null;
    }
  }

  /// Create a new profile record
  Future<UserProfile?> createProfile(UserProfile profile) async {
    if (!_supabaseService.isInitialized) return null;
    try {
      final data = profile.toJson();
      data['created_at'] = DateTime.now().toIso8601String();
      final response = await _supabaseService.client
          .from('profiles')
          .insert(data)
          .select()
          .single();
      return UserProfile.fromJson(response);
    } catch (e) {
      debugPrint('Error creating profile: $e');
      return null;
    }
  }

  /// Update user profile
  Future<UserProfile?> updateProfile(UserProfile profile) async {
    if (!_supabaseService.isInitialized) return null;
    try {
      final response = await _supabaseService.client
          .from('profiles')
          .update(profile.toJson())
          .eq('id', profile.id)
          .select()
          .single();
      return UserProfile.fromJson(response);
    } catch (e) {
      debugPrint('Error updating profile: $e');
      return null;
    }
  }
}
