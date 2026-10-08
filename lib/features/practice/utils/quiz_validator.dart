import '../models/question_model.dart';
import '../../learn/models/topic_model.dart';

/// Utility class enforcing mandatory quiz question validation rules:
/// 1. Verify there are exactly 4 options.
/// 2. Verify all 4 option strings are unique.
/// 3. Verify only one option is marked as correct.
/// 4. If duplicate or missing options are detected, regenerate only the incorrect duplicate options.
/// 5. Preserve the correct answer.
class QuizValidator {
  static const List<String> _fallbackDistractors = [
    'A CPU scheduling algorithm for short jobs',
    'A memory allocation technique using dynamic paging',
    'A file management method for block storage',
    'An I/O device driver software interface',
    'A virtual memory page replacement policy',
    'A process synchronization hardware primitive',
    'A deadlock avoidance resource request strategy',
    'A system call interface for process creation',
    'A hardware interrupt handling routine',
    'A cache replacement and coherence protocol',
    'A multi-threaded process execution model',
    'A disk head movement elevator algorithm',
    'A kernel space memory protection boundary',
    'A page table virtual-to-physical translation mechanism',
    'A mutual exclusion binary lock mechanism',
    'An inter-process communication pipe channel',
    'A secondary storage inode block index strategy',
    'A real-time operating system task scheduler',
    'A context switching register save and restore sequence',
    'A direct memory access (DMA) controller transfer mode',
  ];

  /// Validates and sanitizes a [QuestionModel] before rendering.
  static QuestionModel sanitizeQuestion(QuestionModel question) {
    final sanitizedOptions = _sanitizeOptions(
      rawOptions: question.options,
      correctIndex: question.correctOptionIndex,
      topicOrCategory: question.topicName,
    );

    int validCorrectIndex = question.correctOptionIndex;
    if (validCorrectIndex < 0 || validCorrectIndex >= sanitizedOptions.length) {
      validCorrectIndex = 0;
    }

    return QuestionModel(
      id: question.id,
      topicId: question.topicId,
      topicName: question.topicName,
      categoryId: question.categoryId,
      questionText: question.questionText,
      options: sanitizedOptions,
      correctOptionIndex: validCorrectIndex,
      explanation: question.explanation,
      type: question.type,
      difficulty: question.difficulty,
    );
  }

  /// Validates and sanitizes a [ConceptQuestionModel] before rendering.
  static ConceptQuestionModel sanitizeConceptQuestion(ConceptQuestionModel question) {
    final sanitizedOptions = _sanitizeOptions(
      rawOptions: question.options,
      correctIndex: question.correctOptionIndex,
      topicOrCategory: question.question,
    );

    int validCorrectIndex = question.correctOptionIndex;
    if (validCorrectIndex < 0 || validCorrectIndex >= sanitizedOptions.length) {
      validCorrectIndex = 0;
    }

    return ConceptQuestionModel(
      id: question.id,
      question: question.question,
      options: sanitizedOptions,
      correctOptionIndex: validCorrectIndex,
      explanation: question.explanation,
    );
  }

  /// Shuffles option positions for a list of [QuestionModel]s, guaranteeing:
  /// - 100% same question text and 4 unique answer choices
  /// - Updated [correctOptionIndex] matching the new position of the correct answer
  /// - Balanced distribution across A, B, C, D (indices 0, 1, 2, 3)
  /// - At most 2 consecutive questions with the same correct option index
  static List<QuestionModel> shuffleQuizQuestions(List<QuestionModel> questions) {
    if (questions.isEmpty) return [];

    final List<int> targetIndices = _generateBalancedIndices(questions.length);
    final List<QuestionModel> shuffled = [];

    for (int i = 0; i < questions.length; i++) {
      shuffled.add(_shuffleSingleQuestion(questions[i], targetIndices[i]));
    }

    return shuffled;
  }

  /// Shuffles option positions for a list of [ConceptQuestionModel]s.
  static List<ConceptQuestionModel> shuffleConceptQuestions(List<ConceptQuestionModel> questions) {
    if (questions.isEmpty) return [];

    final List<int> targetIndices = _generateBalancedIndices(questions.length);
    final List<ConceptQuestionModel> shuffled = [];

    for (int i = 0; i < questions.length; i++) {
      shuffled.add(_shuffleSingleConceptQuestion(questions[i], targetIndices[i]));
    }

    return shuffled;
  }

  static QuestionModel _shuffleSingleQuestion(QuestionModel question, int targetCorrectIdx) {
    final sanitized = sanitizeQuestion(question);
    final correctText = sanitized.options[sanitized.correctOptionIndex];
    final distractors = <String>[];
    for (int i = 0; i < sanitized.options.length; i++) {
      if (i != sanitized.correctOptionIndex) {
        distractors.add(sanitized.options[i]);
      }
    }

    final newOptions = List<String>.filled(4, '');
    newOptions[targetCorrectIdx] = correctText;
    int dIdx = 0;
    for (int i = 0; i < 4; i++) {
      if (i != targetCorrectIdx) {
        newOptions[i] = distractors[dIdx++];
      }
    }

    return QuestionModel(
      id: sanitized.id,
      topicId: sanitized.topicId,
      topicName: sanitized.topicName,
      categoryId: sanitized.categoryId,
      questionText: sanitized.questionText,
      options: newOptions,
      correctOptionIndex: targetCorrectIdx,
      explanation: sanitized.explanation,
      type: sanitized.type,
      difficulty: sanitized.difficulty,
    );
  }

  static ConceptQuestionModel _shuffleSingleConceptQuestion(ConceptQuestionModel question, int targetCorrectIdx) {
    final sanitized = sanitizeConceptQuestion(question);
    final correctText = sanitized.options[sanitized.correctOptionIndex];
    final distractors = <String>[];
    for (int i = 0; i < sanitized.options.length; i++) {
      if (i != sanitized.correctOptionIndex) {
        distractors.add(sanitized.options[i]);
      }
    }

    final newOptions = List<String>.filled(4, '');
    newOptions[targetCorrectIdx] = correctText;
    int dIdx = 0;
    for (int i = 0; i < 4; i++) {
      if (i != targetCorrectIdx) {
        newOptions[i] = distractors[dIdx++];
      }
    }

    return ConceptQuestionModel(
      id: sanitized.id,
      question: sanitized.question,
      options: newOptions,
      correctOptionIndex: targetCorrectIdx,
      explanation: sanitized.explanation,
    );
  }

  static List<int> _generateBalancedIndices(int count) {
    final List<int> indices = [];
    final base = [0, 1, 2, 3];
    while (indices.length < count) {
      base.shuffle();
      indices.addAll(base);
    }

    final result = indices.sublist(0, count);

    // Enforce no more than 2 consecutive identical answer indices
    for (int i = 0; i < result.length - 2; i++) {
      if (result[i] == result[i + 1] && result[i + 1] == result[i + 2]) {
        result[i + 2] = (result[i + 2] + 1) % 4;
      }
    }

    return result;
  }

  static List<String> _sanitizeOptions({
    required List<String> rawOptions,
    required int correctIndex,
    required String topicOrCategory,
  }) {
    int validCorrectIdx = correctIndex;
    if (validCorrectIdx < 0 || validCorrectIdx >= rawOptions.length) {
      validCorrectIdx = 0;
    }

    String correctText = rawOptions.isNotEmpty
        ? rawOptions[validCorrectIdx].trim()
        : 'Correct OS concept solution';
    if (correctText.isEmpty) {
      correctText = 'Correct OS concept solution';
    }

    final List<String> options = List<String>.filled(4, '');
    options[validCorrectIdx] = correctText;

    final Set<String> seenNormalized = {correctText.toLowerCase().trim()};

    // Step 1: Retain non-duplicate existing options
    for (int i = 0; i < 4; i++) {
      if (i == validCorrectIdx) continue;

      if (i < rawOptions.length) {
        final opt = rawOptions[i].trim();
        final norm = opt.toLowerCase().trim();

        // Check if option is unique, non-empty, and not a duplicate of correct answer or other options
        if (opt.isNotEmpty && !seenNormalized.contains(norm)) {
          options[i] = opt;
          seenNormalized.add(norm);
        }
      }
    }

    // Step 2: Regenerate any duplicate or missing options with believable OS distractors
    int distractorIdx = 0;
    for (int i = 0; i < 4; i++) {
      if (options[i].isEmpty) {
        String chosenDistractor = '';
        while (distractorIdx < _fallbackDistractors.length) {
          final candidate = _fallbackDistractors[distractorIdx++];
          final norm = candidate.toLowerCase().trim();
          if (!seenNormalized.contains(norm)) {
            chosenDistractor = candidate;
            seenNormalized.add(norm);
            break;
          }
        }

        if (chosenDistractor.isEmpty) {
          chosenDistractor = 'Alternative OS concept option ${i + 1}';
          seenNormalized.add(chosenDistractor.toLowerCase().trim());
        }

        options[i] = chosenDistractor;
      }
    }

    return options;
  }
}
