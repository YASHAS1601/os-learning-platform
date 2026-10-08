import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/supabase_constants.dart';

/// Centralized service providing access to Supabase Client and Auth functions.
class SupabaseService {
  static final SupabaseService instance = SupabaseService._internal();

  SupabaseService._internal();

  bool _isInitialized = false;

  /// Indicates if Supabase was successfully initialized with valid URL/keys
  bool get isInitialized => _isInitialized;

  /// Access the Supabase client
  SupabaseClient get client => Supabase.instance.client;

  /// Current authenticated user
  User? get currentUser => _isInitialized ? client.auth.currentUser : null;

  /// Current auth session
  Session? get currentSession => _isInitialized ? client.auth.currentSession : null;

  /// Whether a user is currently authenticated
  bool get isAuthenticated => currentUser != null;

  /// User unique ID
  String? get userId => currentUser?.id;

  /// User Email
  String? get userEmail => currentUser?.email;

  /// User display name (from metadata or profile)
  String? get userName {
    if (currentUser == null) return null;
    final meta = currentUser!.userMetadata;
    return meta?['full_name'] as String? ??
        meta?['name'] as String? ??
        currentUser!.email?.split('@').first;
  }

  /// User avatar URL (from Google OAuth or profile)
  String? get avatarUrl {
    if (currentUser == null) return null;
    final meta = currentUser!.userMetadata;
    return meta?['avatar_url'] as String? ?? meta?['picture'] as String?;
  }

  /// Auth state change stream
  Stream<AuthState> get authStateChanges => _isInitialized
      ? client.auth.onAuthStateChange
      : const Stream.empty();

  /// Initialize Supabase Flutter SDK
  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: SupabaseConstants.supabaseUrl,
        publishableKey: SupabaseConstants.supabasePublishableKey,
        debug: kDebugMode,
      );



      instance._isInitialized = true;
      debugPrint('Supabase initialized successfully.');
    } catch (e) {
      debugPrint('Supabase initialization note: $e');
      // Mark as not initialized so app won't crash when running without live Supabase project
      instance._isInitialized = false;
    }
  }

  /// Email & Password Registration
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async {
    if (!_isInitialized) {
      throw Exception(
          'Supabase is not configured. Please set SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY.');
    }
    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: name != null ? {'full_name': name} : null,
    );

    if (response.user != null) {
      await ensureUserProfileCreated(response.user!, name: name);
    }
    return response;
  }

  /// Email & Password Sign In
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (!_isInitialized) {
      throw Exception(
          'Supabase is not configured. Please set SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY.');
    }
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user != null) {
      await ensureUserProfileCreated(response.user!);
    }
    return response;
  }

  /// Google OAuth Sign In
  Future<bool> signInWithGoogle() async {
    if (!_isInitialized) {
      throw Exception(
          'Supabase is not configured. Please set SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY.');
    }
    return await client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: kIsWeb
          ? null
          : 'io.supabase.flutter://login-callback/',
    );
  }


  /// Sign Out
  Future<void> signOut() async {
    if (_isInitialized) {
      await client.auth.signOut();
    }
  }

  /// Helper to ensure the profiles record exists in public.profiles table
  Future<void> ensureUserProfileCreated(User user, {String? name}) async {
    if (!_isInitialized) return;
    try {
      final meta = user.userMetadata;
      final displayName = name ??
          meta?['full_name'] as String? ??
          meta?['name'] as String? ??
          user.email?.split('@').first ??
          'Learner';
      final avatar =
          meta?['avatar_url'] as String? ?? meta?['picture'] as String?;

      await client.from('profiles').upsert({
        'id': user.id,
        'name': displayName,
        'email': user.email,
        'avatar_url': avatar,
        'updated_at': DateTime.now().toIso8601String(),
      }, onConflict: 'id');
    } catch (e) {
      debugPrint('Profile auto-creation note: $e');
    }
  }

}
