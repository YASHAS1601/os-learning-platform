import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../models/exam_question_model.dart';

class ExamQuestionCard extends StatelessWidget {
  final ExamQuestionModel question;
  final VoidCallback onTap;

  const ExamQuestionCard({
    super.key,
    required this.question,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final goldAccent = isDark ? AppColors.neonGold : AppColors.iconPrimaryLight;
    final cyanAccent = isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: goldAccent.withAlpha(isDark ? 50 : 30),
      onTap: onTap,
      glowShadow: BoxShadow(
        color: goldAccent.withAlpha(isDark ? 20 : 15),
        blurRadius: 10,
        spreadRadius: -2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Topic Pill
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: cyanAccent.withAlpha(30),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: cyanAccent, width: 0.8),
                  ),
                  child: Text(
                    question.topicName.toUpperCase(),
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: cyanAccent,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              // Marks Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: goldAccent.withAlpha(40),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: goldAccent, width: 0.8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded, size: 12, color: goldAccent),
                    const SizedBox(width: 4),
                    Text(
                      question.marks,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: goldAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Question Title
          Text(
            question.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.text1(context),
              letterSpacing: -0.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 6),

          // Question Snippet Text Preview
          Text(
            question.questionText,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.text2(context),
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "View Full Problem",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: goldAccent,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_rounded,
                size: 14,
                color: goldAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
