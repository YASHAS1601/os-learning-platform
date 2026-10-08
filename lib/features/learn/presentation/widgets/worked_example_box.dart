import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../models/topic_model.dart';

class WorkedExampleBox extends StatelessWidget {
  final WorkedExampleModel example;

  const WorkedExampleBox({
    super.key,
    required this.example,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final accent = isDark ? AppColors.neonCyan : AppColors.iconActiveLight;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: accent.withAlpha(isDark ? 80 : 50),
      color: isDark ? const Color(0x1F00F0FF) : const Color(0xFFF0F8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calculate_rounded, color: accent, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Worked Example: ${example.title}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            example.problemStatement,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.text1(context),
            ),
          ),
          const SizedBox(height: 12),

          // Inputs
          if (example.inputs.isNotEmpty) ...[
            Text('Input Data:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: accent)),
            const SizedBox(height: 4),
            ...example.inputs.map((inp) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      const Text('• ', style: TextStyle(fontSize: 12)),
                      Expanded(
                        child: Text(
                          inp,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: AppColors.text1(context)),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 12),
          ],

          // Step by step
          if (example.stepByStepCalculations.isNotEmpty) ...[
            Text('Calculation Steps:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: accent)),
            const SizedBox(height: 6),
            ...example.stepByStepCalculations.asMap().entries.map((entry) {
              final idx = entry.key + 1;
              final stepStr = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: accent.withAlpha(40),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Step $idx',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: accent),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        stepStr,
                        style: TextStyle(fontSize: 12, color: AppColors.text1(context), height: 1.4),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 12),
          ],

          // Final Results
          if (example.finalResults.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.backgroundSecondaryDark : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: (isDark ? AppColors.neonGreen : AppColors.success).withAlpha(80)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎯 Final Calculated Results',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.neonGreen : AppColors.success,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...example.finalResults.map((res) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          res,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text1(context),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
