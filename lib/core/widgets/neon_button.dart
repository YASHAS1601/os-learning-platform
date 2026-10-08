import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NeonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color glowColor;
  final Gradient? gradient;
  final double height;
  final bool fullWidth;

  const NeonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.glowColor = AppColors.neonCyan,
    this.gradient,
    this.height = 48,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final buttonAccent = isDark ? AppColors.darkAccentBlue : glowColor;

    final effectiveGradient = gradient ??
        LinearGradient(
          colors: [buttonAccent, buttonAccent.withAlpha(200)],
        );

    Widget btnChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, color: isDark ? const Color(0xFF07111F) : Colors.white, size: 20),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            color: isDark ? const Color(0xFF07111F) : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );

    return Container(
      height: height,
      width: fullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: effectiveGradient,
        boxShadow: [
          BoxShadow(
            color: buttonAccent.withAlpha(isDark ? 80 : 120),
            blurRadius: 16,
            spreadRadius: -2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: btnChild,
          ),
        ),
      ),
    );
  }
}
