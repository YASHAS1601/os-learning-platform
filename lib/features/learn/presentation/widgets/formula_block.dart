import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class FormulaBlock extends StatelessWidget {
  final String? formula;
  final String? timeComplexity;
  final String? spaceComplexity;

  const FormulaBlock({
    super.key,
    this.formula,
    this.timeComplexity,
    this.spaceComplexity,
  });

  @override
  Widget build(BuildContext context) {
    if (formula == null && timeComplexity == null && spaceComplexity == null) {
      return const SizedBox.shrink();
    }
    final isDark = AppColors.isDark(context);
    final accent = isDark ? AppColors.neonPurple : AppColors.iconActiveLight;
    final cyanAccent = isDark ? AppColors.neonCyan : AppColors.iconActiveLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.functions_rounded, color: accent, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Formulas & Complexity",
                style: TextStyle(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.iconActiveLight,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GlassContainer(
          padding: const EdgeInsets.all(16),
          borderColor: accent.withAlpha(isDark ? 70 : 40),
          color: isDark ? accent.withAlpha(20) : const Color(0xE6FFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (formula != null) ...[
                Text(
                  "Key Formula:",
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.backgroundSecondaryDark : const Color(0xFFF0F5FA),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: accent.withAlpha(isDark ? 50 : 80)),
                  ),
                  child: Text(
                    formula!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: cyanAccent,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              if (timeComplexity != null || spaceComplexity != null) ...[
                Row(
                  children: [
                    if (timeComplexity != null)
                      Expanded(
                        child: _ComplexityPill(
                          label: "Time Complexity",
                          value: timeComplexity!,
                          accentColor: cyanAccent,
                        ),
                      ),
                    if (timeComplexity != null && spaceComplexity != null)
                      const SizedBox(width: 10),
                    if (spaceComplexity != null)
                      Expanded(
                        child: _ComplexityPill(
                          label: "Space Complexity",
                          value: spaceComplexity!,
                          accentColor: isDark ? AppColors.neonPink : AppColors.iconActiveLight,
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ComplexityPill extends StatelessWidget {
  final String label;
  final String value;
  final Color accentColor;

  const _ComplexityPill({
    required this.label,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : const Color(0xFFF0F5FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accentColor.withAlpha(isDark ? 50 : 80)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.text1(context),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
