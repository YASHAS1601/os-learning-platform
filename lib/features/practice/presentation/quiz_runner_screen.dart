import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/neon_button.dart';
import '../models/quiz_model.dart';
import '../repositories/quiz_result_repository.dart';
import 'quiz_result_screen.dart';
import '../../ai_tutor/models/tutor_context_model.dart';
import '../../ai_tutor/models/tutor_mode.dart';
import '../../ai_tutor/presentation/ai_tutor_screen.dart';
import '../../profile/repositories/personalized_learning_repository.dart';


import '../models/question_model.dart';
import '../utils/quiz_validator.dart';

class QuizRunnerScreen extends StatefulWidget {
  final QuizModel quiz;

  const QuizRunnerScreen({
    super.key,
    required this.quiz,
  });

  @override
  State<QuizRunnerScreen> createState() => _QuizRunnerScreenState();
}

class _QuizRunnerScreenState extends State<QuizRunnerScreen> {
  int _currentIndex = 0;
  final Map<int, int> _selectedAnswers = {};
  bool _showExplanation = false;
  late List<QuestionModel> _questions;

  @override
  void initState() {
    super.initState();
    _questions = QuizValidator.shuffleQuizQuestions(widget.quiz.questions);
  }

  void _selectOption(int optionIndex) {
    setState(() {
      _selectedAnswers[_currentIndex] = optionIndex;
      _showExplanation = true;
    });

    final q = _questions[_currentIndex];
    if (optionIndex != q.correctOptionIndex) {
      PersonalizedLearningRepository.instance.recordWrongQuestion(
        questionId: q.id,
        topicId: q.topicId,
        topicName: q.topicName,
        categoryId: q.categoryId,
        questionText: q.questionText,
        options: q.options,
        correctOptionIndex: q.correctOptionIndex,
        userSelectedOptionIndex: optionIndex,
        explanation: q.explanation,
      );
    }
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _showExplanation = _selectedAnswers.containsKey(_currentIndex);
      });
    } else {
      _finishQuiz();
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _showExplanation = _selectedAnswers.containsKey(_currentIndex);
      });
    }
  }

  void _finishQuiz() async {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i].correctOptionIndex) {
        score++;
      }
    }

    // Save quiz result asynchronously to Supabase
    try {
      final repo = QuizResultRepository();
      await repo.saveQuizResult(
        quizName: widget.quiz.title,
        score: score,
        totalQuestions: _questions.length,
      );
    } catch (_) {}

    // Record any wrong questions for Personalized Learning in Student Profile
    try {
      final pRepo = PersonalizedLearningRepository.instance;
      for (int i = 0; i < _questions.length; i++) {
        final q = _questions[i];
        final userAnswer = _selectedAnswers[i] ?? -1;
        if (userAnswer != q.correctOptionIndex) {
          await pRepo.recordWrongQuestion(
            questionId: q.id,
            topicId: q.topicId,
            topicName: q.topicName,
            categoryId: q.categoryId,
            questionText: q.questionText,
            options: q.options,
            correctOptionIndex: q.correctOptionIndex,
            userSelectedOptionIndex: userAnswer,
            explanation: q.explanation,
          );
        }
      }
    } catch (_) {}

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultScreen(
          quiz: QuizModel(
            id: widget.quiz.id,
            title: widget.quiz.title,
            description: widget.quiz.description,
            icon: widget.quiz.icon,
            accentColor: widget.quiz.accentColor,
            questions: _questions,
          ),
          score: score,
          total: _questions.length,
          onRetry: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuizRunnerScreen(quiz: widget.quiz),
              ),
            );
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.quiz.title)),
        body: const Center(child: Text("No questions available in this quiz.")),
      );
    }

    final isDark = AppColors.isDark(context);
    final question = _questions[_currentIndex];
    final selectedOption = _selectedAnswers[_currentIndex];
    final isAnswered = selectedOption != null;
    final progress = (_currentIndex + 1) / _questions.length;
    final quizAccent = isDark ? widget.quiz.accentColor : AppColors.iconPrimaryLight;
    final riyahAccent = isDark ? AppColors.neonPurple : AppColors.iconActiveLight;
    final cyanAccent = isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight;

    return Container(
      decoration: AppColors.bgDecoration(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.close_rounded, color: AppColors.text1(context)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.quiz.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.text1(context),
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Progress Indicator Bar
              LinearProgressIndicator(
                value: progress,
                backgroundColor: isDark ? AppColors.surfaceDark : const Color(0xFFE2E8F0),
                color: quizAccent,
                minHeight: 4,
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question Counter Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: quizAccent.withAlpha(30),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: quizAccent, width: 1),
                            ),
                            child: Text(
                              "Question ${_currentIndex + 1} of ${widget.quiz.questions.length}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: quizAccent,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.cardGlass(context),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              question.difficulty.name.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textM(context),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Topic Title Badge
                      Text(
                        question.topicName,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textM(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Question Text Card
                      GlassContainer(
                        padding: const EdgeInsets.all(18),
                        borderColor: quizAccent.withAlpha(isDark ? 50 : 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question.questionText,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text1(context),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 12),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AiTutorScreen(
                                      initialMode: TutorMode.solveWithMe,
                                      initialContext: TutorContextModel(
                                        questionText: question.questionText,
                                        topicTitle: question.topicName,
                                        selectedAnswer: selectedOption != null ? question.options[selectedOption] : null,
                                        correctAnswer: question.options[question.correctOptionIndex],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: riyahAccent.withAlpha(30),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: riyahAccent, width: 0.8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.psychology_rounded, size: 14, color: riyahAccent),
                                    const SizedBox(width: 6),
                                    Text(
                                      "Need a hint? Ask Riyah",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: riyahAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Options List
                      ...List.generate(question.options.length, (index) {
                        final optionText = question.options[index];
                        final isThisSelected = selectedOption == index;
                        final isCorrect = index == question.correctOptionIndex;

                        Color optionBorder = cyanAccent.withAlpha(30);
                        Color optionBg = AppColors.cardGlass(context);
                        Color textColor = AppColors.text1(context);

                        if (isAnswered) {
                          if (isCorrect) {
                            optionBorder = AppColors.success;
                            optionBg = AppColors.success.withAlpha(30);
                            textColor = isDark ? AppColors.success : const Color(0xFF0F5132);
                          } else if (isThisSelected) {
                            optionBorder = AppColors.error;
                            optionBg = AppColors.error.withAlpha(30);
                            textColor = isDark ? AppColors.error : const Color(0xFF842029);
                          }
                        } else if (isThisSelected) {
                          optionBorder = quizAccent;
                          optionBg = quizAccent.withAlpha(40);
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GlassContainer(
                            padding: const EdgeInsets.all(14),
                            borderColor: optionBorder,
                            color: optionBg,
                            onTap: isAnswered ? null : () => _selectOption(index),
                            child: Row(
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: optionBorder.withAlpha(40),
                                    border: Border.all(color: optionBorder, width: 1.2),
                                  ),
                                  child: Center(
                                    child: Text(
                                      String.fromCharCode(65 + index),
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    optionText,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: textColor,
                                      fontWeight: isThisSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                if (isAnswered && isCorrect)
                                  const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20),
                                if (isAnswered && isThisSelected && !isCorrect)
                                  const Icon(Icons.cancel_rounded, color: AppColors.error, size: 20),
                              ],
                            ),
                          ),
                        );
                      }),

                      // Explanation Box
                      if (_showExplanation && isAnswered) ...[
                        const SizedBox(height: 16),
                        GlassContainer(
                          padding: const EdgeInsets.all(14),
                          borderColor: cyanAccent.withAlpha(60),
                          color: cyanAccent.withAlpha(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.lightbulb_rounded, color: cyanAccent, size: 18),
                                  const SizedBox(width: 6),
                                  Text(
                                    "Explanation",
                                    style: TextStyle(
                                      color: cyanAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                question.explanation,
                                style: TextStyle(
                                  color: AppColors.text1(context),
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),

              // Navigation Controls Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.bgSecondary(context),
                  border: Border(top: BorderSide(color: isDark ? Colors.white.withAlpha(20) : AppColors.glassBorderLight)),
                ),
                child: Row(
                  children: [
                    if (_currentIndex > 0) ...[
                      OutlinedButton(
                        onPressed: _previousQuestion,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: cyanAccent.withAlpha(60)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text("Previous", style: TextStyle(color: AppColors.text1(context))),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: NeonButton(
                        text: _currentIndex == widget.quiz.questions.length - 1 ? "Finish Quiz" : "Next Question",
                        icon: _currentIndex == widget.quiz.questions.length - 1 ? Icons.check_circle_rounded : Icons.arrow_forward_rounded,
                        glowColor: quizAccent,
                        onPressed: isAnswered
                            ? _nextQuestion
                            : () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please select an answer to proceed."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
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
