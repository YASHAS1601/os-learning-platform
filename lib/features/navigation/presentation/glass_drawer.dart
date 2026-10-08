import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class GlassDrawer extends StatefulWidget {
  final int currentIndex;
  final int currentPracticeTab;
  final Function(int screenIndex, {int? practiceSubTab}) onSelectNavigation;

  const GlassDrawer({
    super.key,
    required this.currentIndex,
    required this.currentPracticeTab,
    required this.onSelectNavigation,
  });

  @override
  State<GlassDrawer> createState() => _GlassDrawerState();
}

class _GlassDrawerState extends State<GlassDrawer> {
  bool _isPracticeExpanded = true;

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    final panelBg = isDark
        ? const Color(0x990C1B2D) // rgba(12,27,45,0.60)
        : const Color(0xE6FFFFFF);
    final borderColor = isDark
        ? const Color(0x24FFFFFF) // rgba(255,255,255,0.14)
        : const Color(0xB3FFFFFF);
    final shadowColor = isDark
        ? const Color(0x7300142D) // rgba(0,20,45,0.45)
        : const Color(0x1F3F6F9F);

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      width: MediaQuery.of(context).size.width * 0.78,
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            decoration: BoxDecoration(
              color: panelBg,
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(24)),
              border: Border.all(
                color: borderColor,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 24,
                  spreadRadius: 0,
                  offset: const Offset(4, 0),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // User Profile Glass Drawer Header
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark ? AppColors.darkAccentBlue.withAlpha(30) : AppColors.iconPrimaryLight.withAlpha(20),
                            border: Border.all(color: isDark ? AppColors.darkAccentBlue : AppColors.iconPrimaryLight, width: 1.8),
                            boxShadow: [
                              BoxShadow(
                                color: isDark ? AppColors.darkAccentBlue.withAlpha(50) : AppColors.iconPrimaryLight.withAlpha(30),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.person_rounded,
                            color: isDark ? AppColors.darkAccentBlue : AppColors.iconPrimaryLight,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Yashas Kiran",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text1(context),
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "OS Learner • Pro",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark ? AppColors.darkAccentBlue : AppColors.iconPrimaryLight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 1, color: isDark ? AppColors.glassBorder : const Color(0xFFE2E8F0)),

                  // Menu Items List
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      children: [
                        const _SectionTitle(title: "MAIN"),

                        // 📚 Learn
                        _DrawerTile(
                          icon: Icons.auto_stories_rounded,
                          label: "Learn",
                          isSelected: widget.currentIndex == 0,
                          accentColor: isDark ? AppColors.darkAccentBlue : AppColors.iconActiveLight,
                          onTap: () {
                            Navigator.pop(context);
                            widget.onSelectNavigation(0);
                          },
                        ),

                        // 📝 Practice Submenu
                        _ExpandableDrawerGroup(
                          icon: Icons.model_training_rounded,
                          label: "Practice",
                          isSelected: widget.currentIndex == 1,
                          isExpanded: _isPracticeExpanded,
                          accentColor: isDark ? AppColors.darkAccentBlue : AppColors.iconActiveLight,
                          onToggleExpand: () {
                            setState(() {
                              _isPracticeExpanded = !_isPracticeExpanded;
                            });
                          },
                          children: [
                            _SubDrawerTile(
                              icon: Icons.quiz_outlined,
                              label: "Quizzes",
                              isSelected: widget.currentIndex == 1 && widget.currentPracticeTab == 0,
                              accentColor: isDark ? AppColors.darkAccentBlue : AppColors.iconActiveLight,
                              onTap: () {
                                Navigator.pop(context);
                                widget.onSelectNavigation(1, practiceSubTab: 0);
                              },
                            ),
                            _SubDrawerTile(
                              icon: Icons.assignment_outlined,
                              label: "Question Bank",
                              isSelected: widget.currentIndex == 1 && widget.currentPracticeTab == 1,
                              accentColor: isDark ? AppColors.darkAccentBlue : AppColors.iconActiveLight,
                              onTap: () {
                                Navigator.pop(context);
                                widget.onSelectNavigation(1, practiceSubTab: 1);
                              },
                            ),
                            _SubDrawerTile(
                              icon: Icons.menu_book_rounded,
                              label: "Exam Vault",
                              isSelected: widget.currentIndex == 1 && widget.currentPracticeTab == 2,
                              accentColor: isDark ? AppColors.darkAccentBlue : AppColors.iconActiveLight,
                              onTap: () {
                                Navigator.pop(context);
                                widget.onSelectNavigation(1, practiceSubTab: 2);
                              },
                            ),
                          ],
                        ),

                        // 🤖 Riyah
                        _DrawerTile(
                          icon: Icons.psychology_rounded,
                          label: "Riyah",
                          isSelected: widget.currentIndex == 2,
                          accentColor: isDark ? AppColors.darkAccentBlue : AppColors.iconActiveLight,
                          onTap: () {
                            Navigator.pop(context);
                            widget.onSelectNavigation(2);
                          },
                        ),

                        // 👤 Profile
                        _DrawerTile(
                          icon: Icons.person_rounded,
                          label: "Profile",
                          isSelected: widget.currentIndex == 3,
                          accentColor: isDark ? AppColors.darkAccentBlue : AppColors.iconActiveLight,
                          onTap: () {
                            Navigator.pop(context);
                            widget.onSelectNavigation(3);
                          },
                        ),

                        const SizedBox(height: 16),
                        const _SectionTitle(title: "OTHER"),

                        // 🔖 Bookmarks
                        _DrawerTile(
                          icon: Icons.bookmark_rounded,
                          label: "Bookmarks",
                          isSelected: false,
                          accentColor: isDark ? AppColors.darkAccentBlue : AppColors.iconPrimaryLight,
                          onTap: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Opening saved bookmarks..."),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 12),
                        Divider(color: isDark ? AppColors.glassBorder : const Color(0xFFE2E8F0)),
                        const SizedBox(height: 8),

                        // ⚙️ Settings
                        _DrawerTile(
                          icon: Icons.settings_rounded,
                          label: "Settings",
                          isSelected: widget.currentIndex == 4,
                          accentColor: isDark ? AppColors.darkAccentBlue : AppColors.iconActiveLight,
                          onTap: () {
                            Navigator.pop(context);
                            widget.onSelectNavigation(4);
                          },
                        ),

                        // ℹ️ About
                        _DrawerTile(
                          icon: Icons.info_outline_rounded,
                          label: "About OS Platform",
                          isSelected: false,
                          accentColor: isDark ? AppColors.darkAccentBlue : AppColors.iconPrimaryLight,
                          onTap: () {
                            Navigator.pop(context);
                            showAboutDialog(
                              context: context,
                              applicationName: "OS Learning Platform",
                              applicationVersion: "1.0.0",
                              applicationLegalese: "© 2026 OS Learning Platform. Built for Operating Systems Students.",
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 8, bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.textMutedDark : AppColors.iconPrimaryLight,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color accentColor;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final tileAccent = isDark ? AppColors.darkAccentBlue : AppColors.iconActiveLight;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: isSelected ? (isDark ? tileAccent.withAlpha(35) : const Color(0x1F315F91)) : Colors.transparent,
              border: Border.all(
                color: isSelected ? (isDark ? tileAccent.withAlpha(80) : const Color(0x66315F91)) : Colors.transparent,
                width: 1.2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: isDark ? tileAccent.withAlpha(50) : const Color(0x1F315F91),
                        blurRadius: 10,
                        spreadRadius: -2,
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isSelected ? tileAccent : (isDark ? AppColors.textSecondaryDark : AppColors.iconSecondaryLight),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? tileAccent : AppColors.text1(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpandableDrawerGroup extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isExpanded;
  final Color accentColor;
  final VoidCallback onToggleExpand;
  final List<Widget> children;

  const _ExpandableDrawerGroup({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.isExpanded,
    required this.accentColor,
    required this.onToggleExpand,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DrawerTile(
          icon: icon,
          label: label,
          isSelected: isSelected && !isExpanded,
          accentColor: accentColor,
          onTap: onToggleExpand,
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(children: children),
          ),
      ],
    );
  }
}

class _SubDrawerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color accentColor;
  final VoidCallback onTap;

  const _SubDrawerTile({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final subAccent = isDark ? accentColor : AppColors.iconActiveLight;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isSelected ? (isDark ? subAccent.withAlpha(35) : const Color(0x1F315F91)) : Colors.transparent,
              border: Border.all(
                color: isSelected ? (isDark ? subAccent.withAlpha(80) : const Color(0x66315F91)) : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: isSelected ? subAccent : (isDark ? AppColors.textMutedDark : AppColors.iconMutedLight),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? subAccent : AppColors.text2(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
