import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../learn/presentation/learn_screen.dart';
import '../../practice/presentation/practice_screen.dart';
import '../../ai_tutor/presentation/ai_tutor_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../profile/presentation/settings_screen.dart';
import 'glass_drawer.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  int _currentPracticeTab = 0;

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _onSelectNavigation(int screenIndex, {int? practiceSubTab}) {
    setState(() {
      _currentIndex = screenIndex;
      if (practiceSubTab != null) {
        _currentPracticeTab = practiceSubTab;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    final List<Widget> screens = [
      LearnScreen(
        onOpenDrawer: _openDrawer,
        onOpenProfile: () => _onSelectNavigation(3),
      ),
      PracticeScreen(
        initialTab: _currentPracticeTab,
        onTabChanged: (tab) {
          setState(() {
            _currentPracticeTab = tab;
          });
        },
        onOpenDrawer: _openDrawer,
      ),
      AiTutorScreen(onOpenDrawer: _openDrawer),
      ProfileScreen(onOpenDrawer: _openDrawer),
      SettingsScreen(onOpenDrawer: _openDrawer),
    ];

    Widget? riyahFab;
    if (_currentIndex != 2) {
      if (isDark) {
        riyahFab = Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xB314273C), // Translucent dark glass
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0x3D5EA8FF), // Subtle white/blue glass edge
                    width: 1.2,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x405EA8FF), // Soft blue glow
                      blurRadius: 20,
                      spreadRadius: -2,
                      offset: Offset(0, 6),
                    ),
                    BoxShadow(
                      color: Color(0x7300142D), // Cool deep shadow
                      blurRadius: 24,
                      spreadRadius: 0,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => _onSelectNavigation(2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.darkAccentBlue.withAlpha(40),
                              border: Border.all(color: AppColors.darkAccentBlue.withAlpha(100), width: 1),
                            ),
                            child: const Icon(
                              Icons.psychology_rounded,
                              color: AppColors.darkAccentBlue,
                              size: 19,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Ask Riyah 👋",
                            style: TextStyle(
                              color: AppColors.textPrimaryDark,
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        riyahFab = Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xC7FFFFFF),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xD9FFFFFF),
                    width: 1.5,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x2E6482A0),
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => _onSelectNavigation(2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.iconActiveLight.withAlpha(25),
                              border: Border.all(color: AppColors.iconActiveLight.withAlpha(80), width: 1),
                            ),
                            child: const Icon(
                              Icons.psychology_rounded,
                              color: AppColors.iconActiveLight,
                              size: 19,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Ask Riyah 👋",
                            style: TextStyle(
                              color: AppColors.textPrimaryLight,
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    return Container(
      decoration: AppColors.bgDecoration(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        drawer: GlassDrawer(
          currentIndex: _currentIndex,
          currentPracticeTab: _currentPracticeTab,
          onSelectNavigation: _onSelectNavigation,
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: screens,
        ),
        floatingActionButton: riyahFab,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
