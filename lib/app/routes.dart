import 'package:flutter/material.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/navigation/presentation/main_navigation_screen.dart';

class AppRoutes {
  static const String mainNavigation = '/main';

  static const String login = '/login';

  static Map<String, WidgetBuilder> get routes => {
        mainNavigation: (context) => const MainNavigationScreen(),
        login: (context) => const LoginScreen(),
      };
}
