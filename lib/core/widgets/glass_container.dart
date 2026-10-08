import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blur;
  final Color? color;
  final Color? borderColor;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BoxShadow? glowShadow;
  final VoidCallback? onTap;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 20.0,
    this.blur = 24.0,
    this.color,
    this.borderColor,
    this.borderWidth = 1.0,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.glowShadow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    final defaultBorderColor = isDark
        ? const Color(0x24FFFFFF) // rgba(255,255,255,0.14)
        : const Color(0xB3FFFFFF);
    final defaultFillColor = isDark
        ? const Color(0x9914273C) // rgba(20,39,60,0.60)
        : const Color(0xE6FFFFFF);

    final defaultShadow = isDark
        ? const BoxShadow(
            color: Color(0x7300142D), // rgba(0,20,45,0.45)
            blurRadius: 20,
            spreadRadius: 0,
            offset: Offset(0, 8),
          )
        : const BoxShadow(
            color: Color(0x1F3F6F9F), // soft cool blue glow
            blurRadius: 24,
            spreadRadius: 0,
            offset: Offset(0, 8),
          );

    final effectiveBorderColor = borderColor ?? defaultBorderColor;
    final effectiveFillColor = color ?? defaultFillColor;
    final effectiveShadow = glowShadow ?? defaultShadow;

    Widget containerContent = Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: effectiveFillColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: effectiveBorderColor,
          width: borderWidth,
        ),
        boxShadow: [effectiveShadow],
      ),
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );

    Widget frostedGlass = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: containerContent,
      ),
    );

    if (margin != null) {
      frostedGlass = Padding(
        padding: margin!,
        child: frostedGlass,
      );
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: frostedGlass,
      );
    }

    return frostedGlass;
  }
}
