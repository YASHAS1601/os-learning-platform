enum QuestionType {
  mcq,
  numerical,
  concept,
  algorithm,
  assertionReason,
  scenario,
  university,
  viva,
  placement,
}

enum QuestionDifficulty { easy, medium, hard }

class QuestionModel {
  final String id;
  final String topicId;
  final String topicName;
  final String categoryId;
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;
  final QuestionType type;
  final QuestionDifficulty difficulty;

  const QuestionModel({
    required this.id,
    required this.topicId,
    required this.topicName,
    required this.categoryId,
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
    this.type = QuestionType.mcq,
    this.difficulty = QuestionDifficulty.medium,
  });
}
