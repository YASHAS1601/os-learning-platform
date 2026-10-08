import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/navigation/presentation/main_navigation_screen.dart';

/// Listens to Supabase Auth state and routes between LoginScreen & MainNavigationScreen
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = SupabaseService.instance;

    // If Supabase is not initialized or configured, default to direct app access / login
    if (!supabase.isInitialized) {
      return const MainNavigationScreen();
    }

    return StreamBuilder<AuthState>(
      stream: supabase.authStateChanges,
      builder: (context, snapshot) {
        final session = supabase.currentSession;
        if (session != null) {
          return const MainNavigationScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
