class ExamQuestionModel {
  final String id;
  final String title;
  final String questionText;
  final String marks;
  final String categoryId;
  final String topicName;
  final String internalYearMetadata;

  const ExamQuestionModel({
    required this.id,
    required this.title,
    required this.questionText,
    required this.marks,
    required this.categoryId,
    required this.topicName,
    required this.internalYearMetadata,
  });
}
