import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/neon_card.dart';
import '../models/topic_model.dart';
import '../data/os_topics_data.dart';
import '../repositories/user_progress_repository.dart';
import '../../practice/repositories/bookmark_repository.dart';
import 'widgets/concept_card.dart';
import 'widgets/step_by_step_box.dart';
import 'widgets/diagram_container.dart';
import 'widgets/formula_block.dart';
import 'widgets/practice_topic_btn.dart';
import 'widgets/why_we_need_it_box.dart';
import 'widgets/worked_example_box.dart';
import 'widgets/comparison_table_box.dart';
import 'widgets/real_world_apps_box.dart';
import 'widgets/exam_essentials_box.dart';
import 'widgets/common_mistakes_box.dart';
import 'widgets/concept_practice_box.dart';
import 'widgets/visualizers/visualizer_factory.dart';
import '../../practice/models/quiz_model.dart';
import '../../practice/presentation/quiz_runner_screen.dart';
import '../../practice/data/question_bank_data.dart';
import '../../ai_tutor/models/tutor_context_model.dart';
import '../../ai_tutor/models/tutor_mode.dart';
import '../../ai_tutor/presentation/ai_tutor_screen.dart';

class TopicDetailScreen extends StatefulWidget {
  final TopicModel topic;

  const TopicDetailScreen({
    super.key,
    required this.topic,
  });

  @override
  State<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> {
  final BookmarkRepository _bookmarkRepo = BookmarkRepository();
  final UserProgressRepository _progressRepo = UserProgressRepository();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _visualizerKey = GlobalKey();

  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _saveProgress();
    _checkBookmarkStatus();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _saveProgress() async {
    try {
      await _progressRepo.saveProgress(
        topic: widget.topic.title,
        completed: true,
        progress: 100,
      );
    } catch (_) {}
  }

  Future<void> _checkBookmarkStatus() async {
    try {
      final bookmarked = await _bookmarkRepo.isBookmarked('topic', widget.topic.id);
      if (mounted) setState(() => _isBookmarked = bookmarked);
    } catch (_) {}
  }

  Future<void> _toggleBookmark() async {
    try {
      final newStatus = await _bookmarkRepo.toggleBookmark('topic', widget.topic.id);
      if (mounted) {
        setState(() => _isBookmarked = newStatus);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              newStatus
                  ? 'Saved "${widget.topic.title}" to bookmarks!'
                  : 'Removed "${widget.topic.title}" from bookmarks.',
            ),
            backgroundColor: AppColors.surfaceDark,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (_) {}
  }

  void _scrollToVisualizer() {
    final context = _visualizerKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final topic = widget.topic;
    final isDark = AppColors.isDark(context);
    final iconColor = isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight;
    final riyahIconColor = isDark ? AppColors.neonPurple : AppColors.iconActiveLight;

    final category = OsTopicsData.categories.firstWhere(
      (c) => c.id == topic.categoryId,
      orElse: () => OsTopicsData.categories.first,
    );

    // Compute Previous / Next Topics
    final topicIndex = OsTopicsData.allTopics.indexWhere((t) => t.id == topic.id);
    final prevTopic = topicIndex > 0 ? OsTopicsData.allTopics[topicIndex - 1] : null;
    final nextTopic = topicIndex != -1 && topicIndex < OsTopicsData.allTopics.length - 1
        ? OsTopicsData.allTopics[topicIndex + 1]
        : null;

    return Container(
      decoration: AppColors.bgDecoration(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Custom Glass App Bar
              SliverAppBar(
                floating: true,
                pinned: true,
                backgroundColor: isDark ? AppColors.backgroundSecondaryDark.withAlpha(200) : const Color(0x99FFFFFF),
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded, color: iconColor, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  topic.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text1(context),
                  ),
                ),
                actions: [
                  IconButton(
                    tooltip: 'Ask Riyah AI',
                    icon: Icon(Icons.psychology_rounded, color: riyahIconColor),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AiTutorScreen(
                            initialMode: TutorMode.explainSimply,
                            initialContext: TutorContextModel(
                              topicTitle: topic.title,
                              categoryName: category.title,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                      color: _isBookmarked
                          ? (isDark ? AppColors.neonGold : AppColors.iconActiveLight)
                          : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                    ),
                    onPressed: _toggleBookmark,
                  ),
                ],
              ),

              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Category & Metadata Badges Header
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: (isDark ? category.accentColor : AppColors.iconPrimaryLight).withAlpha(isDark ? 40 : 25),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: isDark ? category.accentColor : AppColors.iconPrimaryLight, width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(category.icon, size: 12, color: isDark ? category.accentColor : AppColors.iconPrimaryLight),
                              const SizedBox(width: 6),
                              Text(
                                category.title.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? category.accentColor : AppColors.iconPrimaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Difficulty Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: (isDark ? AppColors.neonCyan : AppColors.iconActiveLight).withAlpha(30),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, width: 1),
                          ),
                          child: Text(
                            topic.difficulty.toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Reading Time
                        Row(
                          children: [
                            Icon(Icons.schedule_rounded, size: 12, color: AppColors.text2(context)),
                            const SizedBox(width: 4),
                            Text(
                              topic.readingTime,
                              style: TextStyle(fontSize: 11, color: AppColors.text2(context)),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Text(
                      topic.title,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text1(context),
                        letterSpacing: -0.5,
                      ),
                    ),

                    const SizedBox(height: 8),
                    Text(
                      topic.shortIntro,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.text2(context),
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Visualize Concept Quick Action Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _scrollToVisualizer,
                        icon: const Icon(Icons.play_circle_fill_rounded, size: 20),
                        label: const Text('Visualize Concept / Launch Visual Lab'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight,
                          foregroundColor: isDark ? Colors.black : Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Section 1: Definition (What Is It?)
                    ConceptCard(
                      title: "WHAT IS IT?",
                      content: topic.definition,
                      icon: Icons.menu_book_rounded,
                      accentColor: category.accentColor,
                    ),

                    const SizedBox(height: 20),

                    // Section 2: Why Do We Need It?
                    if (topic.whyWeNeedIt != null) ...[
                      WhyWeNeedItBox(
                        whyWeNeedIt: topic.whyWeNeedIt!,
                        analogy: topic.analogy,
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Section 3: How It Works
                    NeonCard(
                      accentColor: isDark ? AppColors.neonPurple : AppColors.iconActiveLight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.psychology_alt_rounded, color: isDark ? AppColors.neonPurple : AppColors.iconActiveLight, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                "How It Works",
                                style: TextStyle(
                                  color: isDark ? AppColors.textPrimaryDark : AppColors.iconActiveLight,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            topic.conceptExplanation,
                            style: TextStyle(
                              color: AppColors.text1(context),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Section 4: Diagram Section (if available)
                    if (topic.diagramTitle != null && topic.diagramNodes.isNotEmpty) ...[
                      DiagramContainer(
                        title: topic.diagramTitle!,
                        nodes: topic.diagramNodes,
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Step-by-Step Execution
                    if (topic.executionSteps.isNotEmpty) ...[
                      StepByStepBox(steps: topic.executionSteps),
                      const SizedBox(height: 20),
                    ],

                    // Section 5: INTERACTIVE VISUAL LAB WIDGET ENGINE
                    KeyedSubtree(
                      key: _visualizerKey,
                      child: VisualizerFactory(topic: topic),
                    ),
                    const SizedBox(height: 20),

                    // Section 6: Worked Example
                    if (topic.workedExample != null) ...[
                      WorkedExampleBox(example: topic.workedExample!),
                      const SizedBox(height: 20),
                    ],

                    // Section 7: Formulas & Complexity
                    if (topic.formula != null || topic.timeComplexity != null) ...[
                      FormulaBlock(
                        formula: topic.formula,
                        timeComplexity: topic.timeComplexity,
                        spaceComplexity: topic.spaceComplexity,
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Section 8: Comparison Table
                    if (topic.comparisonTable != null) ...[
                      ComparisonTableBox(table: topic.comparisonTable!),
                      const SizedBox(height: 20),
                    ],

                    // Section 9: Advantages & Disadvantages
                    if (topic.advantages.isNotEmpty || topic.disadvantages.isNotEmpty) ...[
                      GlassContainer(
                        padding: const EdgeInsets.all(16),
                        borderColor: (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(isDark ? 40 : 30),
                        color: isDark ? null : const Color(0xE6FFFFFF),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pros & Cons",
                              style: TextStyle(
                                color: isDark ? AppColors.textPrimaryDark : AppColors.iconActiveLight,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (topic.advantages.isNotEmpty)
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "✓ Advantages",
                                          style: TextStyle(
                                            color: isDark ? AppColors.success : const Color(0xFF1B7A66),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        ...topic.advantages.map((adv) => Padding(
                                              padding: const EdgeInsets.only(bottom: 6),
                                              child: Text(
                                                "• $adv",
                                                style: TextStyle(
                                                  color: AppColors.text2(context),
                                                  fontSize: 12,
                                                  height: 1.3,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                if (topic.advantages.isNotEmpty && topic.disadvantages.isNotEmpty)
                                  const SizedBox(width: 12),
                                if (topic.disadvantages.isNotEmpty)
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "✗ Disadvantages",
                                          style: TextStyle(
                                            color: isDark ? AppColors.error : const Color(0xFFC5221F),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        ...topic.disadvantages.map((dis) => Padding(
                                              padding: const EdgeInsets.only(bottom: 6),
                                              child: Text(
                                                "• $dis",
                                                style: TextStyle(
                                                  color: AppColors.text2(context),
                                                  fontSize: 12,
                                                  height: 1.3,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Section 10: Real-World Applications
                    if (topic.realWorldApplications.isNotEmpty) ...[
                      RealWorldAppsBox(applications: topic.realWorldApplications),
                      const SizedBox(height: 20),
                    ],

                    // Section 11: Exam Essentials
                    if (topic.examEssentials.isNotEmpty) ...[
                      ExamEssentialsBox(essentials: topic.examEssentials),
                      const SizedBox(height: 20),
                    ],

                    // Section 12: Common Mistakes
                    if (topic.commonMistakes.isNotEmpty) ...[
                      CommonMistakesBox(mistakes: topic.commonMistakes),
                      const SizedBox(height: 20),
                    ],

                    // Key Vocabulary
                    if (topic.keyTerms.isNotEmpty) ...[
                      Text(
                        "Key Vocabulary",
                        style: TextStyle(
                          color: isDark ? AppColors.textPrimaryDark : AppColors.iconActiveLight,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...topic.keyTerms.map((kt) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: GlassContainer(
                              padding: const EdgeInsets.all(12),
                              borderColor: (isDark ? AppColors.neonPurple : AppColors.iconPrimaryLight).withAlpha(isDark ? 30 : 40),
                              color: isDark ? null : const Color(0xE6FFFFFF),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    kt.term,
                                    style: TextStyle(
                                      color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    kt.definition,
                                    style: TextStyle(
                                      color: AppColors.text2(context),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      const SizedBox(height: 20),
                    ],

                    // Section 13: Practice & Test Yourself
                    if (topic.practiceQuestions.isNotEmpty) ...[
                      ConceptPracticeBox(questions: topic.practiceQuestions),
                      const SizedBox(height: 20),
                    ],

                    // Practice Question Bank Button
                    PracticeTopicBtn(
                      topicTitle: topic.title,
                      onPressed: () {
                        final matchingQuestions = QuestionBankData.getQuestionsForTopic(topic.id);

                        final quiz = QuizModel(
                          id: 'quiz_${topic.id}',
                          title: '${topic.title} Practice',
                          description: '10–15 Concept MCQs for ${topic.title}',
                          icon: category.icon,
                          accentColor: category.accentColor,
                          questions: matchingQuestions.isNotEmpty
                              ? matchingQuestions
                              : QuestionBankData.allQuestions.take(10).toList(),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizRunnerScreen(quiz: quiz),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Section 14: Previous / Next Navigation
                    Row(
                      children: [
                        if (prevTopic != null)
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TopicDetailScreen(topic: prevTopic),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.arrow_back_rounded, size: 16),
                              label: Text(
                                prevTopic.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 11),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                                side: BorderSide(color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          )
                        else
                          const Spacer(),
                        const SizedBox(width: 12),
                        if (nextTopic != null)
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TopicDetailScreen(topic: nextTopic),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                              label: Text(
                                nextTopic.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 11),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight,
                                foregroundColor: isDark ? Colors.black : Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          )
                        else
                          const Spacer(),
                      ],
                    ),

                    const SizedBox(height: 40),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
