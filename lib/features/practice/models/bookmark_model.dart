/// Bookmark model matching bookmarks Supabase table
class BookmarkModel {
  final int? id;
  final String userId;
  final String itemType; // e.g. 'topic', 'exam_question', 'quiz'
  final String itemId;
  final DateTime? createdAt;

  BookmarkModel({
    this.id,
    required this.userId,
    required this.itemType,
    required this.itemId,
    this.createdAt,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json['id'] as int?,
      userId: json['user_id'] as String,
      itemType: json['item_type'] as String,
      itemId: json['item_id'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'item_type': itemType,
      'item_id': itemId,
      'created_at': (createdAt ?? DateTime.now()).toIso8601String(),
    };
  }
}
