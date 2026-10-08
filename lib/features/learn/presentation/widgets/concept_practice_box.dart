import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../practice/utils/quiz_validator.dart';
import '../../models/topic_model.dart';

class ConceptPracticeBox extends StatefulWidget {
  final List<ConceptQuestionModel> questions;

  const ConceptPracticeBox({
    super.key,
    required this.questions,
  });

  @override
  State<ConceptPracticeBox> createState() => _ConceptPracticeBoxState();
}

class _ConceptPracticeBoxState extends State<ConceptPracticeBox> {
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  bool _hasSubmitted = false;
  late List<ConceptQuestionModel> _questions;

  @override
  void initState() {
    super.initState();
    _questions = QuizValidator.shuffleConceptQuestions(widget.questions);
  }

  void _selectOption(int idx) {
    if (_hasSubmitted) return;
    setState(() {
      _selectedOptionIndex = idx;
    });
  }

  void _submitAnswer() {
    if (_selectedOptionIndex == null) return;
    setState(() {
      _hasSubmitted = true;
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
      _selectedOptionIndex = null;
      _hasSubmitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) return const SizedBox.shrink();

    final isDark = AppColors.isDark(context);
    final question = _questions[_currentQuestionIndex];
    final isCorrect = _selectedOptionIndex == question.correctOptionIndex;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F8FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.quiz_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Practice & Test Yourself',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(40),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Q ${_currentQuestionIndex + 1}/${_questions.length}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Text(
            question.question,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.text1(context),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),

          // Options
          ...question.options.asMap().entries.map((entry) {
            final idx = entry.key;
            final optionText = entry.value;
            final isSelected = _selectedOptionIndex == idx;
            final isCorrectOption = idx == question.correctOptionIndex;

            Color optionBorder = Colors.white24;
            Color optionBg = isDark ? AppColors.surfaceDark : Colors.white;

            if (_hasSubmitted) {
              if (isCorrectOption) {
                optionBorder = isDark ? AppColors.neonGreen : AppColors.success;
                optionBg = (isDark ? AppColors.neonGreen : AppColors.success).withAlpha(40);
              } else if (isSelected && !isCorrectOption) {
                optionBorder = AppColors.error;
                optionBg = AppColors.error.withAlpha(40);
              }
            } else if (isSelected) {
              optionBorder = isDark ? AppColors.neonCyan : AppColors.iconActiveLight;
              optionBg = (isDark ? AppColors.neonCyan : AppColors.iconActiveLight).withAlpha(40);
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () => _selectOption(idx),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: optionBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: optionBorder, width: isSelected || _hasSubmitted ? 2 : 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: optionBorder.withAlpha(50),
                        ),
                        child: Text(
                          String.fromCharCode(65 + idx),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isSelected || _hasSubmitted ? optionBorder : AppColors.text1(context),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          optionText,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.text1(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 12),

          if (!_hasSubmitted) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedOptionIndex != null ? _submitAnswer : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight,
                  foregroundColor: isDark ? Colors.black : Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Check Answer'),
              ),
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCorrect ? AppColors.success.withAlpha(30) : AppColors.error.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: isCorrect ? AppColors.success : AppColors.error),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                          color: isCorrect ? AppColors.success : AppColors.error, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        isCorrect ? 'Correct!' : 'Incorrect',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isCorrect ? AppColors.success : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    question.explanation,
                    style: TextStyle(fontSize: 12, color: AppColors.text1(context), height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (_questions.length > 1)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _nextQuestion,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                    side: BorderSide(color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Next Question'),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
