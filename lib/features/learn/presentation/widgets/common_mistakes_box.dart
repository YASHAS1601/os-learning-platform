import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class CommonMistakesBox extends StatelessWidget {
  final List<String> mistakes;

  const CommonMistakesBox({
    super.key,
    required this.mistakes,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final accent = isDark ? AppColors.error : const Color(0xFFC5221F);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: accent.withAlpha(isDark ? 80 : 50),
      color: isDark ? AppColors.error.withAlpha(20) : const Color(0xFFFFF0F0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.report_problem_rounded, color: accent, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Common Student Mistakes to Avoid',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...mistakes.map((m) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('⚠️ ', style: const TextStyle(fontSize: 12)),
                    Expanded(
                      child: Text(
                        m,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.text1(context),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
