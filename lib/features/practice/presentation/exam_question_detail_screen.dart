import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/neon_button.dart';
import '../../ai_tutor/models/tutor_context_model.dart';
import '../../ai_tutor/models/tutor_mode.dart';
import '../../ai_tutor/presentation/ai_tutor_screen.dart';
import '../models/exam_question_model.dart';
import '../models/quiz_model.dart';
import '../models/question_model.dart';
import 'quiz_runner_screen.dart';

class ExamQuestionDetailScreen extends StatelessWidget {
  final ExamQuestionModel question;

  const ExamQuestionDetailScreen({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final cyanAccent = isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight;
    final goldAccent = isDark ? AppColors.neonGold : AppColors.iconPrimaryLight;
    final purpleAccent = isDark ? AppColors.neonPurple : AppColors.iconActiveLight;

    return Container(
      decoration: AppColors.bgDecoration(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: cyanAccent, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Exam Question Detail",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.text1(context),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Badges Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: cyanAccent.withAlpha(30),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: cyanAccent, width: 1),
                          ),
                          child: Text(
                            question.topicName.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: cyanAccent,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: goldAccent.withAlpha(40),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: goldAccent, width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star_rounded, size: 14, color: goldAccent),
                              const SizedBox(width: 4),
                              Text(
                                question.marks,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: goldAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Title
                    Text(
                      question.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text1(context),
                        letterSpacing: -0.4,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Full Question Text Card
                    GlassContainer(
                      padding: const EdgeInsets.all(18),
                      borderColor: goldAccent.withAlpha(isDark ? 60 : 30),
                      color: goldAccent.withAlpha(isDark ? 10 : 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.quiz_rounded, color: goldAccent, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                "Exam Problem Statement",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: goldAccent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SelectableText(
                            question.questionText,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.text1(context),
                              height: 1.5,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Action Controls Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bgSecondary(context),
                border: Border(top: BorderSide(color: isDark ? Colors.white.withAlpha(20) : const Color(0xFFE2E8F0))),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NeonButton(
                    text: "Solve Question in Practice Engine",
                    icon: Icons.play_arrow_rounded,
                    glowColor: cyanAccent,
                    onPressed: () {
                      final practiceQuestion = QuestionModel(
                        id: 'eq_practice_${question.id}',
                        topicId: question.id,
                        topicName: question.topicName,
                        categoryId: question.categoryId,
                        questionText: question.questionText,
                        options: [
                          "Step-by-step problem analysis derived directly from official exam solution guidelines",
                          "Preemptive priority scheduling sequence without resource limits",
                          "Contiguous memory compaction with page table remapping",
                          "Direct secondary storage cylinder seek operation"
                        ],
                        correctOptionIndex: 0,
                        explanation: "Follow the step-by-step problem analysis derived directly from official exam guidelines.",
                        type: QuestionType.algorithm,
                        difficulty: QuestionDifficulty.hard,
                      );

                      final quiz = QuizModel(
                        id: 'quiz_exam_${question.id}',
                        title: question.title,
                        description: 'Exam Problem Practice',
                        icon: Icons.menu_book_rounded,
                        accentColor: cyanAccent,
                        questions: [practiceQuestion],
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizRunnerScreen(quiz: quiz),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AiTutorScreen(
                            initialMode: TutorMode.solveWithMe,
                            initialContext: TutorContextModel(
                              questionText: question.questionText,
                              topicTitle: question.topicName,
                              categoryName: question.topicName,
                            ),
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 46),
                      side: BorderSide(color: purpleAccent.withAlpha(90)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.psychology_rounded, color: purpleAccent, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          "Ask Riyah for Guidance",
                          style: TextStyle(
                            color: purpleAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
