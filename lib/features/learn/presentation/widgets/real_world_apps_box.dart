import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class RealWorldAppsBox extends StatelessWidget {
  final List<String> applications;

  const RealWorldAppsBox({
    super.key,
    required this.applications,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final accent = isDark ? AppColors.neonCyan : AppColors.iconActiveLight;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: accent.withAlpha(isDark ? 60 : 40),
      color: isDark ? const Color(0x1F00F0FF) : const Color(0xFFF0F8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.devices_rounded, color: accent, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Real-World Applications in Systems',
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
          ...applications.map((app) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('🚀 ', style: const TextStyle(fontSize: 14)),
                    Expanded(
                      child: Text(
                        app,
                        style: TextStyle(fontSize: 13, color: AppColors.text1(context), height: 1.4),
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
