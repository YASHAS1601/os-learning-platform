import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/services/supabase_service.dart';
import '../repositories/user_profile_repository.dart';
import '../../learn/repositories/user_progress_repository.dart';
import '../../practice/repositories/quiz_result_repository.dart';
import '../../../core/widgets/neon_button.dart';
import '../models/user_profile.dart';
import '../models/wrong_question_model.dart';
import '../repositories/personalized_learning_repository.dart';
import 'personalized_quiz_screen.dart';
import '../../ai_tutor/models/tutor_context_model.dart';
import '../../ai_tutor/models/tutor_mode.dart';
import '../../ai_tutor/presentation/ai_tutor_screen.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback? onOpenDrawer;

  const ProfileScreen({
    super.key,
    this.onOpenDrawer,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProfileRepository _profileRepo = UserProfileRepository();
  final UserProgressRepository _progressRepo = UserProgressRepository();
  final QuizResultRepository _quizRepo = QuizResultRepository();
  final PersonalizedLearningRepository _personalizedRepo = PersonalizedLearningRepository.instance;

  UserProfile? _profile;
  int _completedTopics = 0;
  int _quizCount = 0;

  int _selectedTabIndex = 0; // 0 = Overview, 1 = Personalized Tab
  List<WrongQuestionModel> _allWrongQuestions = [];
  List<WrongQuestionModel> _pendingWrongQuestions = [];
  Map<String, List<WrongQuestionModel>> _groupedWrongQuestions = {};
  String? _selectedTopicFilter;
  bool _showOnlyPending = false;
  bool _isLoadingPersonalized = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final allList = await _personalizedRepo.getAllQuestions(includeMastered: true);
      final wrongList = await _personalizedRepo.getPendingQuestions();
      final grouped = await _personalizedRepo.getQuestionsGroupedByTopic();

      if (mounted) {
        setState(() {
          _allWrongQuestions = allList;
          _pendingWrongQuestions = wrongList;
          _groupedWrongQuestions = grouped;
          _isLoadingPersonalized = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoadingPersonalized = false;
        });
      }
    }

    final service = SupabaseService.instance;
    if (!service.isInitialized || !service.isAuthenticated) {
      return;
    }

    try {
      final profile = await _profileRepo.getProfile();
      final progressList = await _progressRepo.getProgress();
      final quizList = await _quizRepo.getQuizResults();

      if (mounted) {
        setState(() {
          _profile = profile;
          _completedTopics = progressList.where((p) => p.completed).length;
          _quizCount = quizList.length;
        });
      }
    } catch (_) {}
  }

  Future<void> _seedSampleMistakes() async {
    await _personalizedRepo.seedSampleMistakesIfEmpty();
    await _loadUserData();
  }

  List<WrongQuestionModel> get _displayedQuestions {
    List<WrongQuestionModel> list = _allWrongQuestions;

    if (_showOnlyPending) {
      list = list.where((q) => !q.isMastered).toList();
    }

    if (_selectedTopicFilter != null && _selectedTopicFilter!.isNotEmpty) {
      list = list.where((q) => q.topicId == _selectedTopicFilter).toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final accentBlue = isDark ? AppColors.neonBlue : AppColors.iconPrimaryLight;
    final accentCyan = isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight;
    final accentPurple = isDark ? AppColors.neonPurple : AppColors.iconActiveLight;

    final service = SupabaseService.instance;
    final userName = _profile?.name ?? service.userName ?? "OS Scholar";
    final userEmail = _profile?.email ?? service.userEmail ?? "student@oslearningplatform.edu";
    final avatarUrl = _profile?.avatarUrl ?? service.avatarUrl;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Title with Hamburger Icon
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu_rounded, color: accentBlue, size: 28),
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
                    child: Text(
                      "Student Profile",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text1(context),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // User Info Glass Header Card
              GlassContainer(
                padding: const EdgeInsets.all(20),
                borderColor: accentBlue.withAlpha(isDark ? 70 : 40),
                glowShadow: BoxShadow(
                  color: accentBlue.withAlpha(isDark ? 40 : 20),
                  blurRadius: 16,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: accentBlue.withAlpha(30),
                        border: Border.all(color: accentBlue, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: accentBlue.withAlpha(isDark ? 100 : 40),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: avatarUrl != null && avatarUrl.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.network(
                                avatarUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Icon(
                                  Icons.person_rounded,
                                  color: accentBlue,
                                  size: 36,
                                ),
                              ),
                            )
                          : Icon(
                              Icons.person_rounded,
                              color: accentBlue,
                              size: 36,
                            ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text1(context),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            userEmail,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.text2(context),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: accentCyan.withAlpha(30),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: accentCyan, width: 0.8),
                            ),
                            child: Text(
                              service.isAuthenticated ? "SUPABASE VERIFIED" : "PRO LEARNER",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: accentCyan,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Segmented Tab Selector Bar: Overview vs Personalized Learning
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.cardGlass(context),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? AppColors.glassBorder : const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => setState(() => _selectedTabIndex = 0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _selectedTabIndex == 0
                                ? (isDark ? accentBlue.withAlpha(60) : accentBlue.withAlpha(35))
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: _selectedTabIndex == 0
                                ? Border.all(color: accentBlue, width: 1.2)
                                : null,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.dashboard_rounded,
                                    size: 16,
                                    color: _selectedTabIndex == 0 ? accentBlue : AppColors.textM(context)),
                                const SizedBox(width: 6),
                                Text(
                                  "Overview",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: _selectedTabIndex == 0 ? accentBlue : AppColors.textM(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => setState(() => _selectedTabIndex = 1),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _selectedTabIndex == 1
                                ? (isDark ? accentPurple.withAlpha(60) : accentPurple.withAlpha(35))
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: _selectedTabIndex == 1
                                ? Border.all(color: accentPurple, width: 1.2)
                                : null,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.psychology_alt_rounded,
                                    size: 16,
                                    color: _selectedTabIndex == 1 ? accentPurple : AppColors.textM(context)),
                                const SizedBox(width: 6),
                                Text(
                                  "Personalized",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: _selectedTabIndex == 1 ? accentPurple : AppColors.textM(context),
                                  ),
                                ),
                                if (_allWrongQuestions.isNotEmpty) ...[
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent.withAlpha(220),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "${_allWrongQuestions.length}",
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // TAB 0: OVERVIEW TAB CONTENT
              if (_selectedTabIndex == 0) ...[
                // Learning Statistics Section
                SectionHeader(
                  title: "Learning Progress Summary",
                  subtitle: "Your overall study performance",
                  accentColor: accentCyan,
                ),

                const SizedBox(height: 12),

                // Progress Bar Card
                GlassContainer(
                  padding: const EdgeInsets.all(16),
                  borderColor: accentCyan.withAlpha(isDark ? 40 : 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Overall OS Mastery",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text1(context),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${(_completedTopics / 64 * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: accentCyan,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: (_completedTopics / 64).clamp(0.0, 1.0),
                          backgroundColor: isDark ? AppColors.surfaceDark : const Color(0xFFE2E8F0),
                          color: accentCyan,
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "$_completedTopics of 64 Operating System topics completed.",
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textM(context),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 4 Metric Grid Tiles
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _StatTile(
                      icon: Icons.book_rounded,
                      title: "Topics Done",
                      value: "$_completedTopics / 64",
                      color: accentCyan,
                    ),
                    _StatTile(
                      icon: Icons.quiz_rounded,
                      title: "Quizzes Saved",
                      value: "$_quizCount",
                      color: isDark ? AppColors.neonPink : AppColors.iconPrimaryLight,
                    ),
                    _StatTile(
                      icon: Icons.emoji_events_rounded,
                      title: "Quiz Accuracy",
                      value: _quizCount > 0 ? "88%" : "N/A",
                      color: isDark ? AppColors.neonGold : AppColors.iconPrimaryLight,
                    ),
                    _StatTile(
                      icon: Icons.local_fire_department_rounded,
                      title: "Study Streak",
                      value: "5 Days",
                      color: isDark ? AppColors.neonGreen : AppColors.iconPrimaryLight,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Quick jump to Personalized tab banner
                GlassContainer(
                  padding: const EdgeInsets.all(16),
                  borderColor: accentPurple.withAlpha(isDark ? 100 : 60),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: accentPurple.withAlpha(35),
                        ),
                        child: Icon(Icons.psychology_alt_rounded, color: accentPurple, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Personalized Learning Vault",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text1(context),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _allWrongQuestions.isNotEmpty
                                  ? "${_allWrongQuestions.length} mistake(s) tracked across quizzes with hints & mnemonics."
                                  : "Review questions you missed across all quizzes with mnemonics.",
                              style: TextStyle(
                                fontSize: 11.5,
                                color: AppColors.text2(context),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => setState(() => _selectedTabIndex = 1),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("View", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],

              // TAB 1: PERSONALIZED LEARNING TAB (ALL WRONG QUESTIONS ACROSS ALL QUIZZES)
              if (_selectedTabIndex == 1) ...[
                // Section Header
                SectionHeader(
                  title: "Personalized Mistake Vault",
                  subtitle: "All questions you marked incorrectly across quizzes with hints and mnemonics",
                  accentColor: accentPurple,
                ),

                const SizedBox(height: 12),

                // Action Summary & Launch Quiz Card
                if (_allWrongQuestions.isNotEmpty) ...[
                  GlassContainer(
                    padding: const EdgeInsets.all(16),
                    borderColor: accentPurple.withAlpha(isDark ? 120 : 70),
                    glowShadow: BoxShadow(
                      color: accentPurple.withAlpha(isDark ? 40 : 20),
                      blurRadius: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: accentPurple.withAlpha(35),
                                    ),
                                    child: Icon(Icons.history_edu_rounded, size: 20, color: accentPurple),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${_allWrongQuestions.length} Total Marked Questions",
                                          style: TextStyle(
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.text1(context),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${_pendingWrongQuestions.length} pending • ${_allWrongQuestions.length - _pendingWrongQuestions.length} mastered",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: AppColors.text2(context),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.amber.withAlpha(30),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.amber.withAlpha(120), width: 0.8),
                              ),
                              child: const Text(
                                "ALL QUIZZES",
                                style: TextStyle(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amberAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        NeonButton(
                          text: _pendingWrongQuestions.isNotEmpty
                              ? "Launch Quiz (${_pendingWrongQuestions.length} Pending)"
                              : "Review Questions (${_allWrongQuestions.length})",
                          icon: Icons.play_arrow_rounded,
                          glowColor: accentPurple,
                          onPressed: () {
                            final questionsToQuiz = _pendingWrongQuestions.isNotEmpty
                                ? _pendingWrongQuestions
                                : _allWrongQuestions;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PersonalizedQuizScreen(
                                  title: "Personalized Mistake Quiz",
                                  questions: questionsToQuiz,
                                  onQuizCompleted: _loadUserData,
                                ),
                              ),
                            ).then((_) => _loadUserData());
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Filter Row: Topics & Status
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        // All Topics Chip
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text("All Topics (${_allWrongQuestions.length})"),
                            selected: _selectedTopicFilter == null,
                            selectedColor: accentPurple.withAlpha(60),
                            checkmarkColor: accentPurple,
                            labelStyle: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: _selectedTopicFilter == null ? accentPurple : AppColors.textM(context),
                            ),
                            backgroundColor: AppColors.cardGlass(context),
                            side: BorderSide(
                              color: _selectedTopicFilter == null ? accentPurple : AppColors.glassBorder,
                            ),
                            onSelected: (val) {
                              setState(() {
                                _selectedTopicFilter = null;
                              });
                            },
                          ),
                        ),

                        // Topic Chips
                        ..._groupedWrongQuestions.entries.map((entry) {
                          final topicId = entry.key;
                          final list = entry.value;
                          final isSelected = _selectedTopicFilter == topicId;
                          final topicTitle = list.first.topicName;

                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text("$topicTitle (${list.length})"),
                              selected: isSelected,
                              selectedColor: accentPurple.withAlpha(60),
                              checkmarkColor: accentPurple,
                              labelStyle: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? accentPurple : AppColors.textM(context),
                              ),
                              backgroundColor: AppColors.cardGlass(context),
                              side: BorderSide(
                                color: isSelected ? accentPurple : AppColors.glassBorder,
                              ),
                              onSelected: (val) {
                                setState(() {
                                  _selectedTopicFilter = isSelected ? null : topicId;
                                });
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Toggle for Pending vs All
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Showing ${_displayedQuestions.length} marked questions",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textM(context)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          Text(
                            "Pending Only",
                            style: TextStyle(
                              fontSize: 11,
                              color: _showOnlyPending ? accentCyan : AppColors.textM(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Switch(
                            value: _showOnlyPending,
                            activeColor: accentCyan,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onChanged: (val) {
                              setState(() {
                                _showOnlyPending = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // LIST OF ALL WRONG QUESTIONS
                  ..._displayedQuestions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final q = entry.value;
                    return _WrongQuestionCard(
                      questionNumber: index + 1,
                      question: q,
                      isDark: isDark,
                      accentPurple: accentPurple,
                      accentCyan: accentCyan,
                      onToggleMastered: () async {
                        await _personalizedRepo.toggleMastered(q.questionId);
                        await _loadUserData();
                      },
                      onRetakeSingle: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonalizedQuizScreen(
                              title: "Retake: ${q.topicName}",
                              questions: [q],
                              onQuizCompleted: _loadUserData,
                            ),
                          ),
                        ).then((_) => _loadUserData());
                      },
                      onAskRiyah: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AiTutorScreen(
                              initialMode: TutorMode.solveWithMe,
                              initialContext: TutorContextModel(
                                questionText: q.questionText,
                                topicTitle: q.topicName,
                                selectedAnswer: q.options.isNotEmpty && q.userSelectedOptionIndex >= 0 && q.userSelectedOptionIndex < q.options.length
                                    ? q.options[q.userSelectedOptionIndex]
                                    : null,
                                correctAnswer: q.options.isNotEmpty && q.correctOptionIndex < q.options.length
                                    ? q.options[q.correctOptionIndex]
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ] else ...[
                  // Empty State for Personalized Tab
                  GlassContainer(
                    padding: const EdgeInsets.all(24),
                    borderColor: accentPurple.withAlpha(isDark ? 80 : 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accentPurple.withAlpha(30),
                          ),
                          child: Icon(Icons.check_circle_outline_rounded, color: accentPurple, size: 36),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No Wrong Questions Recorded Yet!",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text1(context),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Whenever you take any quiz in the Learn or Practice sections, any question you miss will automatically appear here with custom hints and memory mnemonics.",
                          style: TextStyle(
                            fontSize: 12.5,
                            color: AppColors.text2(context),
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.science_rounded, size: 16),
                          label: const Text("Populate 2 Sample Mistakes to Test"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: accentPurple,
                            side: BorderSide(color: accentPurple.withAlpha(150)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          ),
                          onPressed: _seedSampleMistakes,
                        ),
                      ],
                    ),
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

class _WrongQuestionCard extends StatelessWidget {
  final int questionNumber;
  final WrongQuestionModel question;
  final bool isDark;
  final Color accentPurple;
  final Color accentCyan;
  final VoidCallback onToggleMastered;
  final VoidCallback onRetakeSingle;
  final VoidCallback onAskRiyah;

  const _WrongQuestionCard({
    required this.questionNumber,
    required this.question,
    required this.isDark,
    required this.accentPurple,
    required this.accentCyan,
    required this.onToggleMastered,
    required this.onRetakeSingle,
    required this.onAskRiyah,
  });

  @override
  Widget build(BuildContext context) {
    final userAnsText = question.options.isNotEmpty &&
            question.userSelectedOptionIndex >= 0 &&
            question.userSelectedOptionIndex < question.options.length
        ? "Option ${String.fromCharCode(65 + question.userSelectedOptionIndex)}: ${question.options[question.userSelectedOptionIndex]}"
        : "Incorrect Option";

    final correctAnsText = question.options.isNotEmpty &&
            question.correctOptionIndex >= 0 &&
            question.correctOptionIndex < question.options.length
        ? "Option ${String.fromCharCode(65 + question.correctOptionIndex)}: ${question.options[question.correctOptionIndex]}"
        : "Correct Option";

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: 16,
        borderColor: (question.isMastered ? Colors.green : Colors.redAccent).withAlpha(isDark ? 80 : 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Topic Badge, Question Index, Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: accentPurple.withAlpha(35),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: accentPurple.withAlpha(120), width: 0.8),
                        ),
                        child: Text(
                          "Q$questionNumber",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: accentPurple,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          question.topicName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text1(context),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: (question.isMastered ? Colors.green : Colors.amber).withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: (question.isMastered ? Colors.green : Colors.amber).withAlpha(120),
                      width: 0.8,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        question.isMastered ? Icons.check_circle_rounded : Icons.pending_rounded,
                        size: 11,
                        color: question.isMastered ? Colors.greenAccent : Colors.amberAccent,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        question.isMastered ? "MASTERED" : "NEEDS REVIEW",
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: question.isMastered ? Colors.greenAccent : Colors.amberAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Question Text
            Text(
              question.questionText,
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                color: AppColors.text1(context),
                height: 1.4,
              ),
            ),

            const SizedBox(height: 12),

            // Your Mistake Box
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(25),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.redAccent.withAlpha(100)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.cancel_rounded, color: Colors.redAccent, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "You Marked:",
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.redAccent),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          userAnsText,
                          style: TextStyle(fontSize: 12, color: isDark ? Colors.red.shade200 : Colors.red.shade900),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Correct Answer Box
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(25),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.withAlpha(120)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle_rounded, color: Colors.greenAccent, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Correct Answer:",
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.greenAccent),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          correctAnsText,
                          style: TextStyle(fontSize: 12, color: isDark ? Colors.green.shade200 : Colors.green.shade900),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Explanation
            Text(
              question.explanation,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.text2(context),
                height: 1.4,
              ),
            ),

            const SizedBox(height: 10),

            // 💡 Hint Box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.amber.withAlpha(25),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.withAlpha(100)),
              ),
              child: Text(
                question.hint,
                style: TextStyle(
                  fontSize: 11.5,
                  color: isDark ? Colors.amber.shade200 : Colors.amber.shade900,
                  height: 1.35,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // 🧠 Memory Mnemonic Box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: accentPurple.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: accentPurple.withAlpha(140)),
              ),
              child: Text(
                question.mnemonic,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.purple.shade200 : Colors.purple.shade900,
                  height: 1.35,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Action Buttons Row: Retake, Ask Riyah, Toggle Mastered
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.refresh_rounded, size: 14, color: accentCyan),
                    label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("Retake", style: TextStyle(fontSize: 11, color: accentCyan, fontWeight: FontWeight.bold)),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: accentCyan.withAlpha(120)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    ),
                    onPressed: onRetakeSingle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.psychology_rounded, size: 14, color: accentPurple),
                    label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("Ask Riyah", style: TextStyle(fontSize: 11, color: accentPurple, fontWeight: FontWeight.bold)),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: accentPurple.withAlpha(120)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    ),
                    onPressed: onAskRiyah,
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: question.isMastered ? "Mark Needs Review" : "Mark as Mastered",
                  icon: Icon(
                    question.isMastered ? Icons.check_circle_rounded : Icons.check_circle_outline_rounded,
                    color: question.isMastered ? Colors.greenAccent : AppColors.textM(context),
                    size: 22,
                  ),
                  onPressed: onToggleMastered,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      borderColor: color.withAlpha(isDark ? 40 : 30),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textM(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
