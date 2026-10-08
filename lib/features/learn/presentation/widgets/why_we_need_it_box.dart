import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class WhyWeNeedItBox extends StatelessWidget {
  final String whyWeNeedIt;
  final String? analogy;

  const WhyWeNeedItBox({
    super.key,
    required this.whyWeNeedIt,
    this.analogy,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final accent = isDark ? AppColors.neonGold : AppColors.iconActiveLight;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: accent.withAlpha(isDark ? 60 : 40),
      color: isDark ? AppColors.neonGold.withAlpha(15) : const Color(0xFFFFFDF0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline_rounded, color: accent, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Why Do We Need It?',
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            whyWeNeedIt,
            style: TextStyle(
              color: AppColors.text1(context),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          if (analogy != null && analogy!.isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.backgroundSecondaryDark : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: accent.withAlpha(60)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('💡 ', style: const TextStyle(fontSize: 16)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Real-World Analogy',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: accent,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          analogy!,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.text1(context),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
