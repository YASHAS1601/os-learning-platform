import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/neon_button.dart';
import '../../ai_tutor/models/tutor_context_model.dart';
import '../../ai_tutor/models/tutor_mode.dart';
import '../../ai_tutor/presentation/ai_tutor_screen.dart';
import '../models/wrong_question_model.dart';
import '../repositories/personalized_learning_repository.dart';

class PersonalizedQuizScreen extends StatefulWidget {
  final String title;
  final List<WrongQuestionModel> questions;
  final VoidCallback? onQuizCompleted;

  const PersonalizedQuizScreen({
    super.key,
    required this.title,
    required this.questions,
    this.onQuizCompleted,
  });

  @override
  State<PersonalizedQuizScreen> createState() => _PersonalizedQuizScreenState();
}

class _PersonalizedQuizScreenState extends State<PersonalizedQuizScreen> {
  final PersonalizedLearningRepository _repo = PersonalizedLearningRepository.instance;

  int _currentIndex = 0;
  int? _selectedOption;
  bool _hasSubmitted = false;
  bool _showHint = false;

  int _correctCount = 0;
  final List<WrongQuestionModel> _masteredQuestions = [];
  final List<WrongQuestionModel> _stillUnmastered = [];

  bool _isQuizFinished = false;

  void _selectOption(int index) {
    if (_hasSubmitted) return;
    setState(() {
      _selectedOption = index;
    });
  }

  void _submitAnswer() async {
    if (_selectedOption == null || _hasSubmitted) return;

    final q = widget.questions[_currentIndex];
    final isCorrect = _selectedOption == q.correctOptionIndex;

    setState(() {
      _hasSubmitted = true;
      if (isCorrect) {
        _correctCount++;
        _masteredQuestions.add(q);
      } else {
        _stillUnmastered.add(q);
      }
    });

    if (isCorrect) {
      await _repo.markQuestionMastered(q.questionId);
    }
  }

  void _nextQuestion() {
    if (_currentIndex < widget.questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _hasSubmitted = false;
        _showHint = false;
      });
    } else {
      setState(() {
        _isQuizFinished = true;
      });
      widget.onQuizCompleted?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final accentCyan = isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight;
    final accentPurple = isDark ? AppColors.neonPurple : AppColors.iconActiveLight;

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
            widget.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.text1(context),
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: _isQuizFinished ? _buildSummaryView(isDark) : _buildQuizView(isDark, accentCyan, accentPurple),
        ),
      ),
    );
  }

  Widget _buildQuizView(bool isDark, Color accentCyan, Color accentPurple) {
    final q = widget.questions[_currentIndex];
    final isCorrect = _selectedOption == q.correctOptionIndex;
    final progress = (_currentIndex + 1) / widget.questions.length;

    return Column(
      children: [
        // Progress bar
        LinearProgressIndicator(
          value: progress,
          backgroundColor: isDark ? AppColors.surfaceDark : const Color(0xFFE2E8F0),
          color: accentCyan,
          minHeight: 4,
        ),

        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: accentCyan.withAlpha(30),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: accentCyan, width: 1),
                      ),
                      child: Text(
                        "Review Q ${_currentIndex + 1} of ${widget.questions.length}",
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: accentCyan,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber.withAlpha(120), width: 0.8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.history_rounded, size: 12, color: Colors.amberAccent),
                          SizedBox(width: 4),
                          Text(
                            "MISSED PREVIOUSLY",
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Topic Badge
                Text(
                  q.topicName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textM(context),
                  ),
                ),

                const SizedBox(height: 8),

                // Question Box
                GlassContainer(
                  padding: const EdgeInsets.all(18),
                  borderColor: accentCyan.withAlpha(isDark ? 50 : 30),
                  child: Text(
                    q.questionText,
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text1(context),
                      height: 1.45,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Hint and Ask Riyah Row
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: Icon(
                          _showHint ? Icons.lightbulb_rounded : Icons.lightbulb_outline_rounded,
                          size: 16,
                          color: Colors.amberAccent,
                        ),
                        label: Text(
                          _showHint ? "Hide Hint" : "Show Hint",
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.amberAccent),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.amber.withAlpha(120)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        onPressed: () {
                          setState(() {
                            _showHint = !_showHint;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: Icon(Icons.psychology_rounded, size: 16, color: accentPurple),
                        label: Text(
                          "Ask Riyah",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: accentPurple),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: accentPurple.withAlpha(120)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AiTutorScreen(
                                initialMode: TutorMode.solveWithMe,
                                initialContext: TutorContextModel(
                                  questionText: q.questionText,
                                  topicTitle: q.topicName,
                                  correctAnswer: q.options[q.correctOptionIndex],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                // Expanded Hint Box
                if (_showHint) ...[
                  const SizedBox(height: 10),
                  GlassContainer(
                    padding: const EdgeInsets.all(12),
                    borderRadius: 12,
                    borderColor: Colors.amber.withAlpha(120),
                    color: Colors.amber.withAlpha(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.tips_and_updates_rounded, color: Colors.amberAccent, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            q.hint,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: isDark ? Colors.amber.shade100 : Colors.amber.shade900,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                // Options List
                ...List.generate(q.options.length, (optIdx) {
                  final isSelected = _selectedOption == optIdx;
                  final isOptionCorrect = optIdx == q.correctOptionIndex;

                  Color optBorder = accentCyan.withAlpha(isDark ? 40 : 25);
                  Color optBg = AppColors.cardGlass(context);
                  Color optTextColor = AppColors.text1(context);

                  if (_hasSubmitted) {
                    if (isOptionCorrect) {
                      optBorder = isDark ? AppColors.neonGreen : Colors.green.shade600;
                      optBg = optBorder.withAlpha(40);
                      optTextColor = optBorder;
                    } else if (isSelected) {
                      optBorder = isDark ? AppColors.neonPink : Colors.red.shade600;
                      optBg = optBorder.withAlpha(40);
                      optTextColor = optBorder;
                    }
                  } else if (isSelected) {
                    optBorder = accentCyan;
                    optBg = accentCyan.withAlpha(35);
                    optTextColor = accentCyan;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => _selectOption(optIdx),
                      child: GlassContainer(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        borderColor: optBorder,
                        color: optBg,
                        borderRadius: 14,
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: optBorder.withAlpha(40),
                                border: Border.all(color: optBorder, width: 1.2),
                              ),
                              child: Text(
                                String.fromCharCode(65 + optIdx),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: optTextColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                q.options[optIdx],
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500,
                                  color: optTextColor,
                                  height: 1.35,
                                ),
                              ),
                            ),
                            if (_hasSubmitted && isOptionCorrect)
                              const Icon(Icons.check_circle_rounded, color: Colors.greenAccent, size: 20)
                            else if (_hasSubmitted && isSelected && !isOptionCorrect)
                              const Icon(Icons.cancel_rounded, color: Colors.redAccent, size: 20),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

                // Post-Submission Analysis: Where You Went Wrong & Mnemonic
                if (_hasSubmitted) ...[
                  const SizedBox(height: 16),

                  // Where You Went Wrong Card
                  GlassContainer(
                    padding: const EdgeInsets.all(16),
                    borderRadius: 14,
                    borderColor: (isCorrect ? Colors.green : Colors.redAccent).withAlpha(140),
                    color: (isCorrect ? Colors.green : Colors.red).withAlpha(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isCorrect ? Icons.check_circle_rounded : Icons.info_outline_rounded,
                              color: isCorrect ? Colors.greenAccent : Colors.redAccent,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isCorrect ? "Correct! Question Mastered 🎉" : "Where You Went Wrong",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isCorrect ? Colors.greenAccent : Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (!isCorrect) ...[
                          Text(
                            "You previously picked: Option ${String.fromCharCode(65 + q.userSelectedOptionIndex)}: ${q.options.isNotEmpty && q.userSelectedOptionIndex >= 0 && q.userSelectedOptionIndex < q.options.length ? q.options[q.userSelectedOptionIndex] : 'Unknown'}",
                            style: TextStyle(
                              fontSize: 11.5,
                              color: AppColors.text2(context),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 6),
                        ],
                        Text(
                          q.explanation,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: AppColors.text1(context),
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 🧠 Memory Mnemonic Box to retain concept forever
                  GlassContainer(
                    padding: const EdgeInsets.all(16),
                    borderRadius: 14,
                    borderColor: accentPurple.withAlpha(160),
                    color: accentPurple.withAlpha(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.psychology_alt_rounded, color: accentPurple, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              "Memory Mnemonic to Remember",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: accentPurple,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          q.mnemonic,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.purple.shade100 : Colors.purple.shade900,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                // Action Button (Submit or Next)
                if (!_hasSubmitted)
                  NeonButton(
                    text: "Check Answer",
                    icon: Icons.check_rounded,
                    glowColor: accentCyan,
                    onPressed: _selectedOption != null ? _submitAnswer : () {},
                  )
                else
                  NeonButton(
                    text: _currentIndex < widget.questions.length - 1 ? "Next Review Question" : "View Personalized Summary",
                    icon: Icons.arrow_forward_rounded,
                    glowColor: isCorrect ? AppColors.neonGreen : accentCyan,
                    onPressed: _nextQuestion,
                  ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryView(bool isDark) {
    final total = widget.questions.length;
    final percent = total > 0 ? (_correctCount / total * 100).toInt() : 0;
    final accentGreen = isDark ? AppColors.neonGreen : Colors.green.shade700;

    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentGreen.withAlpha(35),
                border: Border.all(color: accentGreen, width: 2),
              ),
              child: Icon(Icons.verified_rounded, size: 44, color: accentGreen),
            ),
            const SizedBox(height: 18),
            Text(
              "Personalized Review Completed!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.text1(context),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              "You successfully mastered $_correctCount out of $total previously missed questions.",
              style: TextStyle(fontSize: 13, color: AppColors.text2(context)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Score Card
            GlassContainer(
              padding: const EdgeInsets.all(20),
              borderRadius: 16,
              borderColor: accentGreen.withAlpha(80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _SummaryStat(label: "Mastered", value: "$_correctCount", color: accentGreen),
                  _SummaryStat(label: "Still to Review", value: "${total - _correctCount}", color: Colors.amberAccent),
                  _SummaryStat(label: "Accuracy", value: "$percent%", color: isDark ? AppColors.neonCyan : Colors.blue.shade700),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Mnemonics Quick Recall Section
            if (widget.questions.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "🧠 Mnemonics for Rapid Recall",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text1(context),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...widget.questions.take(3).map((q) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GlassContainer(
                  padding: const EdgeInsets.all(12),
                  borderRadius: 12,
                  borderColor: (isDark ? AppColors.neonPurple : Colors.purple).withAlpha(100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        q.topicName,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.purpleAccent),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        q.mnemonic,
                        style: TextStyle(fontSize: 12, color: AppColors.text1(context), height: 1.35),
                      ),
                    ],
                  ),
                ),
              )),
              const SizedBox(height: 16),
            ],

            NeonButton(
              text: "Back to Student Profile",
              icon: Icons.person_rounded,
              glowColor: isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryStat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.textMuted),
        ),
      ],
    );
  }
}

