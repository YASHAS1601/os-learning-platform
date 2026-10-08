import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/services/supabase_service.dart';
import '../repositories/user_profile_repository.dart';
import '../../learn/repositories/user_progress_repository.dart';
import '../../practice/repositories/quiz_result_repository.dart';
import '../models/user_profile.dart';

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

  UserProfile? _profile;
  int _completedTopics = 0;
  int _quizCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
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

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final accentBlue = isDark ? AppColors.neonBlue : AppColors.iconPrimaryLight;
    final accentCyan = isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight;

    final service = SupabaseService.instance;
    final userName = _profile?.name ?? service.userName ?? "OS Scholar";
    final userEmail = _profile?.email ?? service.userEmail ?? "student@oslearningplatform.edu";
    final avatarUrl = _profile?.avatarUrl ?? service.avatarUrl;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
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
                          ),
                          const SizedBox(height: 2),
                          Text(
                            userEmail,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.text2(context),
                            ),
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

              const SizedBox(height: 24),

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
                        Text(
                          "Overall OS Mastery",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text1(context),
                          ),
                        ),
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
                childAspectRatio: 1.6,
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
              ),            ],
          ),
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
      padding: const EdgeInsets.all(12),
      borderColor: color.withAlpha(isDark ? 40 : 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textM(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
    );
  }
}
