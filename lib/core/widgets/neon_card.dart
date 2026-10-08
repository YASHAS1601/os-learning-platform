import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'glass_container.dart';

class NeonCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color accentColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;

  const NeonCard({
    super.key,
    required this.child,
    this.onTap,
    this.accentColor = AppColors.neonCyan,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      margin: margin,
      padding: padding,
      borderRadius: borderRadius,
      blur: 20.0,
      color: isDark ? null : const Color(0xE6FFFFFF),
      borderColor: isDark ? accentColor.withAlpha(70) : const Color(0xB3FFFFFF),
      onTap: onTap,
      glowShadow: isDark
          ? BoxShadow(
              color: accentColor.withAlpha(35),
              blurRadius: 12,
              spreadRadius: -4,
              offset: const Offset(0, 4),
            )
          : const BoxShadow(
              color: Color(0x1F3F6F9F),
              blurRadius: 24,
              spreadRadius: 0,
              offset: Offset(0, 8),
            ),
      child: child,
    );
  }
}
