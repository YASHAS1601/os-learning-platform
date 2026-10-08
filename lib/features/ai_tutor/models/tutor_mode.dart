import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

enum TutorMode {
  askTutor,
  explainSimply,
  solveWithMe,
  generatePractice,
  quizMe,
  explainCode,
}

extension TutorModeExtension on TutorMode {
  String get label {
    switch (this) {
      case TutorMode.askTutor:
        return 'Ask Tutor';
      case TutorMode.explainSimply:
        return 'Explain Simply';
      case TutorMode.solveWithMe:
        return 'Solve With Me';
      case TutorMode.generatePractice:
        return 'Practice With Me';
      case TutorMode.quizMe:
        return 'Quiz Me';
      case TutorMode.explainCode:
        return 'Explain Code';
    }
  }

  String get description {
    switch (this) {
      case TutorMode.askTutor:
        return 'Ask any Operating Systems question';
      case TutorMode.explainSimply:
        return 'Simplified explanations with analogies';
      case TutorMode.solveWithMe:
        return 'Step-by-step problem guidance';
      case TutorMode.generatePractice:
        return 'Generate topic practice questions';
      case TutorMode.quizMe:
        return 'Interactive quiz evaluation';
      case TutorMode.explainCode:
        return 'Line-by-line OS code explanation';
    }
  }

  IconData get icon {
    switch (this) {
      case TutorMode.askTutor:
        return Icons.chat_bubble_outline_rounded;
      case TutorMode.explainSimply:
        return Icons.lightbulb_outline_rounded;
      case TutorMode.solveWithMe:
        return Icons.extension_outlined;
      case TutorMode.generatePractice:
        return Icons.fitness_center_rounded;
      case TutorMode.quizMe:
        return Icons.quiz_outlined;
      case TutorMode.explainCode:
        return Icons.code_rounded;
    }
  }

  Color get color {
    switch (this) {
      case TutorMode.askTutor:
        return AppColors.neonPurple;
      case TutorMode.explainSimply:
        return AppColors.neonCyan;
      case TutorMode.solveWithMe:
        return AppColors.neonPink;
      case TutorMode.generatePractice:
        return AppColors.neonGreen;
      case TutorMode.quizMe:
        return AppColors.neonGold;
      case TutorMode.explainCode:
        return AppColors.neonBlue;
    }
  }
}
