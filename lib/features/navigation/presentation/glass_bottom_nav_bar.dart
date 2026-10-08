import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class NavItemData {
  final String label;
  final IconData icon;
  final Color accentColor;

  const NavItemData({
    required this.label,
    required this.icon,
    required this.accentColor,
  });
}

class GlassBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  static const List<NavItemData> navItems = [
    NavItemData(
      label: 'LEARN',
      icon: Icons.auto_stories_rounded,
      accentColor: AppColors.neonCyan,
    ),
    NavItemData(
      label: 'PRACTICE',
      icon: Icons.model_training_rounded,
      accentColor: AppColors.neonPink,
    ),
    NavItemData(
      label: 'RIYAH',
      icon: Icons.psychology_rounded,
      accentColor: AppColors.neonPurple,
    ),
    NavItemData(
      label: 'PROFILE',
      icon: Icons.person_rounded,
      accentColor: AppColors.neonBlue,
    ),
  ];

  const GlassBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: bottomSafeArea > 0 ? bottomSafeArea + 6 : 16,
      ),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0x3B101226),
          border: Border.all(
            color: AppColors.neonCyan.withAlpha(50),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(120),
              blurRadius: 20,
              spreadRadius: 4,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(navItems.length, (index) {
                final item = navItems[index];
                final isSelected = index == currentIndex;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(index),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: isSelected
                            ? item.accentColor.withAlpha(35)
                            : Colors.transparent,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: item.accentColor.withAlpha(90),
                                  blurRadius: 12,
                                  spreadRadius: -2,
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.icon,
                            size: isSelected ? 22 : 20,
                            color: isSelected
                                ? item.accentColor
                                : AppColors.textMuted,
                          ),
                          const SizedBox(height: 3),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: isSelected ? 10 : 9.5,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected
                                  ? item.accentColor
                                  : AppColors.textMuted,
                              letterSpacing: 0.5,
                            ),
                            child: Text(
                              item.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
