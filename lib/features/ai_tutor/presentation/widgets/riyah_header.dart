import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RiyahHeader extends StatelessWidget {
  final VoidCallback? onOpenDrawer;

  const RiyahHeader({
    super.key,
    this.onOpenDrawer,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final accentPurple = isDark ? AppColors.neonPurple : AppColors.iconActiveLight;
    final accentGreen = isDark ? AppColors.neonGreen : AppColors.iconActiveLight;

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.menu_rounded, color: accentPurple, size: 28),
            onPressed: () {
              if (onOpenDrawer != null) {
                onOpenDrawer!();
              } else {
                Scaffold.of(context).openDrawer();
              }
            },
          ),
          const SizedBox(width: 4),
          Stack(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentPurple.withAlpha(30),
                  border: Border.all(color: accentPurple, width: 1.8),
                  boxShadow: [
                    BoxShadow(
                      color: accentPurple.withAlpha(isDark ? 120 : 50),
                      blurRadius: 14,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.psychology_rounded,
                  color: accentPurple,
                  size: 26,
                ),
              ),
              Positioned(
                right: 2,
                bottom: 2,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentGreen,
                    border: Border.all(color: AppColors.bg(context), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: accentGreen.withAlpha(150),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Riyah",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text1(context),
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "👋",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  "Your Operating Systems Tutor",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.text2(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
