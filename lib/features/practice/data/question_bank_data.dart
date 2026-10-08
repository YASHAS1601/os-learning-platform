import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../models/question_model.dart';
import '../models/quiz_model.dart';
import '../utils/quiz_validator.dart';
import 'subtopic_question_bank.dart';

class QuestionBankData {
  static List<QuestionModel> get allQuestions {
    final List<QuestionModel> aggregated = [];
    for (final subtopicId in SubtopicQuestionBank.availableSubtopicIds) {
      for (final q in SubtopicQuestionBank.getQuestionsForSubtopic(subtopicId)) {
        aggregated.add(QuizValidator.sanitizeQuestion(q));
      }
    }
    return aggregated;
  }

  static List<QuestionModel> getQuestionsForTopic(String topicId) {
    return SubtopicQuestionBank.getQuestionsForSubtopic(topicId)
        .map((q) => QuizValidator.sanitizeQuestion(q))
        .toList();
  }

  static List<QuizModel> get quizzes {
    final all = allQuestions;

    return [
      QuizModel(
        id: 'quiz_cpu',
        title: 'CPU Scheduling Quiz',
        description: 'Test your understanding of FCFS, SJF, Round Robin & Priorities.',
        icon: Icons.speed_rounded,
        accentColor: AppColors.neonPurple,
        questions: all.where((q) => q.categoryId == 'cat_cpu').toList(),
      ),
      QuizModel(
        id: 'quiz_mem',
        title: 'Memory Management Quiz',
        description: 'Paging, partitions, and dynamic memory allocation algorithms.',
        icon: Icons.grid_view_rounded,
        accentColor: AppColors.neonGreen,
        questions: all.where((q) => q.categoryId == 'cat_memory').toList(),
      ),
      QuizModel(
        id: 'quiz_vm',
        title: 'Page Replacement Quiz',
        description: 'Demand paging, FIFO, LRU, and Belady\'s Anomaly.',
        icon: Icons.cloud_done_rounded,
        accentColor: AppColors.neonCyan,
        questions: all.where((q) => q.categoryId == 'cat_vmemory').toList(),
      ),
      QuizModel(
        id: 'quiz_deadlock',
        title: 'Deadlock & Prevention Quiz',
        description: 'Coffman conditions, RAG graphs, and Banker\'s algorithm.',
        icon: Icons.warning_amber_rounded,
        accentColor: AppColors.neonGold,
        questions: all.where((q) => q.categoryId == 'cat_deadlock').toList(),
      ),
      QuizModel(
        id: 'quiz_disk',
        title: 'Disk Scheduling Quiz',
        description: 'SSTF, SCAN, C-SCAN, LOOK, and C-LOOK head movements.',
        icon: Icons.disc_full_rounded,
        accentColor: AppColors.neonPink,
        questions: all.where((q) => q.categoryId == 'cat_disk').toList(),
      ),
      QuizModel(
        id: 'quiz_basics',
        title: 'OS Architecture & Kernel Quiz',
        description: 'Dual mode execution, system calls, interrupts, and boot sequence.',
        icon: Icons.computer_rounded,
        accentColor: AppColors.neonCyan,
        questions: all.where((q) => q.categoryId == 'cat_basics').toList(),
      ),
      QuizModel(
        id: 'quiz_process',
        title: 'Process & Thread Management Quiz',
        description: 'PCB states, context switching, fork/exec, and thread models.',
        icon: Icons.developer_board_rounded,
        accentColor: AppColors.neonPurple,
        questions: all.where((q) => q.categoryId == 'cat_process').toList(),
      ),
      QuizModel(
        id: 'quiz_sync',
        title: 'Process Synchronization Quiz',
        description: 'Critical sections, semaphores, mutexes, and classic IPC problems.',
        icon: Icons.sync_lock_rounded,
        accentColor: AppColors.neonBlue,
        questions: all.where((q) => q.categoryId == 'cat_sync').toList(),
      ),
      QuizModel(
        id: 'quiz_file',
        title: 'File Systems & System Calls Quiz',
        description: 'Directories, inodes, allocation methods, and system call APIs.',
        icon: Icons.folder_special_rounded,
        accentColor: AppColors.neonGreen,
        questions: all.where((q) => q.categoryId == 'cat_file').toList(),
      ),
      QuizModel(
        id: 'quiz_io',
        title: 'I/O Systems & Protection Quiz',
        description: 'Interrupts, DMA, drivers, protection domains, and security.',
        icon: Icons.input_rounded,
        accentColor: AppColors.neonBlue,
        questions: all.where((q) => q.categoryId == 'cat_io').toList(),
      ),
      QuizModel(
        id: 'quiz_mixed',
        title: 'Mixed Operating Systems Quiz',
        description: 'Comprehensive test across all core OS topics & algorithms.',
        icon: Icons.psychology_rounded,
        accentColor: AppColors.neonBlue,
        questions: all,
      ),
    ];
  }
}

