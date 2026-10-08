/// Supabase configuration constants for the OS Learning Platform.
class SupabaseConstants {
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://gfxfevayjjnozbitgpta.supabase.co',
  );

  static const String supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
    defaultValue: 'sb_publishable_1S29AJjfUTNKjEZT70ZP4g_9VbGcJr7',
  );

  /// Helper to check if credentials have been replaced with live values
  static bool get isConfigured =>
      supabaseUrl.isNotEmpty &&
      supabasePublishableKey.isNotEmpty &&
      !supabaseUrl.contains('YOUR_SUPABASE_PROJECT_ID') &&
      !supabasePublishableKey.contains('YOUR_SUPABASE_PUBLISHABLE_KEY');
}
