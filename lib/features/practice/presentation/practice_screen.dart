import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_search_bar.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/neon_card.dart';
import '../../../core/widgets/neon_chip.dart';
import '../../../core/widgets/section_header.dart';
import '../data/question_bank_data.dart';
import '../data/exam_vault_data.dart';
import '../models/quiz_model.dart';
import '../models/exam_question_model.dart';
import 'quiz_runner_screen.dart';
import 'exam_question_detail_screen.dart';
import 'widgets/exam_question_card.dart';

class PracticeScreen extends StatefulWidget {
  final int? initialTab;
  final ValueChanged<int>? onTabChanged;
  final VoidCallback? onOpenDrawer;

  const PracticeScreen({
    super.key,
    this.initialTab,
    this.onTabChanged,
    this.onOpenDrawer,
  });

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late int _selectedTab; // 0 = Quizzes, 1 = Question Bank, 2 = Exam Vault
  String _selectedFilter = 'all';
  String _examSearchQuery = '';
  final TextEditingController _examSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab ?? 0;
  }

  @override
  void didUpdateWidget(covariant PracticeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTab != null && widget.initialTab != oldWidget.initialTab) {
      setState(() {
        _selectedTab = widget.initialTab!;
      });
    }
  }

  void _onTabSelect(int tabIndex) {
    setState(() {
      _selectedTab = tabIndex;
    });
    if (widget.onTabChanged != null) {
      widget.onTabChanged!(tabIndex);
    }
  }

  List<ExamQuestionModel> get _filteredExamQuestions {
    return ExamVaultData.questions.where((q) {
      final matchesCategory = _selectedFilter == 'all' || q.categoryId == _selectedFilter;
      final matchesSearch = _examSearchQuery.isEmpty ||
          q.title.toLowerCase().contains(_examSearchQuery.toLowerCase()) ||
          q.questionText.toLowerCase().contains(_examSearchQuery.toLowerCase()) ||
          q.topicName.toLowerCase().contains(_examSearchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _examSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final quizzes = QuestionBankData.quizzes;
    final questions = QuestionBankData.allQuestions;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Hamburger Menu Icon
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu_rounded, color: isDark ? AppColors.neonPink : AppColors.lightPink, size: 28),
                    onPressed: () {
                      if (widget.onOpenDrawer != null) {
                        widget.onOpenDrawer!();
                      } else {
                        Scaffold.of(context).openDrawer();
                      }
                    },
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Practice & Assessment",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text1(context),
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Test your knowledge with quizzes & university exam vault.",
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

              const SizedBox(height: 16),

              // Segmented Tab Switcher (Quizzes | Question Bank | Exam Vault)
              Container(
                height: 44,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceGlassDark : const Color(0x8CFFFFFF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: (isDark ? AppColors.neonPink : AppColors.lightPink).withAlpha(40)),
                ),
                child: Row(
                  children: [
                    _SegmentTab(
                      label: "QUIZZES",
                      isSelected: _selectedTab == 0,
                      color: isDark ? AppColors.neonPink : AppColors.lightPink,
                      onTap: () => _onTabSelect(0),
                    ),
                    _SegmentTab(
                      label: "QUESTION BANK",
                      isSelected: _selectedTab == 1,
                      color: isDark ? AppColors.neonCyan : AppColors.lightPurple,
                      onTap: () => _onTabSelect(1),
                    ),
                    _SegmentTab(
                      label: "EXAM VAULT",
                      isSelected: _selectedTab == 2,
                      color: isDark ? AppColors.neonGold : AppColors.lightGold,
                      onTap: () => _onTabSelect(2),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // TAB 0: QUIZZES
              if (_selectedTab == 0) ...[
                SectionHeader(
                  title: "Featured OS Quizzes",
                  subtitle: "Select a topic quiz to begin test run",
                  accentColor: isDark ? AppColors.neonPink : AppColors.lightPink,
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: quizzes.length,
                  itemBuilder: (context, index) {
                    final quiz = quizzes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: NeonCard(
                        accentColor: quiz.accentColor,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizRunnerScreen(quiz: quiz),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: quiz.accentColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: quiz.accentColor, width: 1.2),
                              ),
                              child: Icon(
                                quiz.icon,
                                color: quiz.accentColor,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    quiz.title,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.text1(context),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    quiz.description,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.text2(context),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(Icons.quiz_outlined, size: 12, color: quiz.accentColor),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${quiz.totalQuestions} Questions",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: quiz.accentColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.play_circle_fill_rounded,
                              color: quiz.accentColor,
                              size: 32,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],

              // TAB 1: QUESTION BANK
              if (_selectedTab == 1) ...[
                // Filter chips
                SizedBox(
                  height: 36,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      NeonChip(
                        label: "All Questions (${questions.length})",
                        isSelected: _selectedFilter == 'all',
                        accentColor: isDark ? AppColors.neonCyan : AppColors.lightPurple,
                        onTap: () => setState(() => _selectedFilter = 'all'),
                      ),
                      const SizedBox(width: 8),
                      NeonChip(
                        label: "CPU Scheduling",
                        isSelected: _selectedFilter == 'cat_cpu',
                        accentColor: isDark ? AppColors.neonPurple : AppColors.lightPurple,
                        onTap: () => setState(() => _selectedFilter = 'cat_cpu'),
                      ),
                      const SizedBox(width: 8),
                      NeonChip(
                        label: "Memory Management",
                        isSelected: _selectedFilter == 'cat_memory',
                        accentColor: isDark ? AppColors.neonGreen : AppColors.lightGreen,
                        onTap: () => setState(() => _selectedFilter = 'cat_memory'),
                      ),
                      const SizedBox(width: 8),
                      NeonChip(
                        label: "Deadlock",
                        isSelected: _selectedFilter == 'cat_deadlock',
                        accentColor: isDark ? AppColors.neonGold : AppColors.lightGold,
                        onTap: () => setState(() => _selectedFilter = 'cat_deadlock'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                SectionHeader(
                  title: "Question Pool",
                  subtitle: "Browse questions by topic",
                  accentColor: isDark ? AppColors.neonCyan : AppColors.lightPurple,
                ),

                const SizedBox(height: 12),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: questions
                      .where((q) => _selectedFilter == 'all' || q.categoryId == _selectedFilter)
                      .length,
                  itemBuilder: (context, index) {
                    final filteredQuestions = questions
                        .where((q) => _selectedFilter == 'all' || q.categoryId == _selectedFilter)
                        .toList();
                    final q = filteredQuestions[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GlassContainer(
                        padding: const EdgeInsets.all(14),
                        borderColor: (isDark ? AppColors.neonCyan : AppColors.lightPurple).withAlpha(40),
                        onTap: () {
                          final singleQuiz = QuizModel(
                            id: 'single_${q.id}',
                            title: q.topicName,
                            description: 'Question Practice',
                            icon: Icons.help_outline_rounded,
                            accentColor: isDark ? AppColors.neonCyan : AppColors.lightPurple,
                            questions: [q],
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizRunnerScreen(quiz: singleQuiz),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: (isDark ? AppColors.neonCyan : AppColors.lightPurple).withAlpha(30),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    q.topicName.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? AppColors.neonCyan : AppColors.lightPurple,
                                    ),
                                  ),
                                ),
                                Text(
                                  q.type.name.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textM(context),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              q.questionText,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text1(context),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${q.options.length} Answer Choices",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.text2(context),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Solve Question",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: isDark ? AppColors.neonCyan : AppColors.lightPurple,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(Icons.arrow_forward_rounded, size: 12, color: isDark ? AppColors.neonCyan : AppColors.lightPurple),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],

              // TAB 2: EXAM VAULT
              if (_selectedTab == 2) ...[
                // Search Input Bar
                CustomSearchBar(
                  controller: _examSearchController,
                  hintText: "Search exam problems, algorithms...",
                  onChanged: (val) {
                    setState(() {
                      _examSearchQuery = val;
                    });
                  },
                ),

                const SizedBox(height: 14),

                // Category filter chips
                SizedBox(
                  height: 36,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      NeonChip(
                        label: "All Exam Questions (${ExamVaultData.questions.length})",
                        isSelected: _selectedFilter == 'all',
                        accentColor: isDark ? AppColors.neonGold : AppColors.lightGold,
                        onTap: () => setState(() => _selectedFilter = 'all'),
                      ),
                      const SizedBox(width: 8),
                      NeonChip(
                        label: "OS Basics",
                        isSelected: _selectedFilter == 'cat_basics',
                        accentColor: isDark ? AppColors.neonCyan : AppColors.lightCyan,
                        onTap: () => setState(() => _selectedFilter = 'cat_basics'),
                      ),
                      const SizedBox(width: 8),
                      NeonChip(
                        label: "Process Mgmt",
                        isSelected: _selectedFilter == 'cat_process',
                        accentColor: isDark ? AppColors.neonPink : AppColors.lightPink,
                        onTap: () => setState(() => _selectedFilter = 'cat_process'),
                      ),
                      const SizedBox(width: 8),
                      NeonChip(
                        label: "CPU Scheduling",
                        isSelected: _selectedFilter == 'cat_cpu',
                        accentColor: isDark ? AppColors.neonPurple : AppColors.lightPurple,
                        onTap: () => setState(() => _selectedFilter = 'cat_cpu'),
                      ),
                      const SizedBox(width: 8),
                      NeonChip(
                        label: "Process Sync",
                        isSelected: _selectedFilter == 'cat_sync',
                        accentColor: isDark ? AppColors.neonBlue : AppColors.lightBlue,
                        onTap: () => setState(() => _selectedFilter = 'cat_sync'),
                      ),
                      const SizedBox(width: 8),
                      NeonChip(
                        label: "Deadlock",
                        isSelected: _selectedFilter == 'cat_deadlock',
                        accentColor: isDark ? AppColors.neonGold : AppColors.lightGold,
                        onTap: () => setState(() => _selectedFilter = 'cat_deadlock'),
                      ),
                      const SizedBox(width: 8),
                      NeonChip(
                        label: "Memory Mgmt",
                        isSelected: _selectedFilter == 'cat_memory',
                        accentColor: isDark ? AppColors.neonGreen : AppColors.lightGreen,
                        onTap: () => setState(() => _selectedFilter = 'cat_memory'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                SectionHeader(
                  title: "University Exam Vault",
                  subtitle: "Official exam questions compiled from university assessments",
                  accentColor: isDark ? AppColors.neonGold : AppColors.lightGold,
                ),

                const SizedBox(height: 12),

                if (_filteredExamQuestions.isEmpty) ...[
                  GlassContainer(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.search_off_rounded, color: AppColors.textM(context), size: 40),
                          const SizedBox(height: 8),
                          Text(
                            "No exam questions match your search.",
                            style: TextStyle(color: AppColors.text2(context), fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredExamQuestions.length,
                    itemBuilder: (context, index) {
                      final examQ = _filteredExamQuestions[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ExamQuestionCard(
                          question: examQ,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExamQuestionDetailScreen(question: examQ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SegmentTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _SegmentTab({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: color.withAlpha(isDark ? 100 : 50),
                      blurRadius: 10,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? (isDark ? Colors.black : Colors.white)
                        : AppColors.text2(context),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
