/// Quiz Result model matching quiz_results Supabase table
class QuizResultModel {
  final int? id;
  final String userId;
  final String quizName;
  final int score;
  final int totalQuestions;
  final DateTime? createdAt;

  QuizResultModel({
    this.id,
    required this.userId,
    required this.quizName,
    required this.score,
    required this.totalQuestions,
    this.createdAt,
  });

  double get percentage =>
      totalQuestions > 0 ? (score / totalQuestions) * 100 : 0.0;

  factory QuizResultModel.fromJson(Map<String, dynamic> json) {
    return QuizResultModel(
      id: json['id'] as int?,
      userId: json['user_id'] as String,
      quizName: json['quiz_name'] as String,
      score: json['score'] as int,
      totalQuestions: json['total_questions'] as int,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'quiz_name': quizName,
      'score': score,
      'total_questions': totalQuestions,
      'created_at': (createdAt ?? DateTime.now()).toIso8601String(),
    };
  }
}
