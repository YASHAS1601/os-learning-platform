class StepItem {
  final int stepNumber;
  final String title;
  final String description;

  const StepItem({
    required this.stepNumber,
    required this.title,
    required this.description,
  });
}

class KeyTermItem {
  final String term;
  final String definition;

  const KeyTermItem({
    required this.term,
    required this.definition,
  });
}

class WorkedExampleModel {
  final String title;
  final String problemStatement;
  final List<String> inputs;
  final List<String> stepByStepCalculations;
  final List<String> finalResults;
  final String explanation;

  const WorkedExampleModel({
    required this.title,
    required this.problemStatement,
    required this.inputs,
    required this.stepByStepCalculations,
    required this.finalResults,
    required this.explanation,
  });
}

class ComparisonTableModel {
  final String title;
  final List<String> headers;
  final List<List<String>> rows;

  const ComparisonTableModel({
    required this.title,
    required this.headers,
    required this.rows,
  });
}

class ConceptQuestionModel {
  final String id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;

  const ConceptQuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
  });
}

class TopicModel {
  final String id;
  final String categoryId;
  final String title;
  final String shortIntro;
  final String definition;
  final String conceptExplanation;
  final String difficulty; // Beginner, Intermediate, Advanced
  final String readingTime; // e.g. "4 min read"
  final String? whyWeNeedIt;
  final String? analogy;
  final List<StepItem> executionSteps;
  final List<String> importantPoints;
  final List<KeyTermItem> keyTerms;
  final String? timeComplexity;
  final String? spaceComplexity;
  final String? formula;
  final List<String> advantages;
  final List<String> disadvantages;
  final String? exampleScenario;
  final WorkedExampleModel? workedExample;
  final ComparisonTableModel? comparisonTable;
  final List<String> realWorldApplications;
  final List<String> examEssentials;
  final List<String> commonMistakes;
  final List<ConceptQuestionModel> practiceQuestions;
  final String? diagramTitle;
  final List<String> diagramNodes;
  final bool isAlgorithmTopic;
  final String? visualizerType; // e.g. 'process_state', 'pcb', 'context_switch', 'cpu_gantt', 'sync_peterson', 'sync_semaphore', 'deadlock_rag', 'bankers', 'memory_allocation', 'paging_translation', 'page_replacement', 'disk_scheduling', 'file_allocation', 'io_dma_interrupt'

  const TopicModel({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.shortIntro,
    required this.definition,
    this.conceptExplanation = 'This topic covers core principles of operating system architecture, resource allocation, and hardware abstraction.',
    this.difficulty = 'Intermediate',
    this.readingTime = '4 min read',
    this.whyWeNeedIt,
    this.analogy,
    this.executionSteps = const [],
    this.importantPoints = const [],
    this.keyTerms = const [],
    this.timeComplexity,
    this.spaceComplexity,
    this.formula,
    this.advantages = const [],
    this.disadvantages = const [],
    this.exampleScenario,
    this.workedExample,
    this.comparisonTable,
    this.realWorldApplications = const [],
    this.examEssentials = const [],
    this.commonMistakes = const [],
    this.practiceQuestions = const [],
    this.diagramTitle,
    this.diagramNodes = const [],
    this.isAlgorithmTopic = false,
    this.visualizerType,
  });
}
