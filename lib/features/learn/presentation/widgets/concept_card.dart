import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class ConceptCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color accentColor;

  const ConceptCard({
    super.key,
    required this.title,
    required this.content,
    this.icon = Icons.lightbulb_outline_rounded,
    this.accentColor = AppColors.neonCyan,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final cardAccent = isDark ? accentColor : AppColors.iconPrimaryLight;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: cardAccent.withAlpha(isDark ? 60 : 40),
      color: isDark ? accentColor.withAlpha(15) : const Color(0xE6FFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: cardAccent, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: cardAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              color: AppColors.text1(context),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
