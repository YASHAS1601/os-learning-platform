import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/neon_button.dart';
import '../models/quiz_model.dart';
import '../../profile/repositories/personalized_learning_repository.dart';
import '../../profile/presentation/personalized_quiz_screen.dart';

class QuizResultScreen extends StatelessWidget {
  final QuizModel quiz;
  final int score;
  final int total;
  final VoidCallback onRetry;

  const QuizResultScreen({
    super.key,
    required this.quiz,
    required this.score,
    required this.total,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = total > 0 ? (score / total) * 100 : 0;
    final bool passed = percentage >= 60;
    final isDark = AppColors.isDark(context);
    final primaryAccent = isDark ? (passed ? AppColors.neonCyan : AppColors.neonGold) : AppColors.iconPrimaryLight;
    final accuracyAccent = isDark ? AppColors.neonCyan : AppColors.iconActiveLight;

    return Container(
      decoration: AppColors.bgDecoration(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Glowing Medal / Trophy Container
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryAccent.withAlpha(40),
                      border: Border.all(
                        color: primaryAccent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryAccent.withAlpha(isDark ? 120 : 50),
                          blurRadius: 20,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      passed ? Icons.emoji_events_rounded : Icons.psychology_rounded,
                      size: 46,
                      color: primaryAccent,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    passed ? "Great Job!" : "Keep Practicing!",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text1(context),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Completed ${quiz.title}",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.text2(context),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Score Breakdown Glass Box
                  GlassContainer(
                    padding: const EdgeInsets.all(24),
                    borderColor: primaryAccent.withAlpha(isDark ? 80 : 40),
                    child: Column(
                      children: [
                        Text(
                          "${percentage.toInt()}%",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: primaryAccent,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "You answered $score out of $total questions correctly",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.text2(context),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Divider(color: isDark ? Colors.white.withAlpha(20) : const Color(0xFFE2E8F0)),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatItem(
                              label: "CORRECT",
                              value: "$score",
                              color: isDark ? AppColors.success : const Color(0xFF0F5132),
                            ),
                            _StatItem(
                              label: "INCORRECT",
                              value: "${total - score}",
                              color: isDark ? AppColors.error : const Color(0xFF842029),
                            ),
                            _StatItem(
                              label: "ACCURACY",
                              value: "${percentage.toInt()}%",
                              color: accuracyAccent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  if (total - score > 0) ...[
                    NeonButton(
                      text: "Personalized Mistake Quiz (${total - score} Missed)",
                      icon: Icons.psychology_alt_rounded,
                      glowColor: isDark ? AppColors.neonPurple : AppColors.iconActiveLight,
                      onPressed: () async {
                        final pRepo = PersonalizedLearningRepository.instance;
                        final pending = await pRepo.getPendingQuestions();
                        if (!context.mounted) return;
                        if (pending.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonalizedQuizScreen(
                                title: "${quiz.title} Review",
                                questions: pending,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Retry and Back Buttons
                  NeonButton(
                    text: "Retry Quiz",
                    icon: Icons.refresh_rounded,
                    glowColor: primaryAccent,
                    onPressed: onRetry,
                  ),

                  const SizedBox(height: 12),

                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      side: BorderSide(color: primaryAccent.withAlpha(isDark ? 80 : 50)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      "Back to Practice",
                      style: TextStyle(
                        color: AppColors.text1(context),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
