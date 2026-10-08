class TutorContextModel {
  final String? categoryName;
  final String? topicTitle;
  final String? subtopicTitle;
  final String? questionText;
  final String? selectedAnswer;
  final String? correctAnswer;
  final String? difficulty;

  const TutorContextModel({
    this.categoryName,
    this.topicTitle,
    this.subtopicTitle,
    this.questionText,
    this.selectedAnswer,
    this.correctAnswer,
    this.difficulty,
  });

  bool get hasContext =>
      categoryName != null || topicTitle != null || questionText != null;

  String get summaryString {
    if (questionText != null) {
      return "Question: ${questionText!.substring(0, questionText!.length > 40 ? 40 : questionText!.length)}...";
    }
    if (topicTitle != null) {
      return "$topicTitle${categoryName != null ? ' ($categoryName)' : ''}";
    }
    return "OS Tutor Session";
  }
}
