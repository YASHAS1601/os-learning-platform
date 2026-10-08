import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/theme_controller.dart';
import '../core/widgets/auth_gate.dart';
import 'routes.dart';

class OsLearningApp extends StatelessWidget {
  const OsLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, child) {
        return MaterialApp(
          title: 'OS Learning Platform',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeController.instance.themeMode,
          home: const AuthGate(),
          routes: AppRoutes.routes,
        );
      },
    );
  }
}

