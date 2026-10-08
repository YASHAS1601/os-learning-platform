/// User Progress model matching user_progress Supabase table
class UserProgress {
  final int? id;
  final String userId;
  final String topic;
  final bool completed;
  final int progress;
  final DateTime? updatedAt;

  UserProgress({
    this.id,
    required this.userId,
    required this.topic,
    this.completed = false,
    this.progress = 0,
    this.updatedAt,
  });

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      id: json['id'] as int?,
      userId: json['user_id'] as String,
      topic: json['topic'] as String,
      completed: json['completed'] as bool? ?? false,
      progress: json['progress'] as int? ?? 0,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'topic': topic,
      'completed': completed,
      'progress': progress,
      'updated_at': DateTime.now().toIso8601String(),
    };
  }
}
