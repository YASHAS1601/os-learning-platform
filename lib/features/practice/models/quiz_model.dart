import 'package:flutter/material.dart';
import 'question_model.dart';

class QuizModel {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;
  final List<QuestionModel> questions;

  const QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.questions,
  });

  int get totalQuestions => questions.length;
}
