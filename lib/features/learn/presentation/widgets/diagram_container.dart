import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class DiagramContainer extends StatelessWidget {
  final String title;
  final List<String> nodes;

  const DiagramContainer({
    super.key,
    required this.title,
    required this.nodes,
  });

  @override
  Widget build(BuildContext context) {
    if (nodes.isEmpty) return const SizedBox.shrink();
    final isDark = AppColors.isDark(context);
    final accent = isDark ? AppColors.neonCyan : AppColors.iconActiveLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree_outlined, color: accent, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.iconActiveLight,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GlassContainer(
          padding: const EdgeInsets.all(16),
          borderColor: accent.withAlpha(isDark ? 60 : 40),
          color: isDark ? const Color(0x330D0E23) : const Color(0xE6FFFFFF),
          child: Column(
            children: List.generate(nodes.length, (index) {
              final isLast = index == nodes.length - 1;
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceGlass : const Color(0xFF315F91),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: accent.withAlpha(isDark ? 80 : 120),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withAlpha(isDark ? 30 : 60),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.circle, color: isDark ? accent : Colors.white70, size: 8),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            nodes[index],
                            style: TextStyle(
                              color: isDark ? AppColors.textPrimaryDark : Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast) ...[
                    const SizedBox(height: 6),
                    Icon(
                      Icons.arrow_downward_rounded,
                      color: accent,
                      size: 20,
                    ),
                    const SizedBox(height: 6),
                  ],
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
