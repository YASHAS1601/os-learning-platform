import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../models/topic_model.dart';

class StepByStepBox extends StatelessWidget {
  final List<StepItem> steps;

  const StepByStepBox({
    super.key,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) return const SizedBox.shrink();
    final isDark = AppColors.isDark(context);
    final stepAccent = isDark ? AppColors.neonPink : AppColors.iconActiveLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.format_list_numbered_rounded, color: stepAccent, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Step-by-Step Execution",
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
        ...steps.map((step) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassContainer(
                padding: const EdgeInsets.all(14),
                borderColor: stepAccent.withAlpha(isDark ? 40 : 30),
                color: isDark ? null : const Color(0xE6FFFFFF),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: stepAccent.withAlpha(isDark ? 50 : 25),
                        shape: BoxShape.circle,
                        border: Border.all(color: stepAccent, width: 1.2),
                      ),
                      child: Center(
                        child: Text(
                          '${step.stepNumber}',
                          style: TextStyle(
                            color: stepAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step.title,
                            style: TextStyle(
                              color: AppColors.text1(context),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            step.description,
                            style: TextStyle(
                              color: AppColors.text2(context),
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
