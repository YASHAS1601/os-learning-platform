import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NeonChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color accentColor;

  const NeonChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.accentColor = AppColors.neonCyan,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final chipAccent = isDark ? AppColors.darkAccentBlue : accentColor;

    final selectedBg = isDark
        ? const Color(0x335EA8FF)
        : chipAccent.withAlpha(46);
    final unselectedBg = isDark
        ? const Color(0x6614273C) // rgba(20,39,60,0.40) - Tertiary Glass
        : const Color(0x8CFFFFFF);

    final unselectedBorder = isDark
        ? const Color(0x24FFFFFF) // rgba(255,255,255,0.14)
        : const Color(0x99FFFFFF);

    final unselectedText = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? selectedBg : unselectedBg,
          border: Border.all(
            color: isSelected ? chipAccent : unselectedBorder,
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: isDark ? chipAccent.withAlpha(60) : chipAccent.withAlpha(64),
                    blurRadius: 10,
                    spreadRadius: -2,
                  ),
                ]
              : [
                  if (!isDark)
                    const BoxShadow(
                      color: Color(0x2E6482A0),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? chipAccent : unselectedText,
          ),
        ),
      ),
    );
  }
}
