import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../models/tutor_mode.dart';

class RiyahWelcomeCard extends StatelessWidget {
  final ValueChanged<TutorMode> onModeSelected;
  final ValueChanged<String> onPromptSelected;

  static const List<String> suggestedPrompts = [
    "Explain FCFS simply",
    "What is a deadlock?",
    "Explain paging with an example",
    "What is the difference between a process and a thread?",
    "Explain Peterson's solution",
    "Help me understand Banker’s Algorithm",
  ];

  const RiyahWelcomeCard({
    super.key,
    required this.onModeSelected,
    required this.onPromptSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final purpleAccent = isDark ? AppColors.neonPurple : AppColors.iconActiveLight;
    final cyanAccent = isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Friendly Riyah Welcome Banner
          GlassContainer(
            padding: const EdgeInsets.all(20),
            borderColor: purpleAccent.withAlpha(isDark ? 70 : 40),
            color: purpleAccent.withAlpha(isDark ? 15 : 10),
            glowShadow: BoxShadow(
              color: purpleAccent.withAlpha(isDark ? 50 : 20),
              blurRadius: 18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Meet Riyah 👋",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text1(context),
                        letterSpacing: -0.4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "I can help you understand Operating Systems concepts, solve problems, practice algorithms, and prepare for exams.",
                  style: TextStyle(
                    fontSize: 13.5,
                    color: AppColors.text2(context),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.cardGlass(context),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: purpleAccent.withAlpha(40)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.handshake_rounded, color: cyanAccent, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        "Let's learn this together.",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: cyanAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // How Riyah Can Help (Mode Action Cards Grid)
          Text(
            "How Riyah Can Help You",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.text1(context),
            ),
          ),
          const SizedBox(height: 12),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _ActionCard(
                mode: TutorMode.explainSimply,
                title: "Explain Simply",
                subtitle: "Concepts & analogies",
                onTap: () => onModeSelected(TutorMode.explainSimply),
              ),
              _ActionCard(
                mode: TutorMode.solveWithMe,
                title: "Solve With Me",
                subtitle: "Step-by-step guidance",
                onTap: () => onModeSelected(TutorMode.solveWithMe),
              ),
              _ActionCard(
                mode: TutorMode.generatePractice,
                title: "Practice With Me",
                subtitle: "Custom problem sets",
                onTap: () => onModeSelected(TutorMode.generatePractice),
              ),
              _ActionCard(
                mode: TutorMode.quizMe,
                title: "Quiz Me",
                subtitle: "Interactive questions",
                onTap: () => onModeSelected(TutorMode.quizMe),
              ),
              _ActionCard(
                mode: TutorMode.explainCode,
                title: "Explain Code",
                subtitle: "OS code analysis",
                onTap: () => onModeSelected(TutorMode.explainCode),
              ),
              _ActionCard(
                mode: TutorMode.askTutor,
                title: "Ask Tutor",
                subtitle: "General OS questions",
                onTap: () => onModeSelected(TutorMode.askTutor),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Suggested Questions / Prompts
          Text(
            "Suggested Questions for Riyah",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.text1(context),
            ),
          ),
          const SizedBox(height: 10),

          ...suggestedPrompts.map((prompt) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GlassContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  borderColor: cyanAccent.withAlpha(isDark ? 30 : 25),
                  onTap: () => onPromptSelected(prompt),
                  child: Row(
                    children: [
                      Icon(Icons.help_outline_rounded, size: 16, color: cyanAccent),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          prompt,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.text1(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, size: 12, color: cyanAccent),
                    ],
                  ),
                ),
              )),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final TutorMode mode;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({
    required this.mode,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final modeColor = isDark ? mode.color : AppColors.iconPrimaryLight;

    return GlassContainer(
      padding: const EdgeInsets.all(10),
      borderColor: modeColor.withAlpha(50),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(mode.icon, color: modeColor, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: modeColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textM(context),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
