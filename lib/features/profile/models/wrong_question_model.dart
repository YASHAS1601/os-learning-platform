class WrongQuestionModel {
  final String id;
  final String questionId;
  final String topicId;
  final String topicName;
  final String categoryId;
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;
  final int userSelectedOptionIndex;
  final String explanation;
  final String hint;
  final String mnemonic;
  final DateTime timestamp;
  final bool isMastered;

  const WrongQuestionModel({
    required this.id,
    required this.questionId,
    required this.topicId,
    required this.topicName,
    required this.categoryId,
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
    required this.userSelectedOptionIndex,
    required this.explanation,
    required this.hint,
    required this.mnemonic,
    required this.timestamp,
    this.isMastered = false,
  });

  WrongQuestionModel copyWith({
    String? id,
    String? questionId,
    String? topicId,
    String? topicName,
    String? categoryId,
    String? questionText,
    List<String>? options,
    int? correctOptionIndex,
    int? userSelectedOptionIndex,
    String? explanation,
    String? hint,
    String? mnemonic,
    DateTime? timestamp,
    bool? isMastered,
  }) {
    return WrongQuestionModel(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      topicId: topicId ?? this.topicId,
      topicName: topicName ?? this.topicName,
      categoryId: categoryId ?? this.categoryId,
      questionText: questionText ?? this.questionText,
      options: options ?? this.options,
      correctOptionIndex: correctOptionIndex ?? this.correctOptionIndex,
      userSelectedOptionIndex: userSelectedOptionIndex ?? this.userSelectedOptionIndex,
      explanation: explanation ?? this.explanation,
      hint: hint ?? this.hint,
      mnemonic: mnemonic ?? this.mnemonic,
      timestamp: timestamp ?? this.timestamp,
      isMastered: isMastered ?? this.isMastered,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': questionId,
      'topicId': topicId,
      'topicName': topicName,
      'categoryId': categoryId,
      'questionText': questionText,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
      'userSelectedOptionIndex': userSelectedOptionIndex,
      'explanation': explanation,
      'hint': hint,
      'mnemonic': mnemonic,
      'timestamp': timestamp.toIso8601String(),
      'isMastered': isMastered,
    };
  }

  factory WrongQuestionModel.fromJson(Map<String, dynamic> json) {
    return WrongQuestionModel(
      id: json['id'] as String? ?? '',
      questionId: json['questionId'] as String? ?? '',
      topicId: json['topicId'] as String? ?? 'general_os',
      topicName: json['topicName'] as String? ?? 'Operating Systems',
      categoryId: json['categoryId'] as String? ?? 'cat_basics',
      questionText: json['questionText'] as String? ?? '',
      options: (json['options'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      correctOptionIndex: json['correctOptionIndex'] as int? ?? 0,
      userSelectedOptionIndex: json['userSelectedOptionIndex'] as int? ?? -1,
      explanation: json['explanation'] as String? ?? '',
      hint: json['hint'] as String? ?? '',
      mnemonic: json['mnemonic'] as String? ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'] as String) ?? DateTime.now()
          : DateTime.now(),
      isMastered: json['isMastered'] as bool? ?? false,
    );
  }
}

