import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/neon_button.dart';

class PracticeTopicBtn extends StatelessWidget {
  final String topicTitle;
  final VoidCallback onPressed;

  const PracticeTopicBtn({
    super.key,
    required this.topicTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return NeonButton(
      text: "Practice $topicTitle",
      icon: Icons.play_arrow_rounded,
      glowColor: AppColors.neonCyan,
      gradient: const LinearGradient(
        colors: [AppColors.neonCyan, AppColors.neonBlue],
      ),
      onPressed: onPressed,
    );
  }
}
