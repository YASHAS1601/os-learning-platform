import '../models/exam_question_model.dart';

class ExamVaultData {
  static const List<ExamQuestionModel> questions = [
    // -------------------------------------------------------------
    // QUESTION 1 (Page 1)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_1',
      title: 'Heterogeneous System OS Architecture Design',
      marks: '10 Marks',
      categoryId: 'cat_basics',
      topicName: 'OS Architectures',
      internalYearMetadata: '2025–2026',
      questionText:
          'A software company is developing a next-generation operating system for a smart healthcare and industrial automation platform. The OS is expected to run on heterogeneous hardware, ranging from embedded medical devices to high-performance monitoring servers. The design team must ensure reliability, security, scalability, and ease of maintenance, while also supporting fast boot time and efficient hardware interaction.\n\nExplain Monolithic, Layered, Microkernel, and Modular OS structures with neat sketch, Pros and Cons, and justify the most suitable structure for this system. Also, identify the essential operating system services required for this platform.',
    ),

    // -------------------------------------------------------------
    // QUESTION 2 (Page 1)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_2',
      title: 'Interrupt I/O Timeline & System Call Parameter Passing',
      marks: '5 + 5 = 10 Marks',
      categoryId: 'cat_basics',
      topicName: 'System Calls & I/O',
      internalYearMetadata: '2025–2026',
      questionText:
          'a) [5 Marks] Consider a system running a single program that issues an output request to a printer. The OS uses interrupt-driven I/O. Explain the interrupt timeline and discuss the role of the Interrupt Service Routine (ISR) in completing the output operation.\n\nb) [5 Marks] Analyse the various methods of system call parameter passing. With the help of a neat diagram, explain how parameters are passed from user space to kernel space during a system call invocation.',
    ),

    // -------------------------------------------------------------
    // QUESTION 3 (Page 1)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_3',
      title: 'Process Creation PCB & Multithreading Parallelism',
      marks: '5 + 5 = 10 Marks',
      categoryId: 'cat_process',
      topicName: 'Processes & Threads',
      internalYearMetadata: '2025–2026',
      questionText:
          'a) [5 Marks] Explain the process creation mechanism in an operating system. Examine the role of the Process Control Block (PCB) in maintaining process context and analyse how the parent-child relationship influences resource sharing and handles address space allocation.\n\nb) [5 Marks] Analyse how multithreading improves application performance and resource utilization in multi-core systems. Also, explain how data parallelism and task parallelism are implemented in multithreaded applications with suitable diagrams.',
    ),

    // -------------------------------------------------------------
    // QUESTION 4 (Page 2)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_4',
      title: 'Preemptive Priority, SJF & Round Robin Scheduling',
      marks: '10 Marks',
      categoryId: 'cat_cpu',
      topicName: 'CPU Scheduling',
      internalYearMetadata: '2025–2026',
      questionText:
          'Consider the following processes, each arriving for execution at the time indicated. Each process is assigned a numeric priority, where a lower value indicates a higher priority level:\n\nProcess | Priority | Burst Time (ms) | Arrival Time (ms)\nP1      | 5        | 13              | 6\nP2      | 10       | 15              | 10\nP3      | 30       | 40              | 15\nP4      | 3        | 12              | 12\nP5      | 2        | 4               | 0\nP6      | 6        | 4               | 5\n\nApply the following scheduling algorithms to draw Gantt charts and compute the average waiting time and average turnaround time:\ni) Pre-emptive Priority [3 Marks]\nii) Non pre-emptive SJF [3 Marks]\niii) Round Robin (Time Quantum = 10 ms) [4 Marks]',
    ),

    // -------------------------------------------------------------
    // QUESTION 5 (Page 2)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_5',
      title: 'Multilevel Queue Scheduling Analysis',
      marks: '10 Marks',
      categoryId: 'cat_cpu',
      topicName: 'Multilevel Queue Scheduling',
      internalYearMetadata: '2025–2026',
      questionText:
          'Consider a system that uses Multilevel Queue Scheduling with the following criteria:\n• System has three queues (Q1, Q2, and Q3) and priority decreases from Q1 to Q3.\n• Q1: Priority Scheduling (Non pre-emptive, lower number = higher priority).\n• Q2: Round Robin (Time Quantum = 4 ms).\n• Q3: FCFS.\n• Higher-priority queues can preempt lower-priority queues. CPU remains idle if no process is ready.\n\nProcess | Priority | Burst Time (ms) | Arrival Time (ms) | Queue\nP1      | 3        | 6               | 0                 | Q3\nP2      | 2        | 4               | 1                 | Q1\nP3      | 1        | 3               | 2                 | Q2\nP4      | 6        | 2               | 15                | Q1\nP5      | 8        | 5               | 16                | Q3\nP6      | 2        | 7               | 17                | Q2\nP7      | 1        | 3               | 20                | Q1\n\nDraw the Gantt chart and calculate the average turnaround time, average waiting time, and average response time.',
    ),

    // -------------------------------------------------------------
    // QUESTION 6 (Page 3)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_6',
      title: 'Multi-Environment OS Architecture Selection',
      marks: '10 Marks',
      categoryId: 'cat_basics',
      topicName: 'OS Architectures',
      internalYearMetadata: '2025–2026',
      questionText:
          'A multinational technology company is designing a next-generation operating system intended to support three different environments using a common core design:\n• Environment A: A safety-critical embedded control system used in medical and industrial equipment, where system crashes are unacceptable and fault isolation is essential.\n• Environment B: An academic operating system for universities, aimed at helping students clearly understand how operating system components interact internally.\n• Environment C: A high-performance general-purpose operating system for servers and desktops that must support frequent updates, device drivers, and third-party extensions without requiring a system reboot.\n\nThe design team is considering Monolithic, Layered, Microkernel, and Modular structures.\na) [6/7 Marks] Explain how each of the four OS structure approaches organizes kernel services, using neatly labeled diagrams, and discuss advantages and disadvantages of each.\nb) [3/4 Marks] For each environment (A, B, and C), select the most appropriate operating system structure and justify your choice based on performance, reliability, security, maintainability, and extensibility.',
    ),

    // -------------------------------------------------------------
    // QUESTION 7 (Page 3)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_7',
      title: 'System Calls Categories & Execution Mechanism',
      marks: '10 Marks',
      categoryId: 'cat_basics',
      topicName: 'System Calls',
      internalYearMetadata: '2025–2026',
      questionText:
          'A company is building a multi-user OS to support file editors, media players, network apps, and secure system utilities. During system execution, the following situations occur:\n1. A user starts a new application, terminates it forcibly, and waits for a child process to complete execution.\n2. An application creates a new file, writes data to it, reads the stored content, and then deletes the file.\n3. A printer and a disk drive are accessed by multiple programs; the OS must allocate and release these devices safely.\n4. The OS periodically retrieves system time, process status, and resource usage information for monitoring and logging.\n5. Two applications running on different machines exchange messages and synchronize their execution over a network.\n6. A secure banking application restricts access to sensitive files and ensures only authorized users perform critical operations.\n\na) [3 Marks] Identify the appropriate type of system call used in each situation listed above.\nb) [5 Marks] For each identified system call type, explain its importance in OS functioning with suitable examples.\nc) [2 Marks] Describe the system call mechanism, explaining how a user program invokes a system call and how control is transferred between user mode and kernel mode.',
    ),

    // -------------------------------------------------------------
    // QUESTION 8 (Page 3)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_8',
      title: 'Process Data Structures & Multithreading Models',
      marks: '5 + 5 = 10 Marks',
      categoryId: 'cat_process',
      topicName: 'Process Control Block & Threads',
      internalYearMetadata: '2025–2026',
      questionText:
          'a) [5 Marks] Discuss the data structure used by the operating system to store and manage information about each process during execution (Process Control Block - PCB). Explain the contents of this structure and justify how it supports process scheduling and context switching. Illustrate your answer with a neat labeled diagram.\n\nb) [5 Marks] Analyze the various multithreading models in operating systems (Many-to-One, One-to-One, Many-to-Many) and compare user-level threads with kernel-level threads on parameters such as implementation, context switch time, hardware support, blocking operations, and OS recognition.',
    ),

    // -------------------------------------------------------------
    // QUESTION 9 (Page 4)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_9',
      title: 'CPU Burst Derivation & Scheduling: SRTF vs Round Robin',
      marks: '10 Marks',
      categoryId: 'cat_cpu',
      topicName: 'CPU Scheduling',
      internalYearMetadata: '2025–2026',
      questionText:
          'Consider a system consisting of six processes arriving at times 0, 1, 2, 4, 5, and 6 ms respectively. The total execution time (CPU burst + I/O burst) is 20, 18, 15, 10, 6, and 12 ms respectively. Each process spends 20% of its execution time performing I/O and 80% performing CPU computation. CPU burst time is rounded to the nearest integer.\n\nProcess | Arrival Time (ms) | Total Time (ms) | Derived CPU Burst (80%) | Derived I/O Time (20%)\nP1      | 0                 | 20              | 16                      | 4\nP2      | 1                 | 18              | 14 (14.4 ≈ 14)           | 4\nP3      | 2                 | 15              | 12                      | 3\nP4      | 4                 | 10              | 8                       | 2\nP5      | 5                 | 6               | 5                       | 1\nP6      | 6                 | 12              | 10                      | 2\n\nConsidering only CPU burst time, schedule using: (1) Shortest Remaining Time First (SRTF), (2) Round Robin (Time Quantum = 5 ms).\nFor each algorithm: a) Draw Gantt chart [2+2M], b) Average turnaround time [1+1M], c) Average waiting time [1+1M], d) Response time of each process [1+1M].',
    ),

    // -------------------------------------------------------------
    // QUESTION 10 (Page 4)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_10',
      title: 'Multilevel Queue Scheduling with Context Switches',
      marks: '10 Marks',
      categoryId: 'cat_cpu',
      topicName: 'Multilevel Queue Scheduling',
      internalYearMetadata: '2025–2026',
      questionText:
          'A computer system uses Multilevel Queue Scheduling with three priority queues (priority: Q1 > Q2 > Q3). Preemption occurs between queues:\n• Queue Q1: Preemptive Priority Scheduling (lower numerical priority = higher priority; equal priorities follow FCFS).\n• Queue Q2: First Come First Served (FCFS).\n• Queue Q3: Round Robin Scheduling (Time Quantum = 3 ms).\n\nProcess ID | Arrival Time (ms) | Burst Time (ms) | Priority | Queue Assigned\nP1         | 0                 | 10              | 2        | Q2 (FCFS)\nP2         | 1                 | 6               | 1        | Q1 (Preemptive Priority)\nP3         | 2                 | 8               | 3        | Q3 (Round Robin, TQ=3)\nP4         | 3                 | 4               | 1        | Q1 (Preemptive Priority)\nP5         | 4                 | 5               | 2        | Q2 (FCFS)\nP6         | 9                 | 4               | 2        | Q1 (Preemptive Priority)\nP7         | 13                | 5               | 4        | Q3 (Round Robin, TQ=3)\nP8         | 5                 | 4               | 1        | Q2 (FCFS)\nP9         | 7                 | 1               | 5        | Q3 (Round Robin, TQ=3)\n\na) [4 Marks] Draw the Gantt chart for execution.\nb) [3 Marks] Calculate Waiting Time, Turnaround Time, and Response Time for each process.\nc) [3 Marks] Determine the total number of context switches that occur during execution and explain their causes.',
    ),

    // -------------------------------------------------------------
    // QUESTION 11 (Page 5)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_11',
      title: 'AR/VR Gaming Console OS Functionalities & Architecture',
      marks: '5 + 5 = 10 Marks',
      categoryId: 'cat_basics',
      topicName: 'OS Architectures',
      internalYearMetadata: '2023–2024',
      questionText:
          'As an operating system developer for an AR and VR enabled PlayStation gaming console, you are asked to find out and elaborate the functionalities that are needed for the gaming console, ensuring high performance and an interactive real-time experience. (5 Marks)\n\nDesign an appropriate OS structure as per the functionalities listed above with proper technical justification. (5 Marks)',
    ),

    // -------------------------------------------------------------
    // QUESTION 12 (Page 5)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_12',
      title: 'C System Call File Parsing ("Temp.txt")',
      marks: '5 + 5 = 10 Marks',
      categoryId: 'cat_basics',
      topicName: 'System Calls',
      internalYearMetadata: '2023–2024',
      questionText:
          'Ram\'s objective is to read the contents from the file "Temp.txt" and list out the number of vowels, consonants, and words from the parent process. Write a C program using a comprehensive sequence of system calls necessary to accomplish this task proficiently. (5 Marks)\n\nDelineate the distinct system calls essential for this operation (e.g., open, read, fork, pipe, write, close, wait) and elucidate their individual functionalities in detail. (5 Marks)',
    ),

    // -------------------------------------------------------------
    // QUESTION 13 (Page 5)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_13',
      title: 'POSIX Pthreads Pseudo-code Construction (Even/Odd)',
      marks: '8 + 2 = 10 Marks',
      categoryId: 'cat_process',
      topicName: 'POSIX Pthreads',
      internalYearMetadata: '2023–2024',
      questionText:
          'As a programmer, build the pseudo code to construct two threads: one for creating the list of even numbers and the other for generating the list of odd numbers (for example, call them Thread1, Thread2). Explain in detail the required predefined thread functions that were used to initiate the thread and all of its additional functions using the POSIX API (Pthreads). (8 Marks)\n\nAlso calculate the execution time of each thread. (2 Marks)',
    ),

    // -------------------------------------------------------------
    // QUESTION 14 (Page 5)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_14',
      title: 'Non-Preemptive SJF vs Preemptive SJF (SRTF)',
      marks: '10 Marks',
      categoryId: 'cat_cpu',
      topicName: 'CPU Scheduling',
      internalYearMetadata: '2023–2024',
      questionText:
          'Suppose that the following processes arrive for execution at the times indicated. Each process will run for the amount of time listed:\n\nProcess | Arrival Time | Burst Time\nP1      | 0            | 7\nP2      | 4            | 3\nP3      | 1            | 1\nP4      | 6            | 5\nP5      | 8            | 3\n\na) [4 Marks] Using non-preemptive SJF, draw the Gantt chart (2M), and compute average waiting time (1M) and average turnaround time (1M).\nb) [6 Marks] Does pre-emptive SJF (SRTF) give a better result compared to non-preemptive SJF? Compute and compare the average waiting time and turnaround time in both cases (Gantt Chart 2M, AWT 1M, ATAT 1M). Suggest a new scheme to improve CPU utilization further when compared with both algorithms (2M).',
    ),

    // -------------------------------------------------------------
    // QUESTION 15 (Page 6)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_15',
      title: 'Library Book Reading Short-Term Scheduler',
      marks: '5 + 5 = 10 Marks',
      categoryId: 'cat_cpu',
      topicName: 'CPU Scheduling',
      internalYearMetadata: '2023–2024',
      questionText:
          'Assume four students [S1, S2, S3, S4] would like to take an OS book from the library. Unfortunately, only one copy is available for reference. S1 needs to read for 10 min, S2 for 12 min, S3 for 2 min, and S4 for 6 min. All four students arrive at the library at the same time (AT = 0). Analyse the scenario with an appropriate short-term scheduler and determine: (a) Completion Time, (b) Average Turnaround Time, (c) Average Waiting Time, if:\n\na) [5 Marks] The students are allowed to read the book based on priority: 5, 3, 2, 4, 1 respectively for S1, S2, S3, S4 (assume standard interpretation where numeric value defines priority ranking). (Gantt Chart 2M, CT 1M, AWT 1M, ATAT 1M)\nb) [5 Marks] The students are allowed to read the book one after the other in round-robin fashion for 3 minutes in each of their turns. (Gantt Chart 2M, CT 1M, AWT 1M, ATAT 1M)',
    ),

    // -------------------------------------------------------------
    // QUESTION 16 (Page 6)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_16',
      title: 'Automated Teller Machine (ATM) OS Microkernel Design',
      marks: '10 Marks',
      categoryId: 'cat_basics',
      topicName: 'Microkernel OS Architecture',
      internalYearMetadata: '2026–2027',
      questionText:
          'A company is developing an operating system for an Automated Teller Machine (ATM). The system should continue operating even if one software service fails. It must securely process transactions, manage hardware devices such as the card reader and cash dispenser, and allow software updates without affecting the entire system. To improve reliability and maintainability, the company prefers an operating system design that retains only essential functions in kernel space while executing most services in user space.\n\na) [5 Marks] Recommend, with justification, an operating system structure suitable for this application with a neat illustration.\nb) [3 Marks] Discuss the operating system services required to achieve reliability and efficient resource management.\nc) [2 Marks] Discuss the challenges faced while developing operating systems for mission-critical applications.',
    ),

    // -------------------------------------------------------------
    // QUESTION 17 (Page 6)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_17',
      title: 'Time-Sharing vs Batch Processing & C Fork Process Tree',
      marks: '5 + 5 = 10 Marks',
      categoryId: 'cat_process',
      topicName: 'Process Creation & Types of OS',
      internalYearMetadata: '2026–2027',
      questionText:
          'i) [5 Marks] A university plans to upgrade its computer laboratory. During the day, hundreds of students simultaneously access programming environments, while at night, the system executes large-scale data processing jobs submitted by faculty. Compare time-sharing and multiprogramming operating systems with respect to this scenario. Also, suggest the most suitable operating system approach for daytime and nighttime operations, justifying your answer.\n\nii) [5 Marks] Predict the output of the program below. Justify your answer by showing the complete process creation tree:\n\n```c\n#include <stdio.h>\n#include <unistd.h>\n\nint main() {\n    int i;\n    for (i = 0; i < 2; i++) {\n        if (fork())\n            printf("P ");\n        else\n            printf("C ");\n    }\n    return 0;\n}\n```',
    ),

    // -------------------------------------------------------------
    // QUESTION 18 (Page 7)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_18',
      title: 'Multi-Process Browser & Zombie Process Tree',
      marks: '10 Marks',
      categoryId: 'cat_process',
      topicName: 'Process States & Trees',
      internalYearMetadata: '2026–2027',
      questionText:
          'A Linux-based web browser starts as a single process, browser (pid = 2201).\n• The user opens a tab. The browser spawns a new process (pid = 2305), which loads the tab-rendering program into memory.\n• From within that tab, a pop-up window is opened, causing the tab process (pid = 2305) to spawn another process (pid = 2312) to handle it.\n• Separately, the browser also spawns a download_manager process (pid = 2260) which continuously sends live download-progress updates back to the browser so the progress bar stays in sync.\n• The pop-up process (pid = 2312) finishes its task and exits normally, but its creator (pid = 2305) never checks on it or collects its exit status.\n• Shortly after, process 2305 itself crashes unexpectedly due to a faulty script. The user only sees a "This tab has crashed" message; nothing else in the browser is affected.\n\na) [5 Marks] From the given scenario, draw the process tree that results from the events described above, clearly showing which process created which one.\nb) [3 Marks] Based on this tree, mention the state to which process 2312 is likely to get stuck in. Why does this happen even though it has technically finished execution?\nc) [2 Marks] Using the tree you drew, explain why the crash of process 2305 does not bring down the browser or affect the download_manager process.',
    ),

    // -------------------------------------------------------------
    // QUESTION 19 (Page 7)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_19',
      title: 'Multi-Core Server Multithreading Bottlenecks',
      marks: '5 + 5 = 10 Marks',
      categoryId: 'cat_process',
      topicName: 'Multithreading Bottlenecks',
      internalYearMetadata: '2026–2027',
      questionText:
          'A cloud storage company allows users to upload large files. For each upload, the application creates separate threads to:\n1. Encrypt the file\n2. Compress the file\n3. Scan for viruses\n4. Upload the file to the cloud\n\nThe system administrator notices that the server has 16 processor cores, but CPU utilization rarely exceeds 10%.\n\na) [5 Marks] Explain the possible reason for the decrease in CPU utilization based on the threading model used (e.g., Many-to-One model bottleneck vs pipeline serialization vs GIL lock).\nb) [5 Marks] How can the application and threading architecture be modified to improve processor utilization across all 16 cores? Explain your answer.',
    ),

    // -------------------------------------------------------------
    // QUESTION 20 (Page 8)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_20',
      title: 'Spacecraft Preemptive Priority Scheduling with I/O Burst',
      marks: '10 Marks',
      categoryId: 'cat_cpu',
      topicName: 'CPU Scheduling & I/O',
      internalYearMetadata: '2026–2027',
      questionText:
          'A spacecraft mission control system schedules four processes, A, B, C, and D, using preemptive priority scheduling, where a higher numerical value indicates a higher priority. The processes arrive at 0 ms, 2 ms, 3 ms, and 5 ms, with burst times 5 ms, 3 ms, 6 ms, and 2 ms, and priorities 2, 4, 5, and 3, respectively. Process C performs an I/O operation for 2 ms after executing for 3 ms:\n\nProcess | Arrival Time (ms) | Burst Time (ms) | Priority | I/O Behavior\nA       | 0                 | 5               | 2        | Pure CPU\nB       | 2                 | 3               | 4        | Pure CPU\nC       | 3                 | 6 (3 CPU+2 I/O+3 CPU) | 5 (Highest) | Executes 3 ms → 2 ms I/O → executes remaining 3 ms\nD       | 5                 | 2               | 3        | Pure CPU\n\na) [5 Marks] Construct the Gantt chart showing the execution order. Calculate the waiting time and turnaround time for each process.\nb) [3 Marks] At each scheduling event, identify the state transitions of all processes (New, Ready, Running, Waiting, Terminated).\nc) [2 Marks] List all context switches and explain the events that trigger them (arrival, preemption, I/O initiation, I/O completion).',
    ),

    // -------------------------------------------------------------
    // QUESTION 21 (Page 8)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_21',
      title: 'Beverage Firm Banker\'s Algorithm Printer Matrix',
      marks: '10 Marks',
      categoryId: 'cat_deadlock',
      topicName: 'Banker\'s Algorithm',
      internalYearMetadata: '2023–2024',
      questionText:
          'A beverage firm has 4 types of printers (A, B, C, D) and 5 departments (Marketing, Production, R&D, Finance, HR).\nAvailable: A(3), B(6), C(5), D(6).\nCurrent Allocation: R&D: (1,3,5,4); Finance: (0,6,3,2); Marketing: (0,0,1,0); Production: (1,0,0,0); HR: (0,0,1,4).\nMaximum Claims: Marketing: (1,5,2,0); Production: (1,7,5,0); R&D: (2,3,5,6); Finance: (0,6,5,2); HR: (0,6,5,6).\n\n• Discuss the necessary and sufficient conditions for deadlock to happen. (2M)\n• Determine the Need matrix for each department. (2M)\n• Determine whether the system is in a safe or unsafe state using the Banker\'s Safety Algorithm. (3M)\n• If a request (0, 4, 2, 0) from Production arrives, can it be granted immediately? Justify. (3M)',
    ),

    // -------------------------------------------------------------
    // QUESTION 22 (Page 8)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_22',
      title: 'Resource Allocation Graph (RAG) Reduction',
      marks: '10 Marks',
      categoryId: 'cat_deadlock',
      topicName: 'Resource Allocation Graph',
      internalYearMetadata: '2023–2024',
      questionText:
          'A system has 5 processes (P1 to P5) and 3 resource types (P, Q, R with multi-instances). From the given RAG:\n• Check whether the system is in a safe state. If safe, find the safe sequence. If unsafe, calculate the minimum number of resource instances needed to make the system safe. (7M)\n• If P1 requests one additional instance of R, can it be granted immediately? Find the resulting execution order. (3M)',
    ),

    // -------------------------------------------------------------
    // QUESTION 23 (Page 8)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_23',
      title: '6-Resource Matrix Analysis for Deadlock Avoidance',
      marks: '10 Marks',
      categoryId: 'cat_deadlock',
      topicName: 'Deadlock Avoidance',
      internalYearMetadata: '2025–2026',
      questionText:
          'Given an allocation and request matrix for processes P1..P5 across 6 resource types R1..R6 with total resources R1=2, R2=1, R3=2, R4=2, R5=1, R6=2:\n• Draw the Resource Allocation Graph (RAG) and calculate the Need and Available matrices. (3M)\n• Show the step-by-step execution of the deadlock avoidance algorithm. (5M)\n• Identify the process execution safe sequence. (2M)',
    ),

    // -------------------------------------------------------------
    // QUESTION 24 (Page 9)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_24',
      title: 'Peterson\'s Algorithm 4-State Analysis',
      marks: '10 Marks',
      categoryId: 'cat_sync',
      topicName: 'Peterson\'s Solution',
      internalYearMetadata: '2023–2024',
      questionText:
          'Analyze the pseudo code of Peterson\'s algorithm across 4 states of Interested[P0], Interested[P1], and Turn:\n\nCase | Interested[P0] | Interested[P1] | Turn | Critical Section Outcome & Detailed Justification\n1    | True           | False          | P0   | P0 enters immediately; P1 not interested.\n2    | True           | True           | P0   | P0 enters (turn is P0); P1 busy-waits.\n3    | True           | True           | P1   | P1 enters (turn is P1); P0 busy-waits.\n4    | False          | True           | P1   | P1 enters immediately; P0 not interested.\n\nJustify whether mutual exclusion and progress are guaranteed with concrete proof. (3M)',
    ),

    // -------------------------------------------------------------
    // QUESTION 25 (Page 9)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_25',
      title: 'Chess Turn & Modified Readers-Writers Dilemma',
      marks: '10 Marks',
      categoryId: 'cat_sync',
      topicName: 'Process Synchronization',
      internalYearMetadata: '2023–2024',
      questionText:
          'Chess Turn Synchronization:\nChess is a two-player game played on a standard chessboard. If one person is playing, the other player must wait for their turn, and vice-versa. Write appropriate pseudo code to solve this two-player alternating turn problem using a suitable synchronization technique (using \'p\' and \'q\' notation) and justify how all critical section requirements (Mutual Exclusion, Progress, Bounded Waiting) are satisfied. [10 Marks]\n\nModified Readers-Writers Dilemma:\nRedesign the Readers-Writers problem such that:\n• A reader can begin reading only after two writers have finished writing.\n• The third writer must wait until five readers have finished their reading.\nProvide an optimized synchronization solution using semaphores, counters, and mutexes with complete pseudocode. [10 Marks]',
    ),

    // -------------------------------------------------------------
    // QUESTION 26 (Page 9)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_26',
      title: 'Hospital Operating Theatre & Ticket Counter Synchronization',
      marks: '10 Marks',
      categoryId: 'cat_sync',
      topicName: 'Semaphores & Mutexes',
      internalYearMetadata: '2025–2026',
      questionText:
          'Hospital Operating Theatre Coordination:\nA hospital has one operating theatre used for emergency or scheduled surgeries. Conditions: (1) Only one surgery at a time, (2) Emergency cases have absolute priority over scheduled cases, (3) Scheduled surgeries must not starve when no emergencies are waiting. Develop a complete synchronization algorithm using semaphores and mutex locks. [10 Marks]\n\nPure Software Synchronization (Ticket Counter):\nTwo threads in an online booking system increment a shared counter tickets_sold 10,000 times concurrently, resulting in race conditions. Hardware atomic instructions, semaphores, and mutexes are strictly forbidden. Develop a pure software coordination solution (e.g., Peterson\'s Algorithm) and demonstrate mutual exclusion, progress, and bounded waiting. [10 Marks]',
    ),

    // -------------------------------------------------------------
    // QUESTION 27 (Page 10-12)
    // -------------------------------------------------------------
    ExamQuestionModel(
      id: 'eq_27',
      title: 'Memory Fit Allocation Strategies (Freezers & Job Partitions)',
      marks: '10 Marks',
      categoryId: 'cat_memory',
      topicName: 'Memory Allocation',
      internalYearMetadata: '2023–2024',
      questionText:
          'Problem 1 (Ice Cream Freezer Variable Storage):\nAn ice cream business has 10 freezers with capacities (in order): 220, 50, 200, 300, 600, 400, 250, 450, 350, and 700 liters. Ten flavors require (in order): 212, 417, 112, 426, 350, 500, 275, 400, 600, and 50 liters. Using First-Fit, Best-Fit, and Worst-Fit strategies, determine partition allocation and calculate internal and external fragmentation for each strategy. [10 Marks]\n\nProblem 2 (Dynamic Job Execution with Partitions):\nPartitions: 4 MB, 8 MB, 20 MB, 2 MB. Partitions are released immediately when jobs finish.\nJob ID | J1 | J2 | J3 | J4 | J5 | J6 | J7\nSize (MB) | 2 | 14 | 3 | 6 | 2 | 10 | 20\nBurst Time | 4 | 10 | 2 | 1 | 6 | 1 | 8\nIdentify completion time of each job using Best-Fit and determine if external fragmentation occurs at any time. [10 Marks]',
    ),
  ];
}
