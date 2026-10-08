import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../models/tutor_context_model.dart';

class TutorContextBanner extends StatelessWidget {
  final TutorContextModel contextData;
  final VoidCallback onClearContext;

  const TutorContextBanner({
    super.key,
    required this.contextData,
    required this.onClearContext,
  });

  @override
  Widget build(BuildContext context) {
    if (!contextData.hasContext) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.neonPurple.withAlpha(25),
      child: Row(
        children: [
          const Icon(Icons.bookmark_added_rounded, size: 16, color: AppColors.neonPurple),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Context: ${contextData.summaryString}",
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.neonPurple,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          InkWell(
            onTap: onClearContext,
            child: const Icon(Icons.close_rounded, size: 16, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
