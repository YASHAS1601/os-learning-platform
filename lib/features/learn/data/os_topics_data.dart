import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../models/category_model.dart';
import '../models/topic_model.dart';

class OsTopicsData {
  static const List<CategoryModel> categories = [
    CategoryModel(
      id: 'cat_basics',
      title: 'OS Basics',
      description: 'Fundamentals, Kernel, System Calls & Architecture',
      icon: Icons.memory_rounded,
      accentColor: AppColors.neonCyan,
    ),
    CategoryModel(
      id: 'cat_process',
      title: 'Process Management',
      description: 'Processes, Threads, PCB & Context Switching',
      icon: Icons.account_tree_rounded,
      accentColor: AppColors.neonPink,
    ),
    CategoryModel(
      id: 'cat_cpu',
      title: 'CPU Scheduling',
      description: 'FCFS, SJF, Round Robin & Priority Algorithms',
      icon: Icons.speed_rounded,
      accentColor: AppColors.neonPurple,
    ),
    CategoryModel(
      id: 'cat_sync',
      title: 'Process Synchronization',
      description: 'Semaphores, Mutex, Monitored & Classic Problems',
      icon: Icons.sync_lock_rounded,
      accentColor: AppColors.neonBlue,
    ),
    CategoryModel(
      id: 'cat_deadlock',
      title: 'Deadlock',
      description: 'Conditions, Banker\'s Algorithm & Recovery',
      icon: Icons.warning_amber_rounded,
      accentColor: AppColors.neonGold,
    ),
    CategoryModel(
      id: 'cat_memory',
      title: 'Memory Management',
      description: 'Paging, Segmentation, Fit Allocation & Partitions',
      icon: Icons.grid_view_rounded,
      accentColor: AppColors.neonGreen,
    ),
    CategoryModel(
      id: 'cat_vmemory',
      title: 'Virtual Memory',
      description: 'Demand Paging, Page Faults, LRU & Thrashing',
      icon: Icons.cloud_done_rounded,
      accentColor: AppColors.neonCyan,
    ),
    CategoryModel(
      id: 'cat_file',
      title: 'File System',
      description: 'Directory Structures, File Allocation & Storage',
      icon: Icons.folder_copy_rounded,
      accentColor: AppColors.neonPink,
    ),
    CategoryModel(
      id: 'cat_disk',
      title: 'Disk Scheduling',
      description: 'SSTF, SCAN, C-SCAN, LOOK & C-LOOK',
      icon: Icons.disc_full_rounded,
      accentColor: AppColors.neonPurple,
    ),
    CategoryModel(
      id: 'cat_io',
      title: 'I/O Management',
      description: 'Interrupts, Device Drivers, Controllers & DMA',
      icon: Icons.input_rounded,
      accentColor: AppColors.neonBlue,
    ),
  ];

  static final List<TopicModel> allTopics = [
    // ==========================================
    // CATEGORY 1: OS BASICS
    // ==========================================
    const TopicModel(
      id: 'bas_1',
      categoryId: 'cat_basics',
      title: 'What is an Operating System?',
      shortIntro: 'An OS is system software that manages computer hardware and software resources.',
      definition: 'An Operating System (OS) acts as an intermediary between the user of a computer and the computer hardware. Its primary purpose is to provide an environment in which a user can execute programs conveniently and efficiently.',
      conceptExplanation: 'Without an Operating System, users would have to manually write code to communicate directly with hardware components like CPU registers, memory chips, and disk drives. The OS abstracts these hardware details, offering standard APIs and user interfaces.',
      difficulty: 'Beginner',
      readingTime: '3 min read',
      whyWeNeedIt: 'Direct hardware access is error-prone, insecure, and complex. The OS provides hardware abstraction, resource management, and security boundaries.',
      analogy: 'Think of the OS as the manager of a hotel. Guests (applications) request rooms (memory) and room service (CPU time), but the manager handles staff coordination and resource allocation behind the scenes.',
      importantPoints: [
        'Acts as a Resource Allocator (CPU, Memory, I/O devices).',
        'Acts as a Control Program to prevent errors and improper use of the computer.',
        'Provides User Interfaces (CLI, GUI, Touch).',
        'Manages file storage and directory structures.'
      ],
      keyTerms: [
        KeyTermItem(term: 'Hardware', definition: 'Physical components of computer system (CPU, RAM, Disks).'),
        KeyTermItem(term: 'Kernel', definition: 'Core component of the OS with complete control over system resources.'),
        KeyTermItem(term: 'User Interface', definition: 'Means by which user interacts with computer (Shell, GUI).')
      ],
      realWorldApplications: [
        'Linux Kernel in Android smartphones and servers.',
        'Windows NT architecture in desktop PCs.',
        'macOS Darwin kernel in Apple laptops.'
      ],
      examEssentials: [
        'Key goal: Convenience vs Efficiency tradeoff.',
        'Primary role: Resource Allocator & Control Program.',
        'Core components: Kernel, Shell, Device Drivers.'
      ],
      commonMistakes: [
        'Confusing the Operating System with the application software running on top of it.',
        'Thinking the GUI (Graphical User Interface) IS the Operating System itself, rather than just an interface layer.'
      ],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_bas_1',
          question: 'What is the primary core role of an Operating System kernel?',
          options: [
            'Running web browser scripts',
            'Directly managing hardware resources and execution security',
            'Designing graphic user icons',
            'Compiling C code'
          ],
          correctOptionIndex: 1,
          explanation: 'The kernel is the foundational core that manages hardware resources (CPU, Memory, Devices) and enforces access security.',
        ),
      ],
      diagramTitle: 'Operating System Architecture Layer',
      diagramNodes: ['User Layer', 'Application Programs', 'Operating System (Kernel)', 'Computer Hardware'],
      visualizerType: 'os_architecture',
    ),

    const TopicModel(
      id: 'bas_2',
      categoryId: 'cat_basics',
      title: 'Functions of Operating System',
      shortIntro: 'Core responsibilities including memory, process, file, and security management.',
      definition: 'The key functions of an OS encompass managing hardware resources and providing system services to user applications seamlessly.',
      conceptExplanation: 'The main responsibilities of an OS are divided into several key management domains: Process Management, Memory Management, Storage Management, Protection and Security, and I/O Device Management.',
      difficulty: 'Beginner',
      readingTime: '4 min read',
      whyWeNeedIt: 'Multiple user programs competing for system resources need a centralized controller to schedule CPU usage, allocate memory, and prevent hardware clashes.',
      analogy: 'An OS functions like an airport air-traffic controller who coordinates runways (CPU), landing gates (RAM), and flight schedules (processes).',
      importantPoints: [
        'Processor Management: Allocation of CPU time to processes.',
        'Memory Management: Allocation & tracking of RAM slots.',
        'File System Management: Organizing, saving, and retrieving data.',
        'Device Management: Driver handling and I/O buffering.'
      ],
      keyTerms: [
        KeyTermItem(term: 'Multi-tasking', definition: 'Executing multiple processes concurrently.'),
        KeyTermItem(term: 'Spooling', definition: 'Buffering data for asynchronous execution by slower devices.')
      ],
      realWorldApplications: [
        'Multitasking in iOS/Android when switching between apps.',
        'Virtual memory paging in Windows 11.'
      ],
      examEssentials: [
        '5 Main Functions: Process, Memory, Storage, Device, and Security management.',
        'Spooling vs Buffering distinction.'
      ],
      commonMistakes: [
        'Assuming hardware devices communicate with apps directly without OS device drivers.'
      ],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_bas_2',
          question: 'Which OS function prevents one program from overwriting memory used by another program?',
          options: ['Device Management', 'Memory Protection & Management', 'GUI Design', 'File Compression'],
          correctOptionIndex: 1,
          explanation: 'Memory Management tracks address spaces and uses protection limits to prevent illegal RAM access.',
        )
      ],
      visualizerType: 'os_functions',
    ),

    const TopicModel(
      id: 'bas_3',
      categoryId: 'cat_basics',
      title: 'Types of Operating Systems',
      shortIntro: 'Batch, Time-sharing, Distributed, Real-Time, and Embedded Systems.',
      definition: 'Operating Systems are categorized based on their execution paradigms, response speeds, and architecture environments.',
      conceptExplanation: 'Different types of OS cater to specific computing requirements. Batch systems process jobs in groups, Time-sharing systems enable multi-user access via quick CPU switching, Real-Time OS (RTOS) guarantees strict deadline execution, and Distributed OS links independent hardware units.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Different computing workloads require different priorities—e.g. pacemakers need instant deadline guarantees (RTOS), whereas mainframe bill processing requires high batch throughput.',
      analogy: 'Batch OS is like washing clothes in full loads, Time-sharing OS is like a teacher rotating between student desks, and Real-Time OS is like an emergency brake in a car.',
      importantPoints: [
        'Batch OS: Processes jobs without user interaction in queues.',
        'Time-Sharing OS: Switches CPU rapidly among multiple interactive users.',
        'Distributed OS: Uses multiple central processors to serve multiple real-time applications.',
        'Real-Time OS (RTOS): Processing must occur within rigid time bounds (e.g., flight control systems).'
      ],
      keyTerms: [
        KeyTermItem(term: 'Batch Processing', definition: 'Grouping similar jobs together for automated batch execution.'),
        KeyTermItem(term: 'Hard Real-Time', definition: 'Guarantees critical tasks complete strictly on time.')
      ],
      comparisonTable: ComparisonTableModel(
        title: 'OS Type Comparison Matrix',
        headers: ['OS Type', 'Primary Goal', 'Response Time', 'Example Use Case'],
        rows: [
          ['Batch OS', 'Maximize Throughput', 'Hours / Days', 'Payroll processing'],
          ['Time-Sharing OS', 'Minimize Response Time', 'Milliseconds', 'Linux Desktop, macOS'],
          ['Hard RTOS', 'Guarantee Deadlines', 'Microseconds', 'Pacemaker, Flight Control'],
          ['Embedded OS', 'Low Power & Small Footprint', 'Real-Time / Variable', 'Smart Watch, Automotive ECU']
        ],
      ),
      realWorldApplications: [
        'FreeRTOS in IoT sensors and automotive braking systems.',
        'UNIX Time-Sharing systems in university servers.'
      ],
      examEssentials: [
        'Hard Real-Time vs Soft Real-Time difference.',
        'Time-sharing relies heavily on CPU quantum slicing.'
      ],
      commonMistakes: [
        'Confusing Soft Real-Time (best effort) with Hard Real-Time (strict deadline failure = system catastrophe).'
      ],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_bas_3',
          question: 'Which OS type guarantees that critical operations MUST finish within a strict deadline?',
          options: ['Batch OS', 'Hard Real-Time OS (RTOS)', 'Time-Sharing OS', 'Distributed OS'],
          correctOptionIndex: 1,
          explanation: 'Hard RTOS guarantees strict time bounds where missing a deadline constitutes system failure.',
        )
      ],
      visualizerType: 'os_types',
    ),

    const TopicModel(
      id: 'bas_4',
      categoryId: 'cat_basics',
      title: 'OS Services',
      shortIntro: 'Services provided to programs and system users for efficient execution.',
      definition: 'OS services include user interface provision, program execution, I/O operations, file-system manipulation, communications, and error detection.',
      conceptExplanation: 'An OS provides services in two main directions: services for user convenience (UI, Program Execution, I/O, File System) and services for efficient system operation (Resource Allocation, Accounting, Protection).',
      difficulty: 'Beginner',
      readingTime: '3 min read',
      whyWeNeedIt: 'Applications should focus on business logic without having to re-invent file systems, display drivers, or error recovery routines.',
      analogy: 'OS services are like building utilities (electricity, water, plumbing)—every apartment plugs in without building its own power generator.',
      importantPoints: [
        'User Interface: Shell, GUI, CLI.',
        'Program Execution: Loading binary into RAM and executing instructions.',
        'I/O Operations: Device communication handling.',
        'Error Detection: Monitoring CPU, memory, and hardware faults.'
      ],
      realWorldApplications: ['Standard C library POSIX calls in Linux.'],
      examEssentials: ['Categories: User Convenience Services vs System Efficiency Services.'],
      commonMistakes: ['Thinking user apps communicate directly with disk hardware without OS services.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_bas_4',
          question: 'Which service allows programs to read data from storage hardware safely?',
          options: ['Compiler Service', 'I/O Operations & File System Service', 'Web Browser Service', 'Graphic Design Service'],
          correctOptionIndex: 1,
          explanation: 'The OS File System & I/O service abstracts block storage reading into safe APIs.',
        )
      ],
      visualizerType: 'os_services',
    ),

    const TopicModel(
      id: 'bas_5',
      categoryId: 'cat_basics',
      title: 'System Calls',
      shortIntro: 'The programmatic interface between a running application and the OS kernel.',
      definition: 'A System Call provides the mechanism for user programs to request privileged services from the Operating System kernel.',
      conceptExplanation: 'User-level applications cannot directly write to disk or access physical memory due to protection mechanisms. Instead, they trigger system calls (e.g., read(), write(), fork(), exec()), causing a software trap that switches execution to kernel mode.',
      difficulty: 'Intermediate',
      readingTime: '5 min read',
      whyWeNeedIt: 'To enforce security and system integrity by preventing untrusted user apps from directly accessing privileged hardware instructions.',
      analogy: 'A System Call is like ordering food at a bank vault counter—you cannot step inside the vault yourself, so you pass a request slip to a teller (kernel).',
      executionSteps: [
        StepItem(stepNumber: 1, title: 'User Program Call', description: 'Application invokes API function like open() or read().'),
        StepItem(stepNumber: 2, title: 'Trap Exception', description: 'API executes trap instruction to switch mode bit from 1 (User) to 0 (Kernel).'),
        StepItem(stepNumber: 3, title: 'System Call Handler', description: 'Kernel indexes system call table to locate handler function.'),
        StepItem(stepNumber: 4, title: 'Kernel Execution', description: 'Requested hardware operation executed safely.'),
        StepItem(stepNumber: 5, title: 'Mode Switch Return', description: 'Return value returned to user application and mode reset to 1.')
      ],
      importantPoints: [
        'System calls act as the door between User Mode and Kernel Mode.',
        'Categories: Process Control, File Management, Device Management, Information Maintenance, Communication.',
        'Implemented via System Call Interface (SCI) tables.'
      ],
      keyTerms: [
        KeyTermItem(term: 'Trap / Interrupt', definition: 'Software-generated interrupt caused by system call instruction.'),
        KeyTermItem(term: 'API', definition: 'Application Programming Interface (e.g., POSIX, Win32).')
      ],
      realWorldApplications: [
        'C language `open()`, `read()`, `write()`, `fork()`, `exec()` in Linux/UNIX.',
        'Win32 `CreateProcess()`, `ReadFile()` in Windows.'
      ],
      examEssentials: [
        'Mode bit changes from 1 (User) to 0 (Kernel).',
        'Trap instruction triggers software interrupt.',
        'Parameters passed via Registers, Stack, or Memory Block.'
      ],
      commonMistakes: [
        'Confusing API library functions (like C `printf()`) with the underlying System Call (`write()`). `printf()` wraps `write()`.'
      ],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_bas_5',
          question: 'What hardware mechanism is used to switch CPU from User Mode to Kernel Mode during a system call?',
          options: ['Software Trap / Interrupt', 'RAM Clear', 'Disk Read', 'Cache Flush'],
          correctOptionIndex: 0,
          explanation: 'A Trap is a software-generated interrupt that flips the CPU mode bit from 1 (User) to 0 (Kernel).',
        )
      ],
      diagramTitle: 'System Call Execution Flow',
      diagramNodes: ['User Application', 'System Call API', 'Trap / Mode Switch', 'Kernel Handler', 'Hardware Execution'],
      visualizerType: 'system_calls',
    ),

    const TopicModel(
      id: 'bas_6',
      categoryId: 'cat_basics',
      title: 'Kernel',
      shortIntro: 'The core central component of an OS with complete control over system hardware.',
      definition: 'The kernel is the essential foundational code of an OS that remains loaded in main memory and handles memory, process, and hardware management.',
      conceptExplanation: 'Kernel designs generally fall into two main categories: Monolithic Kernels (where all OS services run in a single unified address space) and Microkernels (where minimal services run in kernel space, and components like file systems run in user space).',
      difficulty: 'Intermediate',
      readingTime: '5 min read',
      whyWeNeedIt: 'Without a central kernel running with maximum privilege, software components could not securely coordinate memory allocation, process scheduling, or hardware drivers.',
      analogy: 'The kernel is like the engine room of a ship—it runs continuously, powering steering, fuel lines, and electricity for the upper decks.',
      advantages: [
        'Monolithic: High performance due to shared direct address space calls.',
        'Microkernel: High reliability and security; crash in one service does not crash whole system.'
      ],
      disadvantages: [
        'Monolithic: Harder to maintain; bug in module can crash entire OS.',
        'Microkernel: Performance overhead due to IPC context switching.'
      ],
      comparisonTable: ComparisonTableModel(
        title: 'Monolithic vs Microkernel Architecture',
        headers: ['Property', 'Monolithic Kernel', 'Microkernel'],
        rows: [
          ['Address Space', 'Single unified kernel memory', 'Separate user/kernel services'],
          ['Performance', 'Faster (direct function calls)', 'Slower (IPC overhead)'],
          ['Crash Resilience', 'Low (bug in driver crashes OS)', 'High (isolated service restart)'],
          ['Examples', 'Linux, Windows NT', 'Minix, QNX, seL4']
        ],
      ),
      realWorldApplications: [
        'Linux Monolithic Kernel with loadable kernel modules.',
        'QNX Microkernel in BlackBerry and automotive infotainment systems.'
      ],
      examEssentials: [
        'Monolithic: Speed, shared memory, high coupling.',
        'Microkernel: Modular, high IPC, high reliability.'
      ],
      commonMistakes: [
        'Assuming Microkernels are faster because they are smaller. Microkernels incur extra IPC context switch cost!'
      ],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_bas_6',
          question: 'What is the main advantage of a Microkernel architecture over a Monolithic Kernel?',
          options: ['Higher execution speed', 'Better fault isolation and crash reliability', 'Zero memory consumption', 'No need for IPC'],
          correctOptionIndex: 1,
          explanation: 'In a Microkernel, services like device drivers run in user space, so a driver crash does not crash the core kernel.',
        )
      ],
      visualizerType: 'kernel_arch',
    ),

    const TopicModel(
      id: 'bas_7',
      categoryId: 'cat_basics',
      title: 'User Mode and Kernel Mode',
      shortIntro: 'Dual-mode execution architecture ensuring system hardware protection.',
      definition: 'Dual-mode operation allows the OS to protect itself and system components by distinguishing between user execution and kernel execution.',
      conceptExplanation: 'A Mode Bit (0 for Kernel mode, 1 for User mode) is maintained by CPU hardware. Privileged instructions (like direct I/O manipulation or disabling interrupts) can only be executed when CPU is in Kernel mode (0). Attempting privileged instructions in User mode causes a hardware fault.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'To prevent buggy or malicious user software from directly reconfiguring CPU control registers, disabling system interrupts, or wiping physical disk drives.',
      analogy: 'User Mode is like a restaurant dining room (customers can eat), while Kernel Mode is the kitchen (only trained staff can operate stove burners).',
      importantPoints: [
        'Prevents user programs from overwriting OS code or crashing other processes.',
        'Hardware Mode Bit toggles dynamically on interrupts and system calls.'
      ],
      realWorldApplications: [
        'x86 CPU Ring 0 (Kernel Mode) vs Ring 3 (User Mode) in Intel/AMD processors.'
      ],
      examEssentials: [
        'Mode Bit = 0 ➔ Kernel Mode (Privileged instructions allowed).',
        'Mode Bit = 1 ➔ User Mode (Restricted instructions).',
        'Privileged instructions: Disable interrupts, modify page table base register, direct I/O.'
      ],
      commonMistakes: [
        'Believing user apps can directly execute privileged instructions in User Mode.'
      ],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_bas_7',
          question: 'What happens if an application in User Mode tries to execute a privileged instruction like disabling interrupts?',
          options: [
            'Instruction executes normally',
            'Hardware generates a trap fault and terminates the application',
            'CPU speeds up',
            'OS automatically grants root access'
          ],
          correctOptionIndex: 1,
          explanation: 'CPU hardware checks mode bit; executing privileged instructions in User Mode triggers a hardware exception/fault.',
        )
      ],
      visualizerType: 'dual_mode',
    ),

    const TopicModel(
      id: 'bas_8',
      categoryId: 'cat_basics',
      title: 'Booting Process',
      shortIntro: 'Step-by-step sequence of initializing hardware and loading OS into memory.',
      definition: 'Booting is the startup sequence that initializes the computer system hardware and loads the Operating System kernel into RAM.',
      conceptExplanation: 'When power is turned on, CPU executes code stored in ROM/UEFI known as BIOS. BIOS runs POST (Power-On Self-Test), checks hardware, reads the Bootloader from MBR/GPT, loads the kernel into memory, and transfers control.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'When RAM is powered off, it loses all contents. The boot process is required to transition the computer from cold hardware to a running OS stored on persistent disk.',
      analogy: 'Booting is like starting a car engine on a cold morning—the starter motor (BIOS/Bootloader) cranks the engine until it can run self-sustained.',
      executionSteps: [
        StepItem(stepNumber: 1, title: 'Power On', description: 'Power supply stabilizes and sends signal to CPU.'),
        StepItem(stepNumber: 2, title: 'BIOS / UEFI Execution', description: 'CPU executes firmware stored in non-volatile ROM.'),
        StepItem(stepNumber: 3, title: 'POST (Self-Test)', description: 'Hardware diagnostics test RAM, keyboard, storage drives.'),
        StepItem(stepNumber: 4, title: 'Load Bootloader', description: 'BIOS locates MBR/EFI partition and loads bootloader (e.g., GRUB).'),
        StepItem(stepNumber: 5, title: 'Kernel Initialization', description: 'Bootloader loads OS Kernel into RAM and starts system daemons.')
      ],
      realWorldApplications: [
        'GRUB bootloader in Ubuntu Linux.',
        'Windows Boot Manager (bootmgr) in Windows 11.'
      ],
      examEssentials: [
        'POST: Power-On Self-Test.',
        'Bootstrap loader location: ROM/NVRAM.',
        'MBR: Master Boot Record (Sector 0).'
      ],
      commonMistakes: [
        'Confusing BIOS/UEFI firmware with the OS bootloader.'
      ],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_bas_8',
          question: 'Where is the initial bootstrap loader program stored in computer hardware?',
          options: ['Hard Disk RAM cache', 'ROM / UEFI NVRAM firmware', 'Virtual Memory Swap file', 'CPU L1 Cache'],
          correctOptionIndex: 1,
          explanation: 'The bootstrap loader code is stored in non-volatile ROM/UEFI memory so it persists when powered off.',
        )
      ],
      diagramTitle: 'Booting Process Flowchart',
      diagramNodes: ['Power On', 'BIOS/UEFI Firmware', 'POST Hardware Check', 'GRUB/Bootloader', 'OS Kernel Loaded in RAM'],
      visualizerType: 'booting_process',
    ),

    // ==========================================
    // CATEGORY 2: PROCESS MANAGEMENT
    // ==========================================
    const TopicModel(
      id: 'proc_1',
      categoryId: 'cat_process',
      title: 'Introduction to Processes',
      shortIntro: 'A process is a program in execution containing code, memory, and state.',
      definition: 'A process is an active entity representing a executing program, possessing a program counter, stack, data section, and system resources.',
      conceptExplanation: 'While a program is a passive entity stored on disk (executable file), a process is an active entity in memory with allocated registers, memory boundaries, and execution state.',
      difficulty: 'Beginner',
      readingTime: '4 min read',
      whyWeNeedIt: 'To execute programs concurrently and isolate their execution environments in RAM so one crashing program does not affect others.',
      analogy: 'A program is like a written recipe on paper; a process is the chef actively cooking the dish in the kitchen using ingredients (RAM).',
      importantPoints: [
        'Contains Text Section (Code instructions).',
        'Contains Data Section (Global and static variables).',
        'Contains Heap Section (Dynamically allocated memory during runtime).',
        'Contains Stack Section (Temporary data: function parameters, return addresses, local variables).'
      ],
      realWorldApplications: [
        'Each tab in Google Chrome running as an isolated process.',
        'Linux `ps aux` command inspecting active processes.'
      ],
      examEssentials: [
        'Process (Active) vs Program (Passive).',
        '4 Memory Layout Sections: Text, Data, Heap, Stack.'
      ],
      commonMistakes: [
        'Thinking a program file on disk and a running process are the exact same thing.'
      ],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_proc_1',
          question: 'Which section of a process memory layout holds dynamically allocated memory from malloc() or new?',
          options: ['Text Section', 'Data Section', 'Heap Section', 'Stack Section'],
          correctOptionIndex: 2,
          explanation: 'The Heap section is used for dynamic memory allocation during runtime.',
        )
      ],
      diagramTitle: 'Process Memory Structure in RAM',
      diagramNodes: ['Stack (Grows Down)', 'Heap (Grows Up)', 'Data Section (Globals)', 'Text Section (Code)'],
      visualizerType: 'process_memory',
    ),

    const TopicModel(
      id: 'proc_2',
      categoryId: 'cat_process',
      title: 'Process States',
      shortIntro: 'Lifecycle states a process moves through during execution.',
      definition: 'As a process executes, it changes state depending on CPU allocation, I/O events, and system interrupts.',
      conceptExplanation: 'The 5 classic process states are New, Ready, Running, Waiting (Blocked), and Terminated. Modern OS also include Suspended Ready and Suspended Wait states for memory swapping.',
      difficulty: 'Beginner',
      readingTime: '4 min read',
      whyWeNeedIt: 'To allow the OS CPU scheduler to track which processes are ready for execution versus those waiting for slow disk or network I/O.',
      analogy: 'Process states are like patients in a doctor clinic: New (registration), Ready (waiting room), Running (in doctor office), Waiting (at lab for blood test).',
      executionSteps: [
        StepItem(stepNumber: 1, title: 'New', description: 'The process is being created and loaded into memory.'),
        StepItem(stepNumber: 2, title: 'Ready', description: 'Loaded into RAM waiting to be assigned to CPU by scheduler.'),
        StepItem(stepNumber: 3, title: 'Running', description: 'Instructions are actively executing on the CPU.'),
        StepItem(stepNumber: 4, title: 'Waiting / Blocked', description: 'Waiting for an I/O completion or signal.'),
        StepItem(stepNumber: 5, title: 'Terminated', description: 'Execution finished and resources reclaimed by OS.')
      ],
      realWorldApplications: ['Linux process states `R` (Running/Runnable), `S` (Sleeping), `Z` (Zombie).'],
      examEssentials: ['5 Core States: New, Ready, Running, Waiting, Terminated.', 'Only 1 process per CPU core can be in RUNNING state at any instant.'],
      commonMistakes: ['Thinking a process moves directly from Waiting state back to Running state. It MUST go back to Ready queue first!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_proc_2',
          question: 'When a running process requests a disk I/O read, which state does it transition to?',
          options: ['Ready State', 'Waiting / Blocked State', 'Terminated State', 'New State'],
          correctOptionIndex: 1,
          explanation: 'When waiting for I/O completion, the process leaves the CPU and enters the Waiting (Blocked) state.',
        )
      ],
      diagramTitle: 'Process State Transition Diagram',
      diagramNodes: ['New', 'Ready Queue', 'CPU Running', 'Waiting (I/O)', 'Terminated'],
      visualizerType: 'process_state',
    ),

    const TopicModel(
      id: 'proc_3',
      categoryId: 'cat_process',
      title: 'Process Control Block (PCB)',
      shortIntro: 'Data structure used by OS to store all information about a process.',
      definition: 'The PCB (or Process Descriptor) is a repository of information that varies from process to process, serving as the core process tracking structure.',
      conceptExplanation: 'Whenever a context switch occurs, the OS saves the CPU register values and execution state of the current process into its PCB so it can be resumed later without data loss.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'To support multitasking, the OS must snapshot and restore process execution state when switching CPU between tasks.',
      analogy: 'A PCB is like a bookmark in a book—it records the exact page and paragraph where you stopped reading so you can pick up later.',
      importantPoints: [
        'Process ID (PID) & Parent PID.',
        'Process State (New, Ready, Running, etc.).',
        'Program Counter (Address of next instruction).',
        'CPU Registers (Accumulators, Index registers, Stack pointers).',
        'Memory Management Info (Base/Limit registers, Page tables).',
        'I/O Status & Open File Descriptors.'
      ],
      realWorldApplications: ['Linux `task_struct` structure defined in `<linux/sched.h>`.'],
      examEssentials: ['PCB fields: PID, PC, Registers, State, Memory limits, Open files list.'],
      commonMistakes: ['Confusing PCB memory (stored in OS kernel RAM space) with the user process stack.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_proc_3',
          question: 'Where is the Process Control Block (PCB) maintained by the operating system?',
          options: ['User application memory space', 'OS Kernel Memory space', 'Secondary hard drive MBR', 'GPU Video RAM'],
          correctOptionIndex: 1,
          explanation: 'PCB structures are stored strictly within protected kernel memory space.',
        )
      ],
      visualizerType: 'pcb_structure',
    ),

    const TopicModel(
      id: 'proc_4',
      categoryId: 'cat_process',
      title: 'Context Switching',
      shortIntro: 'Saving state of running process and restoring another process on CPU.',
      definition: 'Context switching is the mechanism of switching the CPU from one process to another, enabling multi-tasking.',
      conceptExplanation: 'Context switching time is pure state-saving overhead because the CPU does no useful work while switching. Hardware support (such as multiple register sets) speeds up context switches significantly.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Without context switching, a computer could only run one process at a time until completion, preventing responsive multi-tasking.',
      analogy: 'Context switching is like a chess master playing 10 games simultaneously—he steps to board 1, moves, notes the state, moves to board 2, and recalls its state.',
      timeComplexity: 'Overhead: ~1 to 10 microseconds per switch.',
      executionSteps: [
        StepItem(stepNumber: 1, title: 'Interrupt / Syscall', description: 'CPU receives timer interrupt or system request.'),
        StepItem(stepNumber: 2, title: 'Save State P1', description: 'CPU register states, PC, and memory limits saved into PCB of Process 1.'),
        StepItem(stepNumber: 3, title: 'Update PCB Status', description: 'Process 1 PCB state updated from Running to Ready/Waiting.'),
        StepItem(stepNumber: 4, title: 'Select Process P2', description: 'Scheduler chooses Process 2 from Ready queue.'),
        StepItem(stepNumber: 5, title: 'Restore State P2', description: 'Load CPU registers and PC from PCB of Process 2.'),
        StepItem(stepNumber: 6, title: 'Resume Execution', description: 'CPU resumes Process 2 execution.')
      ],
      realWorldApplications: ['High-frequency context switches during Linux CPU timesharing.'],
      examEssentials: ['Context Switch Time = Pure System Overhead.', 'Hardware register sets speed up context switching.'],
      commonMistakes: ['Believing useful application work is performed during a context switch interval.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_proc_4',
          question: 'Why is context switching considered OS overhead?',
          options: ['It uses zero CPU cycles', 'The CPU performs no useful user application work while saving and restoring states', 'It deletes process code', 'It increases disk capacity'],
          correctOptionIndex: 1,
          explanation: 'Context switching spends CPU time purely saving/loading kernel states rather than computing application logic.',
        )
      ],
      visualizerType: 'context_switch',
    ),

    const TopicModel(
      id: 'proc_5',
      categoryId: 'cat_process',
      title: 'Threads',
      shortIntro: 'A thread is the lightweight basic unit of CPU utilization.',
      definition: 'A thread comprises a thread ID, a program counter, a register set, and a stack, sharing code section, data section, and OS resources with sibling threads in the same process.',
      conceptExplanation: 'Traditional (heavyweight) processes have a single thread of control. Multi-threaded processes can perform multiple concurrent sub-tasks (e.g., word processor formatting text while saving file).',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Creating processes is heavy and expensive. Threads allow lightweight concurrent execution sharing the same address space.',
      analogy: 'If a process is a house, threads are family members living inside it—sharing the kitchen and living room (data/code), but having separate bedrooms (stacks).',
      advantages: [
        'Responsiveness: Interactive applications keep running even if part is blocked.',
        'Resource Sharing: Threads share process code and data memory directly.',
        'Economy: Creating and switching threads is faster than processes.'
      ],
      disadvantages: ['Lack of Isolation: One thread crashing or corrupting memory affects all sibling threads in process.'],
      realWorldApplications: ['Multi-threaded web servers handling thousands of simultaneous user requests.'],
      examEssentials: ['Threads share: Code, Data, Heap, Open files.', 'Threads have private: Thread ID, PC, Register Set, Stack.'],
      commonMistakes: ['Thinking threads in the same process have separate data sections or heaps. They SHARE memory!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_proc_5',
          question: 'Which memory component is unique and private to each thread within a process?',
          options: ['Heap Section', 'Global Data Section', 'Private Stack & Registers', 'Code Text Section'],
          correctOptionIndex: 2,
          explanation: 'Each thread has its own private Stack and Register set to track function calls and execution context.',
        )
      ],
      visualizerType: 'thread_memory',
    ),

    const TopicModel(
      id: 'proc_6',
      categoryId: 'cat_process',
      title: 'Multithreading',
      shortIntro: 'User-level threads and Kernel-level threads mapping models.',
      definition: 'Multithreading models define how User Threads created by applications map to Kernel Threads managed by the OS kernel.',
      conceptExplanation: 'The three primary mapping models are: Many-to-One (all user threads map to 1 kernel thread), One-to-One (each user thread maps to 1 kernel thread), and Many-to-Many (multiplexes user threads over smaller/equal kernel threads).',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'To enable software applications to utilize multi-core CPU architectures effectively.',
      analogy: 'Multithreading mapping is like bank customers (User Threads) matching with bank tellers (Kernel Threads).',
      comparisonTable: ComparisonTableModel(
        title: 'Multithreading Model Comparison',
        headers: ['Model', 'Mapping', 'Blocking Behavior', 'Concurrency Level'],
        rows: [
          ['Many-to-One', 'N User ➔ 1 Kernel', '1 blocked thread blocks all', 'Low (Single core limit)'],
          ['One-to-One', '1 User ➔ 1 Kernel', '1 blocked thread doesn\'t block others', 'High (Multi-core ready)'],
          ['Many-to-Many', 'N User ➔ M Kernel', 'Best flexibility & non-blocking', 'High']
        ],
      ),
      realWorldApplications: ['Linux NPTL (Native POSIX Thread Library) using One-to-One model (`clone()`).'],
      examEssentials: ['One-to-One is standard in modern OS (Linux, Windows).', 'Many-to-One cannot run in parallel on multi-core CPUs.'],
      commonMistakes: ['Assuming Many-to-One threads can execute simultaneously on multiple CPU cores. They CANNOT!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_proc_6',
          question: 'Which multithreading model is used by modern Linux and Windows operating systems?',
          options: ['Many-to-One', 'One-to-One', 'Zero-to-One', 'Static-Only'],
          correctOptionIndex: 1,
          explanation: 'Modern OS use One-to-One mapping, allowing true multi-core parallel thread execution.',
        )
      ],
      visualizerType: 'multithreading_models',
    ),

    const TopicModel(
      id: 'proc_7',
      categoryId: 'cat_process',
      title: 'Inter Process Communication (IPC)',
      shortIntro: 'Mechanisms allowing processes to communicate and synchronize actions.',
      definition: 'IPC provides mechanisms for process cooperation via Shared Memory or Message Passing.',
      conceptExplanation: 'Cooperatively running processes require IPC to exchange data. In Shared Memory models, processes read/write to a common memory region. In Message Passing models, processes exchange messages via OS primitives (send, receive).',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Independent processes have isolated address spaces. IPC enables data sharing, modularity, and computational speedup.',
      analogy: 'Shared Memory is like a shared whiteboard in an office; Message Passing is like mailing letters between two houses.',
      comparisonTable: ComparisonTableModel(
        title: 'IPC: Shared Memory vs Message Passing',
        headers: ['Feature', 'Shared Memory', 'Message Passing'],
        rows: [
          ['Speed', 'Fast (Direct RAM access)', 'Slower (Kernel system call overhead)'],
          ['Synchronization', 'User process responsibility', 'Handled by OS Kernel'],
          ['Best For', 'Large data transfers on same machine', 'Distributed networks / Microservices']
        ],
      ),
      realWorldApplications: ['Linux Shared Memory (`shmget`, `mmap`) and POSIX Message Queues (`mq_open`).'],
      examEssentials: ['Shared Memory: Fast, user synchronization required.', 'Message Passing: Kernel managed, good for distributed systems.'],
      commonMistakes: ['Forgetting that Shared Memory requires process synchronization locks (Semaphores) to avoid race conditions.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_proc_7',
          question: 'Why is Shared Memory IPC faster than Message Passing IPC for large datasets?',
          options: [
            'It bypasses kernel system calls after setup',
            'It deletes memory contents',
            'It runs without CPU',
            'It uses optical cables'
          ],
          correctOptionIndex: 0,
          explanation: 'Once established, shared memory accesses occur at memory speed without kernel intervention.',
        )
      ],
      visualizerType: 'ipc_mechanisms',
    ),

    const TopicModel(
      id: 'proc_8',
      categoryId: 'cat_process',
      title: 'Process Synchronization',
      shortIntro: 'Managing concurrent process access to shared data to prevent inconsistency.',
      definition: 'Process Synchronization ensures orderly execution of cooperating processes that share logical address space or data.',
      conceptExplanation: 'When multiple processes concurrently write to shared memory, data race conditions occur. Synchronization primitives guarantee mutual exclusion and data consistency.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Unsynchronized concurrent memory access produces non-deterministic data corruption and race conditions.',
      analogy: 'Synchronization is like a single-occupancy fitting room in a clothing store—only one person enters at a time, locking the door.',
      realWorldApplications: ['Database transaction locks and concurrent kernel data structure locks.'],
      examEssentials: ['Goal: Eliminate Race Conditions and enforce Mutual Exclusion.'],
      commonMistakes: ['Assuming concurrent reads cause race conditions. Race conditions require at least one WRITE operation!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_proc_8',
          question: 'What operation MUST occur for a race condition to be possible?',
          options: ['Concurrent Read operations', 'At least one process WRITING to shared data', 'Process termination', 'Disk boot'],
          correctOptionIndex: 1,
          explanation: 'Race conditions occur when concurrent execution includes at least one WRITE modification to shared memory.',
        )
      ],
      visualizerType: 'race_condition_guard',
    ),

    // ==========================================
    // CATEGORY 3: CPU SCHEDULING
    // ==========================================
    const TopicModel(
      id: 'cpu_1',
      categoryId: 'cat_cpu',
      title: 'CPU Scheduling Introduction',
      shortIntro: 'How the OS selects processes from Ready queue to execute on CPU.',
      definition: 'CPU Scheduling is the basis of multi-programmed operating systems, switching CPU among processes to maximize throughput and CPU utilization.',
      conceptExplanation: 'The CPU-I/O Burst Cycle dictates process behavior: processes alternate between CPU execution bursts and I/O wait bursts. The short-term scheduler selects a ready process when CPU becomes idle.',
      difficulty: 'Beginner',
      readingTime: '4 min read',
      whyWeNeedIt: 'CPU is the most expensive hardware core. Scheduling ensures high CPU utilization, high throughput, and fair response times.',
      analogy: 'CPU Scheduling is like a chef managing order tickets in a busy kitchen—deciding which order to cook next to minimize customer wait time.',
      importantPoints: [
        'CPU Utilization: Percentage of time CPU is active.',
        'Throughput: Number of processes completed per time unit.',
        'Turnaround Time (TAT): Total time from submission to completion.',
        'Waiting Time (WT): Total time spent waiting in Ready queue.',
        'Response Time (RT): Time from submission to first response.'
      ],
      formula: 'TAT = Completion Time - Arrival Time | WT = TAT - Burst Time',
      workedExample: WorkedExampleModel(
        title: 'TAT and WT Metric Calculation',
        problemStatement: 'Process P1 arrives at AT=0 ms, has Burst Time BT=6 ms, and finishes at CT=6 ms.',
        inputs: ['Arrival Time (AT) = 0 ms', 'Burst Time (BT) = 6 ms', 'Completion Time (CT) = 6 ms'],
        stepByStepCalculations: [
          'TAT = CT - AT = 6 - 0 = 6 ms',
          'WT = TAT - BT = 6 - 6 = 0 ms'
        ],
        finalResults: ['Turnaround Time = 6 ms', 'Waiting Time = 0 ms'],
        explanation: 'Because P1 arrived at 0 and ran immediately, its waiting time in ready queue was 0.',
      ),
      realWorldApplications: ['Linux Completely Fair Scheduler (CFS) allocating CPU time shares.'],
      examEssentials: [
        'TAT = CT - AT',
        'WT = TAT - BT',
        'Preemptive (can interrupt running process) vs Non-Preemptive (runs till done).'
      ],
      commonMistakes: [
        'Confusing Burst Time (BT) with Turnaround Time (TAT). TAT includes queue waiting time!'
      ],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_cpu_1',
          question: 'What is the formula for calculating Process Waiting Time (WT)?',
          options: ['WT = Completion Time - Arrival Time', 'WT = Turnaround Time - Burst Time', 'WT = Burst Time + Arrival Time', 'WT = Completion Time / 2'],
          correctOptionIndex: 1,
          explanation: 'Waiting Time = Turnaround Time minus Burst Time (WT = TAT - BT).',
        )
      ],
      visualizerType: 'cpu_intro',
    ),

    const TopicModel(
      id: 'cpu_2',
      categoryId: 'cat_cpu',
      title: 'FCFS (First-Come, First-Served)',
      shortIntro: 'Non-preemptive scheduling algorithm serving processes in arrival order.',
      definition: 'First-Come First-Served (FCFS) allocates CPU to the process that requests it first, using a FIFO queue structure.',
      conceptExplanation: 'FCFS is simple to implement using a FIFO queue. However, if a long CPU-bound process arrives before short I/O-bound processes, all subsequent processes wait behind it. This phenomenon is known as the Convoy Effect.',
      difficulty: 'Beginner',
      readingTime: '4 min read',
      whyWeNeedIt: 'Simplest possible algorithm, useful for batch background execution where overhead must be zero.',
      analogy: 'FCFS is like standing in line at a grocery checkout counter—first person in line gets checked out first regardless of items in cart.',
      isAlgorithmTopic: true,
      timeComplexity: 'Queue insertion & retrieval: O(1)',
      formula: 'Waiting Time = Start Time - Arrival Time',
      executionSteps: [
        StepItem(stepNumber: 1, title: 'Arrival Queue', description: 'Processes enter Ready queue sorted by Arrival Time (AT).'),
        StepItem(stepNumber: 2, title: 'Dispatch Process P1', description: 'CPU begins executing head process P1 at t=0.'),
        StepItem(stepNumber: 3, title: 'P1 Completion', description: 'P1 executes till completion burst time finishes.'),
        StepItem(stepNumber: 4, title: 'Dispatch Process P2', description: 'P2 begins immediately after P1.'),
        StepItem(stepNumber: 5, title: 'Compute Averages', description: 'Calculate Average Waiting Time and Average Turnaround Time.')
      ],
      advantages: [
        'Simple, easy to understand and program.',
        'No starvation; every process eventually gets executed.'
      ],
      disadvantages: [
        'Average Waiting Time is often very high.',
        'Suffers from Convoy Effect when large burst process runs first.'
      ],
      workedExample: WorkedExampleModel(
        title: 'FCFS Gantt Chart & Metrics',
        problemStatement: 'Processes P1 (BT=24), P2 (BT=3), P3 (BT=3) all arrive at AT=0 in order P1, P2, P3.',
        inputs: ['P1: AT=0, BT=24', 'P2: AT=0, BT=3', 'P3: AT=0, BT=3'],
        stepByStepCalculations: [
          'Gantt Chart: P1 (0..24), P2 (24..27), P3 (27..30)',
          'P1: CT=24, TAT=24, WT=0',
          'P2: CT=27, TAT=27, WT=24',
          'P3: CT=30, TAT=30, WT=27',
          'Avg TAT = (24+27+30)/3 = 27 ms',
          'Avg WT = (0+24+27)/3 = 17 ms'
        ],
        finalResults: ['Avg Turnaround Time = 27 ms', 'Avg Waiting Time = 17 ms'],
        explanation: 'Notice high Avg WT (17 ms) because short processes P2 & P3 were stuck behind long process P1 (Convoy Effect).',
      ),
      realWorldApplications: ['Batch queue processing in supercomputers.'],
      examEssentials: ['FCFS is Non-Preemptive.', 'Suffers from Convoy Effect.', 'Queue structure: FIFO.'],
      commonMistakes: ['Assuming FCFS can preempt a running process when a new short process arrives. FCFS NEVER preempts!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_cpu_2',
          question: 'What major drawback occurs in FCFS when a long CPU burst process executes before short processes?',
          options: ['Starvation', 'Convoy Effect', 'Belady Anomaly', 'Thrashing'],
          correctOptionIndex: 1,
          explanation: 'The Convoy Effect occurs when short processes wait behind a long execution process in FCFS.',
        )
      ],
      diagramTitle: 'Gantt Chart Execution Timeline',
      diagramNodes: ['P1 (0..24 ms)', 'P2 (24..27 ms)', 'P3 (27..30 ms)'],
      visualizerType: 'cpu_fcfs',
    ),

    const TopicModel(
      id: 'cpu_3',
      categoryId: 'cat_cpu',
      title: 'SJF (Shortest Job First)',
      shortIntro: 'Selects the process with the shortest CPU burst time next.',
      definition: 'Shortest Job First (SJF) associates with each process the length of its next CPU burst, scheduling the shortest burst first.',
      conceptExplanation: 'SJF is provably optimal because it yields the minimum average waiting time for a given set of processes. It can be non-preemptive or preemptive (SRTF).',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'To achieve the minimum possible average waiting time across a set of processes.',
      analogy: 'SJF is like a bank teller serving customers with quick single-deposit slips before processing complex loan applications.',
      isAlgorithmTopic: true,
      timeComplexity: 'Min-Heap Selection: O(N log N)',
      advantages: ['Provably optimal for minimizing average waiting time.'],
      disadvantages: ['Difficulty in knowing length of future CPU burst accurately.', 'Can cause starvation for long processes if short processes keep arriving.'],
      workedExample: WorkedExampleModel(
        title: 'SJF Non-Preemptive Execution',
        problemStatement: 'Processes at AT=0: P1 (BT=6), P2 (BT=8), P3 (BT=7), P4 (BT=3).',
        inputs: ['P1: BT=6', 'P2: BT=8', 'P3: BT=7', 'P4: BT=3'],
        stepByStepCalculations: [
          'Shortest burst is P4 (BT=3). Order: P4 -> P1 -> P3 -> P2',
          'P4 (0..3), P1 (3..9), P3 (9..16), P2 (16..24)',
          'P4: WT=0, P1: WT=3, P3: WT=9, P2: WT=16',
          'Avg WT = (0+3+9+16)/4 = 7 ms'
        ],
        finalResults: ['Execution Sequence: P4 ➔ P1 ➔ P3 ➔ P2', 'Avg Waiting Time = 7 ms'],
        explanation: 'SJF yields 7 ms Avg WT, significantly lower than FCFS (10.25 ms for same inputs).',
      ),
      realWorldApplications: ['Job scheduling in batch environments where estimated job lengths are known.'],
      examEssentials: ['SJF is provably optimal for minimum average waiting time.', 'Main problem: Starvation of long processes.'],
      commonMistakes: ['Thinking SJF can be easily implemented in general desktop OS without knowing future burst times.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_cpu_3',
          question: 'Which scheduling algorithm is provably optimal for minimizing average waiting time?',
          options: ['First-Come First-Served (FCFS)', 'Shortest Job First (SJF)', 'Round Robin (RR)', 'Priority Scheduling'],
          correctOptionIndex: 1,
          explanation: 'SJF is provably optimal because scheduling short jobs first minimizes total waiting accumulators.',
        )
      ],
      visualizerType: 'cpu_sjf',
    ),

    const TopicModel(
      id: 'cpu_4',
      categoryId: 'cat_cpu',
      title: 'SRTF (Shortest Remaining Time First)',
      shortIntro: 'Preemptive version of Shortest Job First scheduling.',
      definition: 'Shortest Remaining Time First (SRTF) preempts the currently running process if a newly arrived process has a shorter remaining burst time.',
      conceptExplanation: 'Whenever a process arrives in the Ready queue, its remaining burst time is compared with the remaining time of the currently running process. If new process is shorter, CPU switches to it.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Preemptive optimization ensuring newly arrived short jobs do not wait behind longer running tasks.',
      analogy: 'SRTF is like an emergency room triage nurse who immediately interrupts a routine checkup if a patient arrives with a severe bleeding emergency.',
      isAlgorithmTopic: true,
      timeComplexity: 'Preemptive Min-Heap Evaluation: O(log N) per arrival',
      advantages: ['Extremely low average waiting time for preemptive jobs.'],
      disadvantages: ['High context switch overhead if many short processes arrive in quick succession.'],
      realWorldApplications: ['Interactive server job scheduling.'],
      examEssentials: ['SRTF = Preemptive SJF.', 'Compares remaining burst times on every process arrival.'],
      commonMistakes: ['Forgetting to recalculate remaining burst time for running process when a new arrival occurs.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_cpu_4',
          question: 'When does SRTF re-evaluate which process to run on the CPU?',
          options: ['Only when current process completes', 'Whenever a new process arrives in the Ready queue', 'Every 10 seconds', 'Never'],
          correctOptionIndex: 1,
          explanation: 'SRTF re-evaluates remaining burst times whenever a new process arrives in the Ready queue.',
        )
      ],
      visualizerType: 'cpu_srtf',
    ),

    const TopicModel(
      id: 'cpu_5',
      categoryId: 'cat_cpu',
      title: 'Round Robin (RR)',
      shortIntro: 'Preemptive scheduling designed specifically for time-sharing systems.',
      definition: 'Round Robin (RR) assigns a fixed time quantum (slice) to each process in a circular FIFO ready queue.',
      conceptExplanation: 'CPU executes a process for up to 1 Time Quantum (TQ). If process burst > TQ, it is preempted and put at tail of Ready queue. If TQ is very large, RR becomes FCFS; if TQ is tiny, context switch overhead dominates.',
      difficulty: 'Intermediate',
      readingTime: '5 min read',
      whyWeNeedIt: 'Fairness and responsiveness. Guarantees interactive users get regular CPU time slices without any process starving.',
      analogy: 'Round Robin is like a board game where each player takes a 1-minute turn before passing the dice to the next person.',
      isAlgorithmTopic: true,
      formula: 'Optimal Time Quantum: ~80% of CPU bursts should be shorter than TQ.',
      workedExample: WorkedExampleModel(
        title: 'Round Robin with Quantum TQ = 4 ms',
        problemStatement: 'Processes P1 (BT=24), P2 (BT=3), P3 (BT=3) at AT=0. Quantum = 4 ms.',
        inputs: ['P1: BT=24', 'P2: BT=3', 'P3: BT=3', 'Time Quantum = 4 ms'],
        stepByStepCalculations: [
          't=0..4: P1 runs for 4 ms (rem=20). Queue: P2, P3, P1',
          't=4..7: P2 runs for 3 ms and finishes (CT=7). Queue: P3, P1',
          't=7..10: P3 runs for 3 ms and finishes (CT=10). Queue: P1',
          't=10..30: P1 finishes remaining 20 ms in 4ms quanta.',
          'P2 WT = 4 ms, P3 WT = 7 ms'
        ],
        finalResults: ['P2 Waiting Time = 4 ms', 'P3 Waiting Time = 7 ms'],
        explanation: 'P2 and P3 responded rapidly (within 4 & 7 ms) despite P1 having a long 24 ms burst.',
      ),
      realWorldApplications: ['Time-sharing multi-user Linux/Windows desktop operating systems.'],
      examEssentials: ['TQ very large ➔ RR becomes FCFS.', 'TQ very small ➔ High context switch overhead.', 'Fair, non-starving.'],
      commonMistakes: ['Setting Time Quantum too small, causing CPU to waste 90% of its time on context switching overhead.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_cpu_5',
          question: 'What happens to Round Robin scheduling if the Time Quantum is set extremely large (infinity)?',
          options: ['It becomes SJF', 'It degenerates into First-Come First-Served (FCFS)', 'It causes deadlock', 'It runs in zero time'],
          correctOptionIndex: 1,
          explanation: 'If Time Quantum is larger than all process burst times, no preemptions occur and RR acts like FCFS.',
        )
      ],
      diagramTitle: 'Round Robin Circular Queue',
      diagramNodes: ['P1 (TQ=4)', 'P2 (TQ=4)', 'P3 (TQ=4)', 'Back to P1 Tail'],
      visualizerType: 'cpu_rr',
    ),

    const TopicModel(
      id: 'cpu_6',
      categoryId: 'cat_cpu',
      title: 'Priority Scheduling',
      shortIntro: 'Schedules processes based on assigned priority numbers.',
      definition: 'Priority Scheduling assigns an integer priority rank to each process, allocating CPU to the process with highest priority.',
      conceptExplanation: 'Priorities can be internal (memory limits, open files) or external (user importance, payment tier). Equal priority processes are scheduled FCFS. Major issue: Starvation (indefinite blocking of low priority processes). Solution: Aging (gradually increasing priority over time).',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Critical system tasks (like audio streaming or hardware interrupts) must execute before background maintenance tasks (like disk indexing).',
      analogy: 'Priority scheduling is like hospital ER admissions—a heart attack patient (high priority) is treated before a mild cold patient (low priority).',
      isAlgorithmTopic: true,
      keyTerms: [
        KeyTermItem(term: 'Starvation', definition: 'Low priority processes wait indefinitely without CPU allocation.'),
        KeyTermItem(term: 'Aging', definition: 'Technique of gradually increasing process priority as time passes.')
      ],
      realWorldApplications: ['Real-time audio drivers vs background virus scanners.'],
      examEssentials: ['Lower number usually means higher priority in OS problems.', 'Starvation solved by Aging.'],
      commonMistakes: ['Confusing low priority rank integer with low urgency. (Conventionally 0 or 1 = highest priority).'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_cpu_6',
          question: 'What technique is used in Priority Scheduling to prevent starvation of low-priority processes?',
          options: ['Aging', 'Paging', 'Spooling', 'Caching'],
          correctOptionIndex: 0,
          explanation: 'Aging gradually increases the priority of processes waiting in the Ready queue over time.',
        )
      ],
      visualizerType: 'cpu_priority',
    ),

    const TopicModel(
      id: 'cpu_7',
      categoryId: 'cat_cpu',
      title: 'Preemptive Scheduling',
      shortIntro: 'CPU can be taken away from running process before completion.',
      definition: 'Preemptive scheduling allows OS scheduler to interrupt and move a running process to Ready queue.',
      conceptExplanation: 'Preemptions occur on timer interrupts, I/O completions, or higher priority process arrivals. Requires robust synchronization to prevent data corruption during state changes.',
      difficulty: 'Intermediate',
      readingTime: '3 min read',
      whyWeNeedIt: 'Ensures system responsiveness and prevents a single rogue process from hogging CPU indefinitely.',
      analogy: 'Preemptive scheduling is like a phone call interrupting your conversation—you pause, answer, and resume later.',
      realWorldApplications: ['All modern desktop and mobile OS (Linux, Windows, macOS, Android).'],
      examEssentials: ['Preemption points: Timer interrupt, I/O completion, Priority arrival.'],
      commonMistakes: ['Assuming non-preemptive systems can forcibly interrupt a running process.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_cpu_7',
          question: 'Which scheduling event causes a preemptive transition from RUNNING to READY state?',
          options: ['Timer Interrupt', 'Process completion', 'Disk format', 'Power off'],
          correctOptionIndex: 0,
          explanation: 'A timer interrupt signals time slice expiry, causing the scheduler to preempt the running process to READY state.',
        )
      ],
      visualizerType: 'cpu_preemptive',
    ),

    const TopicModel(
      id: 'cpu_8',
      categoryId: 'cat_cpu',
      title: 'Non-Preemptive Scheduling',
      shortIntro: 'Running process keeps CPU until it completes or requests I/O wait.',
      definition: 'Non-preemptive scheduling guarantees a process retains CPU control until it terminates or enters waiting state.',
      conceptExplanation: 'Simpler hardware requirements and no race conditions caused by unexpected CPU interruptions, but less responsive for interactive applications.',
      difficulty: 'Intermediate',
      readingTime: '3 min read',
      whyWeNeedIt: 'Simple implementation with zero preemption context switch overhead, ideal for embedded single-purpose systems.',
      analogy: 'Non-preemptive scheduling is like a single-lane bowling alley—once a player throws the ball, nobody else can step on the lane until their turn is completely done.',
      realWorldApplications: ['Early Windows 3.1 co-operative multitasking.'],
      examEssentials: ['Transitions occur ONLY on process termination or I/O wait.'],
      commonMistakes: ['Thinking FCFS is preemptive. FCFS is non-preemptive!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_cpu_8',
          question: 'In non-preemptive scheduling, when does the CPU switch to another process?',
          options: [
            'Only when current process terminates or voluntarily yields for I/O',
            'Every 1 millisecond',
            'On every mouse click',
            'When RAM fills up'
          ],
          correctOptionIndex: 0,
          explanation: 'In non-preemptive scheduling, CPU control cannot be forcibly revoked until the process yields or finishes.',
        )
      ],
      visualizerType: 'cpu_non_preemptive',
    ),

    // ==========================================
    // CATEGORY 4: PROCESS SYNCHRONIZATION
    // ==========================================
    const TopicModel(
      id: 'sync_1',
      categoryId: 'cat_sync',
      title: 'Critical Section Problem',
      shortIntro: 'Code segment accessing shared resources requiring mutually exclusive execution.',
      definition: 'A Critical Section is a region of code where processes access shared variables, tables, or files, requiring synchronization to avoid data corruption.',
      conceptExplanation: 'A valid solution to Critical Section problem must satisfy 3 requirements: 1. Mutual Exclusion, 2. Progress, 3. Bounded Waiting.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'To prevent concurrent processes from modifying shared memory simultaneously, avoiding corrupt state outcomes.',
      analogy: 'A Critical Section is like an airplane restroom—only one passenger can enter at a time (Mutual Exclusion).',
      importantPoints: [
        'Mutual Exclusion: Only 1 process in Critical Section at a time.',
        'Progress: Processes outside Entry Section cannot block waiting processes.',
        'Bounded Waiting: Limit on number of times other processes enter critical section after request made.'
      ],
      realWorldApplications: ['Kernel bank account balances, shared database records.'],
      examEssentials: ['3 Requirements: Mutual Exclusion, Progress, Bounded Waiting.'],
      commonMistakes: ['Forgetting that Progress requirement prohibits processes in Remainder Section from blocking others.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_sync_1',
          question: 'Which of the following is NOT a mandatory requirement for solving the Critical Section problem?',
          options: ['Mutual Exclusion', 'Progress', 'Bounded Waiting', 'High CPU Clock Speed'],
          correctOptionIndex: 3,
          explanation: 'The 3 mandatory requirements are Mutual Exclusion, Progress, and Bounded Waiting.',
        )
      ],
      diagramTitle: 'Critical Section Structure',
      diagramNodes: ['Entry Section (Lock)', 'Critical Section (Shared Access)', 'Exit Section (Unlock)', 'Remainder Section'],
      visualizerType: 'cs_problem',
    ),

    const TopicModel(
      id: 'sync_2',
      categoryId: 'cat_sync',
      title: 'Race Condition',
      shortIntro: 'Inconsistent data output resulting from uncontrolled concurrent execution.',
      definition: 'A Race Condition occurs when multiple processes write/read shared data concurrently, and the outcome depends on execution order.',
      conceptExplanation: 'Example: Two threads incrementing a shared counter simultaneously. If both read counter value 5, increment local register to 6, and write back 6, one increment step is permanently lost.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Understanding race conditions is essential to design correct, bug-free concurrent software.',
      analogy: 'A race condition is like two people withdrawing \$100 from the same bank account at two different ATMs at the exact same millisecond.',
      workedExample: WorkedExampleModel(
        title: 'Lost Increment Race Condition',
        problemStatement: 'Shared variable count = 5. Thread A and Thread B execute `count++` concurrently.',
        inputs: ['Initial count = 5', 'Thread A: read, add 1, write', 'Thread B: read, add 1, write'],
        stepByStepCalculations: [
          'Step 1: Thread A reads count (5)',
          'Step 2: Thread B reads count (5)',
          'Step 3: Thread A increments local reg to 6 and writes count=6',
          'Step 4: Thread B increments local reg to 6 and writes count=6'
        ],
        finalResults: ['Expected count = 7', 'Actual count = 6 (Data Loss!)'],
        explanation: 'Because updates overlapped without locks, 1 increment was overwritten.',
      ),
      realWorldApplications: ['Multithreaded financial transaction software bugs.'],
      examEssentials: ['Race condition outcome depends on non-deterministic execution timing.'],
      commonMistakes: ['Thinking race conditions can occur when all concurrent threads only READ shared variables.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_sync_2',
          question: 'What is a Race Condition?',
          options: [
            'A bug where execution outcome depends on non-deterministic thread execution order',
            'A network speed test',
            'A CPU overclocking mode',
            'A memory defragmenter'
          ],
          correctOptionIndex: 0,
          explanation: 'A Race Condition occurs when multiple threads access shared data concurrently and the final result depends on timing.',
        )
      ],
      visualizerType: 'sync_peterson',
    ),

    const TopicModel(
      id: 'sync_3',
      categoryId: 'cat_sync',
      title: 'Mutual Exclusion',
      shortIntro: 'Ensuring only one process accesses a shared resource at a given instant.',
      definition: 'Mutual Exclusion is the property that no two processes can exist in their critical sections concurrently.',
      difficulty: 'Intermediate',
      readingTime: '3 min read',
      whyWeNeedIt: 'Fundamental principle preventing concurrent data corruption.',
      analogy: 'A single key to a room—whoever holds the key gets into the room, others wait.',
      realWorldApplications: ['Mutex locks in Linux kernel (`pthread_mutex_lock`).'],
      examEssentials: ['Requirement 1 of Critical Section problem.'],
      commonMistakes: ['Confusing Mutual Exclusion with Bounded Waiting.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_sync_3',
          question: 'Mutual Exclusion guarantees that:',
          options: [
            'Only one process is executing in its Critical Section at any time',
            'All processes execute at the same speed',
            'Deadlocks never occur',
            'CPU speed doubles'
          ],
          correctOptionIndex: 0,
          explanation: 'Mutual exclusion guarantees single-process access inside a critical section at any given time.',
        )
      ],
      visualizerType: 'mutex_lock',
    ),

    const TopicModel(
      id: 'sync_4',
      categoryId: 'cat_sync',
      title: 'Peterson\'s Solution',
      shortIntro: 'Classic software-based mutual exclusion algorithm for 2 processes.',
      definition: 'Peterson\'s Algorithm is a classic software solution to critical section problem restricted to 2 processes (P0 and P1).',
      conceptExplanation: 'Uses two shared variables: `bool flag[2]` and `int turn`. Setting `flag[i] = true` indicates intent to enter CS, while `turn = j` yields priority to the other process.',
      difficulty: 'Advanced',
      readingTime: '5 min read',
      whyWeNeedIt: 'Classic theoretical proof showing mutual exclusion can be solved purely in software without hardware instructions.',
      analogy: 'Peterson\'s algorithm is like two polite people at a doorway—each raises a hand (`flag=true`), but insists "after you" (`turn=other`).',
      isAlgorithmTopic: true,
      workedExample: WorkedExampleModel(
        title: 'Peterson Execution Trace',
        problemStatement: 'P0 wants to enter CS: sets flag[0]=true, turn=1. P1 also wants to enter: sets flag[1]=true, turn=0.',
        inputs: ['flag[0]=true, flag[1]=true, turn=0'],
        stepByStepCalculations: [
          'P0 checks loop: while(flag[1] && turn == 1) -> false! P0 enters CS.',
          'P1 checks loop: while(flag[0] && turn == 0) -> true! P1 waits in loop.',
          'P0 finishes CS and sets flag[0]=false.',
          'P1 loop condition becomes false! P1 enters CS.'
        ],
        finalResults: ['Mutual exclusion preserved! P0 ran, then P1 ran.'],
        explanation: 'The `turn` variable resolves ties cleanly when both processes express intent simultaneously.',
      ),
      realWorldApplications: ['Theoretical computer science model for mutual exclusion proofs.'],
      examEssentials: ['Restricted to 2 processes.', 'Variables: `flag[2]` and `turn`.', 'Satisfies all 3 CS requirements.'],
      commonMistakes: ['Expecting Peterson\'s algorithm to work on modern out-of-order execution CPUs without memory barriers.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_sync_4',
          question: 'What is the maximum number of processes supported by Peterson\'s original Algorithm?',
          options: ['1 Process', '2 Processes', '100 Processes', 'Unlimited'],
          correctOptionIndex: 1,
          explanation: 'Peterson\'s original solution is strictly designed for 2 processes (P0 and P1).',
        )
      ],
      visualizerType: 'sync_peterson',
    ),

    const TopicModel(
      id: 'sync_5',
      categoryId: 'cat_sync',
      title: 'Semaphore',
      shortIntro: 'Integer variable used as synchronization primitive via wait() and signal().',
      definition: 'A Semaphore is an integer variable accessed only through atomic operations: wait() [P operation] and signal() [V operation].',
      conceptExplanation: 'Counting Semaphores control access to a finite set of resources (value = available units). Binary Semaphores (value = 0 or 1) operate as Mutex locks.',
      difficulty: 'Intermediate',
      readingTime: '5 min read',
      whyWeNeedIt: 'Provides a robust, OS-managed synchronization primitive capable of controlling access to N resource instances.',
      analogy: 'A Counting Semaphore is like a bouncer at a club holding clickers—decrements count when a guest enters, increments when a guest leaves.',
      formula: 'wait(S): { while(S <= 0); S--; } | signal(S): { S++; }',
      isAlgorithmTopic: true,
      realWorldApplications: ['POSIX semaphores (`sem_wait`, `sem_post`) in Linux.'],
      examEssentials: ['Counting Semaphore (0 to N) vs Binary Semaphore (0 or 1).', 'Atomic operations: wait() [P] decrements, signal() [V] increments.'],
      commonMistakes: ['Reversing wait() and signal() calls, causing immediate deadlock or lock corruption.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_sync_5',
          question: 'What atomic operation is performed by `wait(S)` on a Semaphore variable S?',
          options: ['Increments S', 'Decrements S (blocks if S <= 0)', 'Clears memory', 'Prints log'],
          correctOptionIndex: 1,
          explanation: '`wait(S)` (or P operation) decrements S and blocks the calling process if no resources are available (S <= 0).',
        )
      ],
      visualizerType: 'sync_semaphore',
    ),

    const TopicModel(
      id: 'sync_6',
      categoryId: 'cat_sync',
      title: 'Mutex',
      shortIntro: 'Mutual Exclusion object providing locking mechanisms.',
      definition: 'A Mutex is a locking mechanism used to synchronize access to a resource, possessed by the locking thread.',
      difficulty: 'Intermediate',
      readingTime: '3 min read',
      whyWeNeedIt: 'Ensures strict ownership-based binary locking (only thread that locked mutex can unlock it).',
      analogy: 'A Mutex is like a physical key card to a hotel room—only the holder who checked out the key card can unlock and return it.',
      realWorldApplications: ['`std::mutex` in C++11, `pthread_mutex_t` in C.'],
      examEssentials: ['Binary ownership lock: Only lock owner can release it.'],
      commonMistakes: ['Confusing Binary Semaphore with Mutex. Binary Semaphore has no ownership restriction!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_sync_6',
          question: 'What distinguishes a Mutex from a Binary Semaphore?',
          options: ['Ownership requirement (only lock owner can unlock Mutex)', 'Mutex uses no memory', 'Semaphore is slower', 'No difference'],
          correctOptionIndex: 0,
          explanation: 'A Mutex enforces ownership: only the thread that acquired the lock is allowed to unlock it.',
        )
      ],
      visualizerType: 'mutex_ownership',
    ),

    const TopicModel(
      id: 'sync_7',
      categoryId: 'cat_sync',
      title: 'Monitor',
      shortIntro: 'High-level synchronization construct providing automatic mutual exclusion.',
      definition: 'A Monitor is an abstract data type encapsulating private data and synchronization methods.',
      difficulty: 'Advanced',
      readingTime: '4 min read',
      whyWeNeedIt: 'Low-level semaphores are error-prone. Monitors encapsulate synchronization primitives into language-level structures.',
      analogy: 'A Monitor is like a bank vault with an automated security door—the door automatically allows only 1 customer inside at a time.',
      realWorldApplications: ['Java `synchronized` methods and `wait()`/`notify()` constructs.'],
      examEssentials: ['Language-level construct.', 'Automatic mutual exclusion.', 'Condition variables: wait() and signal().'],
      commonMistakes: ['Thinking Monitors exist at hardware level. They are high-level programming language features!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_sync_7',
          question: 'Which programming language feature natively implements Monitor synchronization?',
          options: ['Java `synchronized` methods', 'C pointers', 'HTML tags', 'Assembly MOV instruction'],
          correctOptionIndex: 0,
          explanation: 'Java `synchronized` keyword provides built-in Monitor mutual exclusion for objects.',
        )
      ],
      visualizerType: 'monitor_construct',
    ),

    const TopicModel(
      id: 'sync_8',
      categoryId: 'cat_sync',
      title: 'Producer Consumer Problem',
      shortIntro: 'Classic synchronization problem using bounded buffer.',
      definition: 'Producer process generates data into shared buffer, while Consumer process retrieves data from buffer.',
      conceptExplanation: 'Requires 3 semaphores: `mutex` (1 for mutual exclusion), `empty` (N for empty slots), `full` (0 for filled slots).',
      difficulty: 'Intermediate',
      readingTime: '5 min read',
      whyWeNeedIt: 'Foundational model for asynchronous communication buffers (e.g. streaming audio buffers, print spoolers).',
      analogy: 'Producer-Consumer is like a bakery chef (producer) placing baked bread on a display rack (bounded buffer) for customers (consumers) to buy.',
      isAlgorithmTopic: true,
      realWorldApplications: ['Circular I/O ring buffers in network socket drivers.'],
      examEssentials: ['Semaphores: `mutex` = 1, `empty` = N, `full` = 0.'],
      commonMistakes: ['Placing `wait(mutex)` BEFORE `wait(empty)`. This causes immediate deadlock when buffer is full!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_sync_8',
          question: 'In the Bounded Buffer Producer-Consumer problem, what is the initial value of the `empty` semaphore for buffer size N?',
          options: ['0', '1', 'N', 'Infinity'],
          correctOptionIndex: 2,
          explanation: 'Initially, all N buffer slots are empty, so the `empty` semaphore is initialized to N.',
        )
      ],
      visualizerType: 'producer_consumer',
    ),

    const TopicModel(
      id: 'sync_9',
      categoryId: 'cat_sync',
      title: 'Readers Writers Problem',
      shortIntro: 'Managing concurrent read and exclusive write accesses.',
      definition: 'Multiple reader processes can read shared dataset simultaneously, but writer processes require exclusive access.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Optimizes concurrent performance by allowing multiple non-conflicting reader processes to access data in parallel.',
      analogy: 'Readers-Writers is like a notice board—20 people can read the announcement simultaneously, but only 1 person can pin up a new notice while nobody is reading.',
      realWorldApplications: ['Read-Write locks (`pthread_rwlock_t`) in database engines.'],
      examEssentials: ['Readers can share access.', 'Writers require exclusive access.', 'First vs Second Readers-Writers problem priority.'],
      commonMistakes: ['Blocking concurrent readers when no writer is active.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_sync_9',
          question: 'Under the Readers-Writers problem rules, how many readers can access shared data concurrently when no writer is present?',
          options: ['Only 1 Reader', 'Maximum 2 Readers', 'Multiple Readers concurrently', 'Zero Readers'],
          correctOptionIndex: 2,
          explanation: 'Multiple readers can safely read shared data concurrently because read operations do not modify memory.',
        )
      ],
      visualizerType: 'readers_writers',
    ),

    const TopicModel(
      id: 'sync_10',
      categoryId: 'cat_sync',
      title: 'Dining Philosophers Problem',
      shortIntro: 'Classic concurrency problem illustrating deadlock and starvation.',
      definition: '5 philosophers sit around a table with 5 chopsticks, requiring 2 chopsticks to eat.',
      conceptExplanation: 'If every philosopher grabs their left chopstick simultaneously, a circular wait deadlock occurs. Solutions include limiting active dining philosophers to 4 or using asymmetric pick-up rules.',
      difficulty: 'Advanced',
      readingTime: '5 min read',
      whyWeNeedIt: 'Benchmark challenge problem for evaluating deadlock avoidance and starvation prevention techniques.',
      analogy: '5 philosophers sitting around a spaghetti table sharing 5 chopsticks.',
      realWorldApplications: ['Allocating multiple restricted resource pairs in distributed clusters.'],
      examEssentials: ['Illustrates Deadlock and Starvation.', 'Solution: Asymmetric chopstick pickup (odd pick left first, even pick right first).'],
      commonMistakes: ['Thinking grabbing left chopstick first by all 5 philosophers avoids deadlock. It GUARANTEES deadlock!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_sync_10',
          question: 'What situation occurs if all 5 philosophers simultaneously pick up their left chopstick?',
          options: ['All philosophers eat smoothly', 'Deadlock (Circular Wait)', 'CPU speed increases', 'RAM clears'],
          correctOptionIndex: 1,
          explanation: 'Every philosopher holds 1 chopstick and waits indefinitely for the right chopstick held by their neighbor (Deadlock).',
        )
      ],
      visualizerType: 'dining_philosophers',
    ),

    // ==========================================
    // CATEGORY 5: DEADLOCK
    // ==========================================
    const TopicModel(
      id: 'dl_1',
      categoryId: 'cat_deadlock',
      title: 'Deadlock Introduction',
      shortIntro: 'A state where processes are permanently blocked waiting for resources held by each other.',
      definition: 'Deadlock is a situation where a set of processes are blocked because each process holds a resource and waits for another resource held by another process in the set.',
      difficulty: 'Beginner',
      readingTime: '4 min read',
      whyWeNeedIt: 'Deadlocks freeze execution permanently, requiring OS mechanisms to prevent, avoid, or recover from them.',
      analogy: 'Deadlock is like a 4-way traffic gridlock intersection where 4 cars arrive simultaneously and block each other from advancing.',
      realWorldApplications: ['Database row lock circular waits.'],
      examEssentials: ['Definition: Permanent blocking of process set due to circular resource dependencies.'],
      commonMistakes: ['Confusing Deadlock with Starvation. Deadlock is permanent freeze; Starvation is indefinite wait for low priority.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_dl_1',
          question: 'How does Deadlock differ from Process Starvation?',
          options: [
            'Deadlock is a permanent freeze involving circular resource waits; Starvation is waiting due to low priority',
            'Deadlock is faster',
            'Starvation uses more RAM',
            'They are identical'
          ],
          correctOptionIndex: 0,
          explanation: 'Deadlock is a permanent circular wait freeze, whereas starvation is indefinite delay caused by priority scheduling.',
        )
      ],
      visualizerType: 'deadlock_intro',
    ),

    const TopicModel(
      id: 'dl_2',
      categoryId: 'cat_deadlock',
      title: 'Necessary Conditions for Deadlock',
      shortIntro: '4 Coffman conditions required simultaneously for a deadlock to occur.',
      definition: 'A deadlock state occurs if and only if all 4 conditions hold true simultaneously.',
      conceptExplanation: 'The 4 Coffman conditions are: 1. Mutual Exclusion, 2. Hold and Wait, 3. No Preemption, 4. Circular Wait.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'If an OS can invalidate even ONE of these 4 conditions, deadlock becomes mathematically impossible.',
      analogy: 'Like a 4-combination safe lock—if you break even 1 tumbler, the lock cannot trigger.',
      importantPoints: [
        '1. Mutual Exclusion: At least one resource held in non-shareable mode.',
        '2. Hold and Wait: Process holds resources while requesting additional ones.',
        '3. No Preemption: Resources cannot be forcibly taken from a process.',
        '4. Circular Wait: A closed chain of processes exists where each waits for a resource held by next process.'
      ],
      realWorldApplications: ['OS deadlock prevention designs.'],
      examEssentials: ['All 4 conditions MUST hold simultaneously for deadlock: Mutual Exclusion, Hold & Wait, No Preemption, Circular Wait.'],
      commonMistakes: ['Thinking deadlock can occur if only 3 conditions hold. ALL 4 are required!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_dl_2',
          question: 'How many Coffman conditions must hold simultaneously for a deadlock to arise?',
          options: ['1 condition', '2 conditions', '3 conditions', 'All 4 conditions'],
          correctOptionIndex: 3,
          explanation: 'Deadlock occurs if and only if all 4 Coffman conditions hold true simultaneously.',
        )
      ],
      visualizerType: 'coffman_conditions',
    ),

    const TopicModel(
      id: 'dl_3',
      categoryId: 'cat_deadlock',
      title: 'Resource Allocation Graph (RAG)',
      shortIntro: 'Directed graph modeling process resource requests and allocations.',
      definition: 'A RAG consists of Process vertices (P), Resource vertices (R), Request edges (P -> R), and Assignment edges (R -> P).',
      conceptExplanation: 'If RAG has no cycles ➔ No Deadlock. If RAG has cycles and 1 instance per resource ➔ Deadlock exists. If multiple instances ➔ Cycle indicates potential deadlock.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Provides a graph theory model to detect deadlock cycles visually and algorithmically.',
      analogy: 'RAG is like a dependency flowchart showing who borrowed what item from whom.',
      realWorldApplications: ['Deadlock detection algorithms in DBMS.'],
      examEssentials: ['P ➔ R: Request Edge.', 'R ➔ P: Assignment Edge.', 'Single instance resource cycle ➔ Guaranteed Deadlock.'],
      commonMistakes: ['Assuming a cycle in a multi-instance RAG guarantees deadlock. (It indicates potential deadlock, not guaranteed).'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_dl_3',
          question: 'In a Resource Allocation Graph where every resource has strictly 1 single instance, what does a cycle indicate?',
          options: ['Guaranteed Deadlock', 'System is safe', 'High throughput', 'RAM overflow'],
          correctOptionIndex: 0,
          explanation: 'In single-instance resource systems, a cycle in the RAG is a necessary and sufficient condition for deadlock.',
        )
      ],
      visualizerType: 'deadlock_rag',
    ),

    const TopicModel(
      id: 'dl_4',
      categoryId: 'cat_deadlock',
      title: 'Deadlock Prevention',
      shortIntro: 'Invalidating at least 1 of 4 necessary deadlock conditions.',
      definition: 'Deadlock Prevention methods ensure that system configuration invalidates at least one of the 4 Coffman conditions.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Guarantees deadlocks never happen by design constraints.',
      analogy: 'Like designing a roundabout junction so cars can never form a 4-way static traffic gridlock.',
      realWorldApplications: ['Total ordering of locks in Linux kernel programming guidelines.'],
      examEssentials: ['Prevent Hold & Wait: Request all resources at start.', 'Prevent Circular Wait: Enforce strict linear resource ordering.'],
      commonMistakes: ['Confusing Deadlock Prevention (static design rules) with Deadlock Avoidance (dynamic safety checks).'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_dl_4',
          question: 'How can an OS prevent the Circular Wait condition statically?',
          options: [
            'Assign a global numerical order to all resources and require processes to request in increasing order',
            'Delete all files',
            'Turn off CPU',
            'Use infinite RAM'
          ],
          correctOptionIndex: 0,
          explanation: 'Imposing a strict total ordering on resource requests prevents circular wait cycles.',
        )
      ],
      visualizerType: 'deadlock_prevention',
    ),

    const TopicModel(
      id: 'dl_5',
      categoryId: 'cat_deadlock',
      title: 'Deadlock Avoidance',
      shortIntro: 'Dynamic evaluation of safe states before allocating requested resources.',
      definition: 'Deadlock Avoidance requires OS to know advance information regarding process resource requests to grant only safe allocations.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Allows higher resource utilization than strict prevention while dynamically guaranteeing system never enters an unsafe state.',
      analogy: 'Deadlock Avoidance is like a banker checking total cash reserves before granting a loan to ensure all clients can eventually be paid out.',
      realWorldApplications: ['Banker\'s Algorithm models.'],
      examEssentials: ['Safe State ➔ Deadlock impossible.', 'Unsafe State ➔ Potential for deadlock.'],
      commonMistakes: ['Equating Unsafe State directly with Deadlock. Unsafe state means potential deadlock, not immediate deadlock!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_dl_5',
          question: 'Is an Unsafe State automatically a Deadlock state?',
          options: ['No, an unsafe state only creates the potential for deadlock', 'Yes, always', 'Only in 32-bit OS', 'Never'],
          correctOptionIndex: 0,
          explanation: 'An unsafe state is not a deadlock; it is simply a state from which the OS cannot guarantee avoiding deadlock if worst-case claims occur.',
        )
      ],
      visualizerType: 'deadlock_avoidance',
    ),

    const TopicModel(
      id: 'dl_6',
      categoryId: 'cat_deadlock',
      title: 'Banker\'s Algorithm',
      shortIntro: 'Classic deadlock avoidance algorithm for multiple resource instances.',
      definition: 'Banker\'s Algorithm tests for safety by simulating allocation for predetermined maximum possible claims of all processes.',
      conceptExplanation: 'Maintains matrices: `Allocation`, `Max`, `Available`, and computes `Need = Max - Allocation`. Finds a safe sequence <P0, P1, ... Pn> where Need <= Available.',
      difficulty: 'Advanced',
      readingTime: '6 min read',
      whyWeNeedIt: 'The canonical algorithm for deadlock avoidance in multi-instance resource systems.',
      analogy: 'A credit bank ensuring it holds enough liquid cash to satisfy maximum credit lines of borrowing businesses step-by-step.',
      isAlgorithmTopic: true,
      formula: 'Need[i][j] = Max[i][j] - Allocation[i][j]',
      workedExample: WorkedExampleModel(
        title: 'Banker Safety Sequence Calculation',
        problemStatement: '5 processes (P0..P4), 3 resources (A,B,C). Available = [3, 3, 2].',
        inputs: [
          'Available = [3, 3, 2]',
          'P1 Need = [1, 2, 2] <= Available [3, 3, 2] ➔ P1 completes!'
        ],
        stepByStepCalculations: [
          'Step 1: P1 finishes ➔ New Available = [3,3,2] + Alloc[P1] = [5, 3, 2]',
          'Step 2: P3 Need = [0, 1, 1] <= [5, 3, 2] ➔ P3 completes! New Available = [7, 4, 3]',
          'Step 3: P4 Need = [4, 3, 1] <= [7, 4, 3] ➔ P4 completes! New Available = [7, 4, 5]',
          'Step 4: P0 & P2 complete successfully.'
        ],
        finalResults: ['Safe Sequence Found: < P1, P3, P4, P0, P2 >', 'System is SAFE!'],
        explanation: 'Because a complete safe execution sequence exists, the system is in a Safe State.',
      ),
      realWorldApplications: ['Resource allocation testing models.'],
      examEssentials: ['Need = Max - Allocation.', 'Safe sequence existence proves safe state.'],
      commonMistakes: ['Forgetting to add back allocated resources to Available when a process completes in the simulation.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_dl_6',
          question: 'What is the formula used to calculate the Need matrix in Banker\'s Algorithm?',
          options: ['Need = Max - Allocation', 'Need = Allocation + Available', 'Need = Max / 2', 'Need = Available - Max'],
          correctOptionIndex: 0,
          explanation: 'The remaining resource Need for process i is Need[i] = Max[i] - Allocation[i].',
        )
      ],
      visualizerType: 'bankers',
    ),

    const TopicModel(
      id: 'dl_7',
      categoryId: 'cat_deadlock',
      title: 'Deadlock Detection',
      shortIntro: 'Algorithms identifying existing deadlock states in running systems.',
      definition: 'Deadlock Detection uses cycle-detection on wait-for graphs or modified Banker\'s algorithm to locate deadlocked process sets.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Used in systems that do not use strict prevention/avoidance, allowing deadlock to occur and detecting it periodically.',
      analogy: 'Deadlock detection is like a security guard walking around the building checking if any workers are stuck behind locked doors.',
      realWorldApplications: ['PostgreSQL and MySQL InnoDB deadlock detection threads.'],
      examEssentials: ['Wait-for Graph (WFG) used for single-instance resources.', 'Periodic detection invocation.'],
      commonMistakes: ['Running deadlock detection on every single instruction, creating massive CPU overhead.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_dl_7',
          question: 'Which simplified graph representation is created by collapsing resource nodes in a single-instance RAG for deadlock detection?',
          options: ['Wait-For Graph (WFG)', 'Tree Graph', 'Bipartite Graph', 'Gantt Chart'],
          correctOptionIndex: 0,
          explanation: 'A Wait-For Graph (WFG) removes resource nodes, leaving direct process-to-process wait edges.',
        )
      ],
      visualizerType: 'deadlock_detection',
    ),

    const TopicModel(
      id: 'dl_8',
      categoryId: 'cat_deadlock',
      title: 'Deadlock Recovery',
      shortIntro: 'Techniques to break deadlocks (Process Termination & Resource Preemption).',
      definition: 'Recovery options include aborting all deadlocked processes or aborting one process at a time until cycle is broken.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Once a deadlock is detected, recovery mechanisms break the cycle to restore system progress.',
      analogy: 'Deadlock recovery is like a traffic cop towing away 1 stuck car to let the rest of the intersection flow.',
      importantPoints: [
        'Process Termination: Abort all deadlocked processes OR abort 1 by 1.',
        'Resource Preemption: Rollback process state and preempt resources.'
      ],
      realWorldApplications: ['DBMS aborting candidate transaction when deadlock cycle detected.'],
      examEssentials: ['Options: Process Termination vs Resource Preemption.', 'Rollback requires checkpointing.'],
      commonMistakes: ['Aborting all deadlocked processes when aborting just 1 process breaks the cycle.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_dl_8',
          question: 'What is the minimum recovery action required to break a single deadlock cycle?',
          options: [
            'Abort 1 process in the deadlock cycle (or preempt its resource)',
            'Reformat hard disk',
            'Power down server for 2 hours',
            'Reinstall OS'
          ],
          correctOptionIndex: 0,
          explanation: 'Aborting just 1 process in the cycle breaks the circular wait condition and restores execution.',
        )
      ],
      visualizerType: 'deadlock_rag',
    ),

    // ==========================================
    // CATEGORY 6: MEMORY MANAGEMENT
    // ==========================================
    const TopicModel(
      id: 'mem_1',
      categoryId: 'cat_memory',
      title: 'Memory Management Introduction',
      shortIntro: 'Loading programs into RAM, tracking free memory, and address binding.',
      definition: 'Memory Management is the OS component that coordinates primary memory allocation, tracking used and free memory blocks.',
      difficulty: 'Beginner',
      readingTime: '4 min read',
      whyWeNeedIt: 'RAM is limited. The OS must allocate memory for active programs, protect process boundaries, and reclaim memory when programs terminate.',
      analogy: 'Memory Management is like a parking lot attendant assigning spaces to cars and updating the free spaces board.',
      realWorldApplications: ['Linux virtual memory subsystem.'],
      examEssentials: ['Primary Memory (RAM) tracking.', 'Logical vs Physical Address Spaces.'],
      commonMistakes: ['Confusing physical RAM address with virtual/logical compiled memory addresses.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_mem_1',
          question: 'What is the main task of OS Memory Management?',
          options: ['Tracking free and allocated main memory (RAM)', 'Designing graphics', 'Formatting disk drives', 'Compiling code'],
          correctOptionIndex: 0,
          explanation: 'Memory Management tracks RAM blocks, allocates memory to active processes, and reclaims memory on exit.',
        )
      ],
      visualizerType: 'memory_intro',
    ),

    const TopicModel(
      id: 'mem_2',
      categoryId: 'cat_memory',
      title: 'Contiguous Memory Allocation',
      shortIntro: 'Each process is contained in a single contiguous memory block.',
      definition: 'Processes are allocated consecutive physical memory addresses bounded by Base and Limit registers.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Early memory allocation scheme providing hardware-enforced memory protection using Base & Limit registers.',
      analogy: 'Contiguous allocation is like reserving a continuous block of seats (Seats 10 to 15) for a family in a movie theater.',
      formula: 'Physical Address = Base Register + Logical Address (if Logical Address < Limit)',
      realWorldApplications: ['Early operating system memory structures.'],
      examEssentials: ['Base Register: Starting physical RAM address.', 'Limit Register: Range size of process memory.'],
      commonMistakes: ['Allowing logical address >= Limit register. This causes a memory trap fault!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_mem_2',
          question: 'What happens if a process attempts to access a logical address >= Limit Register?',
          options: ['Trap Exception / Addressing Fault', 'Access granted', 'Memory doubles', 'Program finishes'],
          correctOptionIndex: 0,
          explanation: 'Addressing outside the Limit register boundary causes a hardware protection trap fault.',
        )
      ],
      visualizerType: 'memory_allocation',
    ),

    const TopicModel(
      id: 'mem_3',
      categoryId: 'cat_memory',
      title: 'Fixed Partitioning (MFT)',
      shortIntro: 'Dividing memory into fixed size partitions at system startup.',
      definition: 'Multiprogramming with Fixed Tasks (MFT) divides RAM into static partitions. Causes internal fragmentation.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Simple static memory partitioning scheme used in early multiprogramming OS.',
      analogy: 'Fixed partitioning is like a parking lot with fixed large truck spaces—small cars park in large spaces, wasting leftover room.',
      importantPoints: [
        'Static partition sizes set at boot.',
        'Major Drawback: Internal Fragmentation (wasted RAM inside partition).'
      ],
      realWorldApplications: ['IBM OS/360 MFT.'],
      examEssentials: ['MFT suffers from Internal Fragmentation.'],
      commonMistakes: ['Confusing Internal Fragmentation (inside partition) with External Fragmentation (between partitions).'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_mem_3',
          question: 'What type of fragmentation is caused by Fixed Partitioning (MFT)?',
          options: ['Internal Fragmentation', 'External Fragmentation', 'Disk Fragmentation', 'Network Latency'],
          correctOptionIndex: 0,
          explanation: 'Fixed partitions cause Internal Fragmentation when process size is smaller than the static partition size.',
        )
      ],
      visualizerType: 'fixed_partitioning',
    ),

    const TopicModel(
      id: 'mem_4',
      categoryId: 'cat_memory',
      title: 'Variable Partitioning (MVT)',
      shortIntro: 'Dynamic memory allocation allocated exactly according to process size.',
      definition: 'Multiprogramming with Variable Tasks (MVT) creates partitions dynamically. Eliminates internal fragmentation but causes external fragmentation.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Eliminates wasted space inside partitions by sizing RAM allocations exactly to match process requests.',
      analogy: 'Variable partitioning is like custom cutting a piece of fabric off a roll to match exact customer measurements.',
      importantPoints: [
        'Dynamic partition sizes.',
        'Eliminates Internal Fragmentation.',
        'Major Drawback: External Fragmentation (scattered small free holes).'
      ],
      realWorldApplications: ['Dynamic heap memory allocation managers.'],
      examEssentials: ['MVT suffers from External Fragmentation.', 'Solution to External Frag: Compaction or Paging.'],
      commonMistakes: ['Thinking compaction can be performed without dynamic address relocation hardware.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_mem_4',
          question: 'What technique can be used to eliminate External Fragmentation in Variable Partitioning?',
          options: ['Compaction (Memory Defragmentation)', 'Increasing clock speed', 'Deleting OS', 'Disabling CPU'],
          correctOptionIndex: 0,
          explanation: 'Compaction shifts all allocated memory blocks together to merge scattered free holes into one large contiguous block.',
        )
      ],
      visualizerType: 'variable_partitioning',
    ),

    const TopicModel(
      id: 'mem_5',
      categoryId: 'cat_memory',
      title: 'First Fit Allocation',
      shortIntro: 'Allocates the first hole in memory that is big enough.',
      definition: 'First Fit searches free memory list from start and allocates process to the first free block >= process size.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Fastest contiguous memory allocation strategy.',
      analogy: 'First Fit is like taking the very first open parking spot you see when entering a parking lot.',
      isAlgorithmTopic: true,
      timeComplexity: 'O(N) searching list from start.',
      advantages: ['Fastest allocation algorithm.'],
      disadvantages: ['Accumulates small unusable fragments at the beginning of memory list.'],
      workedExample: WorkedExampleModel(
        title: 'First Fit Memory Placement',
        problemStatement: 'Free memory holes: [100KB, 500KB, 200KB, 300KB, 600KB]. Request: Process 212KB.',
        inputs: ['Holes: 100, 500, 200, 300, 600', 'Process Size = 212 KB'],
        stepByStepCalculations: [
          'Hole 1 (100KB): 100 < 212 ➔ Skip',
          'Hole 2 (500KB): 500 >= 212 ➔ ALLOCATE to Hole 2!'
        ],
        finalResults: ['Allocated to 500KB Hole', 'Remaining free hole = 288 KB'],
        explanation: 'First Fit stops searching as soon as it finds the first hole >= process size.',
      ),
      realWorldApplications: ['Fast runtime memory allocators.'],
      examEssentials: ['First Fit is generally fastest compared to Best Fit and Worst Fit.'],
      commonMistakes: ['Continuing to search the list after finding the first fitting hole.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_mem_5',
          question: 'Which block will First Fit select for a 212KB process given free blocks [100KB, 500KB, 200KB, 300KB]?',
          options: ['100KB Block', '500KB Block', '200KB Block', '300KB Block'],
          correctOptionIndex: 1,
          explanation: '500KB is the FIRST block in list order that is >= 212KB.',
        )
      ],
      visualizerType: 'first_fit',
    ),

    const TopicModel(
      id: 'mem_6',
      categoryId: 'cat_memory',
      title: 'Best Fit Allocation',
      shortIntro: 'Allocates the smallest hole in memory that is big enough.',
      definition: 'Best Fit searches entire list to allocate the smallest available block >= process size, minimizing leftover wasted memory.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Minimizes immediate leftover space when allocating a block.',
      analogy: 'Best Fit is like looking for the tightest fitting box in your garage to pack a gift.',
      isAlgorithmTopic: true,
      timeComplexity: 'O(N) searching entire list.',
      advantages: ['Leaves minimum immediate leftover space in chosen block.'],
      disadvantages: ['Produces tiny unusable leftover fragments across RAM.'],
      workedExample: WorkedExampleModel(
        title: 'Best Fit Memory Placement',
        problemStatement: 'Free memory holes: [100KB, 500KB, 200KB, 300KB, 600KB]. Request: Process 212KB.',
        inputs: ['Holes: 100, 500, 200, 300, 600', 'Process Size = 212 KB'],
        stepByStepCalculations: [
          'Holes >= 212: 500KB (leftover 288), 300KB (leftover 88), 600KB (leftover 388)',
          'Smallest leftover = 300KB hole (88 KB leftover).'
        ],
        finalResults: ['Allocated to 300KB Hole', 'Remaining free hole = 88 KB'],
        explanation: 'Best Fit searched all holes and picked 300KB because it yielded the smallest leftover (88KB).',
      ),
      realWorldApplications: ['Memory allocators prioritizing tight block fitting.'],
      examEssentials: ['Best Fit requires searching ENTIRE list (unless sorted).'],
      commonMistakes: ['Stopping search early before checking remaining list blocks.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_mem_6',
          question: 'Which block will Best Fit select for a 212KB process given free blocks [100KB, 500KB, 200KB, 300KB]?',
          options: ['100KB Block', '500KB Block', '200KB Block', '300KB Block'],
          correctOptionIndex: 3,
          explanation: '300KB is the smallest block >= 212KB, leaving the minimum leftover fragment (88KB).',
        )
      ],
      visualizerType: 'best_fit',
    ),

    const TopicModel(
      id: 'mem_7',
      categoryId: 'cat_memory',
      title: 'Worst Fit Allocation',
      shortIntro: 'Allocates the largest hole available in memory.',
      definition: 'Worst Fit searches entire list and allocates process to largest available hole, producing large leftover remaining holes.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Hypothesized to leave large remaining holes that are usable for future process requests.',
      analogy: 'Worst Fit is like packing a small item into your largest suitcase so there is plenty of room left over.',
      isAlgorithmTopic: true,
      timeComplexity: 'O(N) searching entire list.',
      workedExample: WorkedExampleModel(
        title: 'Worst Fit Memory Placement',
        problemStatement: 'Free memory holes: [100KB, 500KB, 200KB, 300KB, 600KB]. Request: Process 212KB.',
        inputs: ['Holes: 100, 500, 200, 300, 600', 'Process Size = 212 KB'],
        stepByStepCalculations: [
          'Largest hole in list = 600KB.',
          'Allocate 212KB to 600KB hole. Leftover = 388 KB.'
        ],
        finalResults: ['Allocated to 600KB Hole', 'Remaining free hole = 388 KB'],
        explanation: 'Worst Fit selects 600KB because it is the largest available block.',
      ),
      realWorldApplications: ['Experimental memory allocation benchmarks.'],
      examEssentials: ['Worst Fit selects the LARGEST available hole.'],
      commonMistakes: ['Confusing Worst Fit with Best Fit.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_mem_7',
          question: 'Which block will Worst Fit select for a 212KB process given free blocks [100KB, 500KB, 200KB, 300KB, 600KB]?',
          options: ['500KB Block', '300KB Block', '600KB Block', '100KB Block'],
          correctOptionIndex: 2,
          explanation: '600KB is the largest hole in the list.',
        )
      ],
      visualizerType: 'worst_fit',
    ),

    const TopicModel(
      id: 'mem_8',
      categoryId: 'cat_memory',
      title: 'Next Fit Allocation',
      shortIntro: 'Variant of First Fit searching from the last allocation point.',
      definition: 'Next Fit starts searching for free holes from location of previous allocation.',
      difficulty: 'Intermediate',
      readingTime: '3 min read',
      whyWeNeedIt: 'Avoids clustering small free holes at the beginning of the memory list.',
      analogy: 'Next Fit is like continuing your search for a parking spot from where you last parked rather than going back to the entrance.',
      isAlgorithmTopic: true,
      realWorldApplications: ['Circular list memory allocators.'],
      examEssentials: ['Variant of First Fit using a moving cursor.'],
      commonMistakes: ['Resetting search pointer to index 0. Next Fit resumes from last allocation index!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_mem_8',
          question: 'Where does Next Fit begin searching for a free memory block?',
          options: ['From index 0', 'From the location of the previous allocation', 'From the end of RAM', 'Randomly'],
          correctOptionIndex: 1,
          explanation: 'Next Fit resumes searching from where the previous allocation occurred.',
        )
      ],
      visualizerType: 'next_fit',
    ),

    const TopicModel(
      id: 'mem_9',
      categoryId: 'cat_memory',
      title: 'Paging',
      shortIntro: 'Non-contiguous memory allocation dividing physical RAM into fixed Frames and virtual space into Pages.',
      definition: 'Paging is a memory management scheme that permits process physical address space to be non-contiguous.',
      conceptExplanation: 'Logical Memory is divided into fixed-size blocks called Pages. Physical RAM is divided into fixed-size blocks called Frames of identical size. The Page Table translates Page Number (p) to Frame Number (f).',
      difficulty: 'Advanced',
      readingTime: '6 min read',
      whyWeNeedIt: 'Completely eliminates External Fragmentation and allows non-contiguous physical RAM allocation.',
      analogy: 'Paging is like dividing a 500-page book into loose single pages that can be stored in any random empty shelf slot (frame) while keeping a table of contents (Page Table).',
      formula: 'Logical Address = Page Number (p) + Offset (d) | Physical Address = Frame Number (f) * Page Size + Offset (d)',
      workedExample: WorkedExampleModel(
        title: 'Paging Address Translation',
        problemStatement: 'Page size = 1024 Bytes (1 KB). Logical Address = 2172. Page Table: Page 2 ➔ Frame 5.',
        inputs: ['Logical Address = 2172', 'Page Size = 1024 B', 'Page Table[2] = Frame 5'],
        stepByStepCalculations: [
          'Page Number (p) = 2172 / 1024 = 2',
          'Offset (d) = 2172 % 1024 = 124',
          'Frame Number (f) = Page Table[2] = 5',
          'Physical Address = (5 * 1024) + 124 = 5120 + 124 = 5244'
        ],
        finalResults: ['Page p = 2, Offset d = 124', 'Physical RAM Address = 5244'],
        explanation: 'The hardware MMU translates page 2 to frame 5 and adds the offset 124 to yield physical address 5244.',
      ),
      realWorldApplications: ['x86-64 MMU paging architecture in Linux and Windows.'],
      examEssentials: [
        'Page Size = Frame Size.',
        'Page Table maps Page # (p) ➔ Frame # (f).',
        'Physical Address = (Frame # * Page Size) + Offset.'
      ],
      commonMistakes: [
        'Modifying the Offset (d) during address translation. Offset d NEVER changes during translation!'
      ],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_mem_9',
          question: 'What happens to the Offset (d) during Paging address translation?',
          options: ['It is multiplied by 2', 'It remains completely unchanged', 'It is set to 0', 'It is converted to hexadecimal'],
          correctOptionIndex: 1,
          explanation: 'Offset (d) represents position within the page/frame and is copied directly to physical address unchanged.',
        )
      ],
      diagramTitle: 'Paging Address Translation Hardware',
      diagramNodes: ['Logical Address (p, d)', 'Page Table Lookup [p -> f]', 'Physical Address (f, d)', 'Main Memory RAM'],
      visualizerType: 'paging_translation',
    ),

    const TopicModel(
      id: 'mem_10',
      categoryId: 'cat_memory',
      title: 'Segmentation',
      shortIntro: 'Memory allocation scheme dividing memory according to logical user modules.',
      definition: 'Segmentation supports user view of memory where address space consists of variable-length segments (Code, Stack, Symbol table).',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Reflects the programmer view of memory (functions, objects, stack) rather than arbitrary fixed physical page boundaries.',
      analogy: 'Segmentation is like dividing a book into logical chapters (Intro, Chapter 1, Appendix) rather than arbitrary equal-sized pages.',
      formula: 'Physical Address = Segment Base + Offset (if Offset < Segment Limit)',
      comparisonTable: ComparisonTableModel(
        title: 'Paging vs Segmentation Comparison',
        headers: ['Property', 'Paging', 'Segmentation'],
        rows: [
          ['Block Size', 'Fixed physical size (e.g. 4KB)', 'Variable logical size'],
          ['User View', 'Transparent to user programmer', 'Visible logical user view'],
          ['Fragmentation', 'Internal Fragmentation', 'External Fragmentation'],
          ['Hardware Table', 'Page Table (p ➔ f)', 'Segment Table (Base, Limit)']
        ],
      ),
      realWorldApplications: ['x86 Segment registers (CS, DS, SS, ES).'],
      examEssentials: ['Segment Table stores Base (start RAM) and Limit (length).', 'Offset MUST be < Limit.'],
      commonMistakes: ['Confusing Segment Limit (length) with Frame Size.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_mem_10',
          question: 'In Segmentation, what two values are stored in each Segment Table entry?',
          options: ['Base Address and Limit (Length)', 'Page number and Frame number', 'Disk sector and Cylinder', 'IP address and Port'],
          correctOptionIndex: 0,
          explanation: 'Segment Table entries contain the physical Base starting address and the Segment Limit length.',
        )
      ],
      visualizerType: 'segmentation_translation',
    ),

    // ==========================================
    // CATEGORY 7: VIRTUAL MEMORY
    // ==========================================
    const TopicModel(
      id: 'vm_1',
      categoryId: 'cat_vmemory',
      title: 'Virtual Memory',
      shortIntro: 'Executing processes larger than physical RAM by utilizing disk swap storage.',
      definition: 'Virtual Memory is a technique that allows execution of processes that are not completely loaded in physical RAM.',
      difficulty: 'Beginner',
      readingTime: '4 min read',
      whyWeNeedIt: 'Enables running large programs (e.g., 16 GB game) on computers with smaller physical RAM (e.g., 8 GB RAM).',
      analogy: 'Virtual Memory is like having a small desk (RAM) and a large bookshelf (Disk)—you keep active files on the desk and swap inactive folders back to the bookshelf.',
      realWorldApplications: ['Windows `pagefile.sys` and Linux Swap partitions.'],
      examEssentials: ['Decouples logical memory from physical RAM.', 'Uses secondary storage as swap area.'],
      commonMistakes: ['Believing Virtual Memory makes physical RAM faster. It allows larger execution, but swap disk access is slower.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_vm_1',
          question: 'What is the primary benefit of Virtual Memory?',
          options: [
            'Executing processes that are larger than total physical RAM size',
            'Doubling CPU clock speed',
            'Deleting viruses',
            'Eliminating code'
          ],
          correctOptionIndex: 0,
          explanation: 'Virtual Memory allows programs larger than physical RAM to run by swapping unneeded pages to disk.',
        )
      ],
      visualizerType: 'page_replacement_lru',
    ),

    const TopicModel(
      id: 'vm_2',
      categoryId: 'cat_vmemory',
      title: 'Demand Paging',
      shortIntro: 'Loading pages into memory only when they are referenced during execution.',
      definition: 'Demand Paging combines paging with lazy swapper: pages are loaded into RAM only upon access attempt.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Saves RAM and speeds up program startup by avoiding loading unused code routines into memory.',
      analogy: 'Demand Paging is like video streaming (Netflix)—only downloading video chunks as you watch rather than downloading the entire movie before playing.',
      importantPoints: [
        'Uses Valid/Invalid bit in Page Table.',
        'Valid (V): Page is present in RAM.',
        'Invalid (I): Page is not in RAM (triggers Page Fault).'
      ],
      realWorldApplications: ['Lazy code segment loading in OS binary execution (`execve`).'],
      examEssentials: ['Valid/Invalid Bit indicates presence in RAM.', 'Lazy swapper loads pages on demand.'],
      commonMistakes: ['Thinking all pages of a process must be in RAM before execution begins.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_vm_2',
          question: 'What does an Invalid (I) bit in a Page Table entry signify during Demand Paging?',
          options: ['Page is corrupted', 'Page is currently not loaded in physical RAM', 'Page is read-only', 'Page is deleted'],
          correctOptionIndex: 1,
          explanation: 'An Invalid bit indicates the requested page is not currently present in physical RAM (on secondary storage).',
        )
      ],
      visualizerType: 'page_replacement_lru',
    ),

    const TopicModel(
      id: 'vm_3',
      categoryId: 'cat_vmemory',
      title: 'Page Fault',
      shortIntro: 'Hardware trap triggered when a referenced page is not present in RAM.',
      definition: 'A Page Fault occurs when a process attempts to access a memory page marked invalid (not loaded in physical frame).',
      conceptExplanation: 'Page Fault Service Routine: 1. Trap to OS, 2. Save registers, 3. Check page validity, 4. Locate page on disk, 5. Read page into free frame, 6. Update page table bit to Valid, 7. Restart instruction.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Triggers the OS kernel to fetch missing memory pages from secondary storage transparently.',
      analogy: 'A Page Fault is like reaching into a drawer for a tool, finding it missing, and stepping to the storage garage to fetch it.',
      realWorldApplications: ['OS kernel page fault handlers.'],
      examEssentials: ['Step 7: Restart the instruction that caused the page fault!'],
      commonMistakes: ['Terminating the process on a Page Fault. Page Fault is a normal routine event, NOT an error crash!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_vm_3',
          question: 'What action does the OS take after completing the Page Fault service routine?',
          options: ['Terminates the program', 'Restarts the exact instruction that caused the page fault', 'Reboots computer', 'Clears RAM'],
          correctOptionIndex: 1,
          explanation: 'Once the missing page is loaded into RAM, the OS restarts the instruction so execution resumes seamlessly.',
        )
      ],
      visualizerType: 'page_replacement_lru',
    ),

    const TopicModel(
      id: 'vm_4',
      categoryId: 'cat_vmemory',
      title: 'Page Replacement Algorithms',
      shortIntro: 'Selecting a victim frame in RAM to replace when physical memory is full.',
      definition: 'Page Replacement algorithms select which memory page to swap out to disk when a new page fault occurs and no free frames exist.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'When RAM is full, replacing the right page minimizes future page fault overhead.',
      analogy: 'Page Replacement is like deciding which book to return to the library when your bookshelf at home is full.',
      realWorldApplications: ['Kernel page eviction algorithms.'],
      examEssentials: ['Goal: Lowest Page Fault Rate.'],
      commonMistakes: ['Replacing modified (dirty) pages without writing back changes to disk first.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_vm_4',
          question: 'What is the primary objective of a Page Replacement algorithm?',
          options: ['To minimize total Page Fault rate', 'To clear CPU cache', 'To maximize disk usage', 'To encrypt RAM'],
          correctOptionIndex: 0,
          explanation: 'The primary goal is achieving the lowest possible page fault rate on memory reference strings.',
        )
      ],
      visualizerType: 'page_replacement_lru',
    ),

    const TopicModel(
      id: 'vm_5',
      categoryId: 'cat_vmemory',
      title: 'FIFO Page Replacement',
      shortIntro: 'Replaces the oldest page loaded in physical memory.',
      definition: 'First-In, First-Out (FIFO) page replacement swaps out the page that was loaded into memory earliest.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Simple queue-based page replacement scheme with low overhead.',
      analogy: 'FIFO replacement is like replacing the oldest item in your refrigerator first.',
      isAlgorithmTopic: true,
      importantPoints: [
        'Suffers from Belady\'s Anomaly: Increasing frame count can increase total page faults.'
      ],
      workedExample: WorkedExampleModel(
        title: 'FIFO Page Replacement Trace (3 Frames)',
        problemStatement: 'Reference string: 7, 0, 1, 2, 0, 3. Frames = 3.',
        inputs: ['Ref String: 7, 0, 1, 2, 0, 3', 'Frames = 3'],
        stepByStepCalculations: [
          'Page 7: [7, -, -] (Fault 1)',
          'Page 0: [7, 0, -] (Fault 2)',
          'Page 1: [7, 0, 1] (Fault 3)',
          'Page 2: [2, 0, 1] (Fault 4, replaces oldest 7)',
          'Page 0: [2, 0, 1] (HIT! 0 present)',
          'Page 3: [2, 3, 1] (Fault 5, replaces oldest 0)'
        ],
        finalResults: ['Total Page Faults = 5', 'Total Page Hits = 1'],
        explanation: 'FIFO replaces the page that arrived earliest in RAM regardless of recent access frequency.',
      ),
      realWorldApplications: ['Simple buffer replacement implementations.'],
      examEssentials: ['FIFO suffers from Belady\'s Anomaly.', 'Queue structure.'],
      commonMistakes: ['Assuming increasing frame count ALWAYS reduces page faults in FIFO (Belady\'s Anomaly disproves this!).'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_vm_5',
          question: 'What counter-intuitive anomaly can occur in FIFO Page Replacement when allocating MORE physical frames?',
          options: ['Belady\'s Anomaly (Page faults increase)', 'Convoy Effect', 'Starvation', 'Deadlock'],
          correctOptionIndex: 0,
          explanation: 'Belady\'s Anomaly occurs in FIFO where increasing available frames results in MORE page faults.',
        )
      ],
      visualizerType: 'page_replacement_fifo',
    ),

    const TopicModel(
      id: 'vm_6',
      categoryId: 'cat_vmemory',
      title: 'LRU Page Replacement',
      shortIntro: 'Replaces the page that has not been used for the longest period of time.',
      definition: 'Least Recently Used (LRU) associates with each page the time of its last reference, selecting the page unused longest.',
      difficulty: 'Intermediate',
      readingTime: '5 min read',
      whyWeNeedIt: 'Approximates optimal replacement using past access history (locality of reference). Does NOT suffer from Belady\'s Anomaly.',
      analogy: 'LRU replacement is like throwing away the clothes in your closet that you haven\'t worn for the longest period.',
      isAlgorithmTopic: true,
      timeComplexity: 'Stack/Counter implementation: O(1)',
      workedExample: WorkedExampleModel(
        title: 'LRU Page Replacement Trace (3 Frames)',
        problemStatement: 'Reference string: 7, 0, 1, 2, 0, 3. Frames = 3.',
        inputs: ['Ref String: 7, 0, 1, 2, 0, 3', 'Frames = 3'],
        stepByStepCalculations: [
          'Page 7, 0, 1: Frames = [7, 0, 1] (3 Faults)',
          'Page 2: [2, 0, 1] (Fault 4, replaces 7 unused longest)',
          'Page 0: [2, 0, 1] (HIT! Page 0 updated as most recent)',
          'Page 3: [2, 0, 3] (Fault 5, replaces 1 unused longest)'
        ],
        finalResults: ['Total Page Faults = 5', 'Total Page Hits = 1'],
        explanation: 'LRU tracks past access timestamps to evict the page unused for longest duration.',
      ),
      realWorldApplications: ['Linux page cache replacement algorithms.'],
      examEssentials: ['LRU belongs to Stack Algorithms class.', 'Does NOT suffer from Belady\'s Anomaly.'],
      commonMistakes: ['Confusing Least Recently Used (LRU) with Least Frequently Used (LFU count).'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_vm_6',
          question: 'Does LRU Page Replacement suffer from Belady\'s Anomaly?',
          options: ['No, LRU is a stack algorithm and never exhibits Belady\'s Anomaly', 'Yes, always', 'Only with 2 frames', 'Depends on CPU clock'],
          correctOptionIndex: 0,
          explanation: 'LRU belongs to the class of stack algorithms which are mathematically proven never to exhibit Belady\'s Anomaly.',
        )
      ],
      visualizerType: 'page_replacement_lru',
    ),

    const TopicModel(
      id: 'vm_7',
      categoryId: 'cat_vmemory',
      title: 'Optimal Page Replacement (OPT)',
      shortIntro: 'Replaces the page that will not be used for longest time in future.',
      definition: 'Optimal (OPT or MIN) replaces the page that will not be used for longest future duration. Serves as theoretical benchmark.',
      difficulty: 'Advanced',
      readingTime: '4 min read',
      whyWeNeedIt: 'Provides the theoretical absolute minimum page fault count benchmark to evaluate all practical page replacement algorithms.',
      analogy: 'Optimal replacement is like having a crystal ball to see the future and throwing away the item you won\'t need for the longest time.',
      isAlgorithmTopic: true,
      workedExample: WorkedExampleModel(
        title: 'Optimal (OPT) Page Replacement Trace (3 Frames)',
        problemStatement: 'Reference string: 7, 0, 1, 2, 0, 3. Frames = 3.',
        inputs: ['Ref String: 7, 0, 1, 2, 0, 3', 'Frames = 3'],
        stepByStepCalculations: [
          'Page 7, 0, 1: [7, 0, 1] (3 Faults)',
          'Page 2: Future references: 0 is used next, 1 is not used. Replaces 7!',
          'Frames: [2, 0, 1] (Fault 4)',
          'Page 0: [2, 0, 1] (HIT!)',
          'Page 3: Future references: 2 and 0. 1 is never used. Replaces 1!',
          'Frames: [2, 0, 3] (Fault 5)'
        ],
        finalResults: ['Minimum Page Faults = 5'],
        explanation: 'OPT uses future knowledge to guarantee lowest possible page fault count.',
      ),
      realWorldApplications: ['Theoretical performance benchmarking.'],
      examEssentials: ['Requires future knowledge.', 'Lowest theoretical page fault rate.'],
      commonMistakes: ['Attempting to implement true OPT in real-time operating systems without future reference knowledge.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_vm_7',
          question: 'Why cannot Optimal (OPT) Page Replacement be implemented in general-purpose real-time operating systems?',
          options: [
            'It requires knowing future page reference strings in advance',
            'It uses too much electricity',
            'It requires 64 cores',
            'It crashes hard drives'
          ],
          correctOptionIndex: 0,
          explanation: 'OPT requires future knowledge of memory references, which is impossible to predict in general computing workloads.',
        )
      ],
      visualizerType: 'page_replacement_opt',
    ),

    const TopicModel(
      id: 'vm_8',
      categoryId: 'cat_vmemory',
      title: 'Thrashing',
      shortIntro: 'High paging activity where system spends more time swapping pages than executing.',
      definition: 'Thrashing occurs when a process lacks sufficient frames, leading to continuous page faults and severe CPU utilization drop.',
      conceptExplanation: 'When total working set size exceeds physical RAM, page fault rate spikes to 100%. CPU utilization plunges toward zero because CPU is perpetually waiting for disk swap I/O.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Understanding thrashing allows OS designers to implement Working-Set models and local allocation to keep systems responsive.',
      analogy: 'Thrashing is like spending 59 minutes searching for papers on a cluttered desk and 1 minute actually writing.',
      realWorldApplications: ['System freeze when opening too many heavy apps simultaneously on low RAM devices.'],
      examEssentials: ['Thrashing cause: Process allocated fewer frames than its active Working Set.', 'CPU utilization drops near 0%.'],
      commonMistakes: ['Increasing CPU scheduling degree of multiprogramming when thrashing occurs. That makes thrashing WORSE!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_vm_8',
          question: 'What happens to CPU utilization when system Thrashing occurs?',
          options: ['Plunges drastically toward zero', 'Spikes to 100%', 'Doubles', 'Stays constant'],
          correctOptionIndex: 0,
          explanation: 'During thrashing, CPU utilization drops near zero because CPU spends all its time waiting for disk swap page transfers.',
        )
      ],
      visualizerType: 'page_replacement_lru',
    ),

    // ==========================================
    // CATEGORY 8: FILE SYSTEM
    // ==========================================
    const TopicModel(
      id: 'file_1',
      categoryId: 'cat_file',
      title: 'File Concepts',
      shortIntro: 'Logical storage unit abstracted by OS to record persistent information.',
      definition: 'A File is a named collection of related information stored on secondary storage.',
      difficulty: 'Beginner',
      readingTime: '3 min read',
      whyWeNeedIt: 'Provides uniform logical storage abstraction over physical magnetic sectors or flash storage blocks.',
      analogy: 'A File is like a labeled paper folder stored in a filing cabinet.',
      realWorldApplications: ['Text files, executables, multimedia files.'],
      examEssentials: ['File: Logical unit of persistent storage.'],
      commonMistakes: ['Thinking file structure depends on secondary hardware drive type.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_file_1',
          question: 'What entity abstracts physical disk storage sectors into named logical data units?',
          options: ['File System', 'Power Supply', 'RAM Bus', 'CPU Clock'],
          correctOptionIndex: 0,
          explanation: 'The File System abstracts physical storage into logical named files.',
        )
      ],
      visualizerType: 'file_allocation',
    ),

    const TopicModel(
      id: 'file_2',
      categoryId: 'cat_file',
      title: 'File Attributes',
      shortIntro: 'Properties associated with files (Name, Identifier, Type, Size, Protection, Time).',
      definition: 'File metadata stored in directory entries keeping track of file properties.',
      difficulty: 'Beginner',
      readingTime: '3 min read',
      whyWeNeedIt: 'Metadata is necessary to track permissions, file sizes, creation timestamps, and owner security.',
      analogy: 'File attributes are like the passport details of a citizen (Name, DOB, ID number, permissions).',
      importantPoints: ['Attributes: Name, Type, Location, Size, Protection, Timestamps.'],
      realWorldApplications: ['Linux `ls -l` metadata output.'],
      examEssentials: ['Metadata stored in directory structure or Inodes.'],
      commonMistakes: ['Thinking file attributes are stored inside the user data content of the file.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_file_2',
          question: 'Where is file metadata (attributes like size, permissions, and timestamps) maintained?',
          options: ['Directory entries / Inode structures', 'Inside CPU cache', 'In RAM BIOS', 'In graphics card'],
          correctOptionIndex: 0,
          explanation: 'File metadata is stored in directory entries or Linux Inode structures.',
        )
      ],
      visualizerType: 'file_allocation',
    ),

    const TopicModel(
      id: 'file_3',
      categoryId: 'cat_file',
      title: 'File Operations',
      shortIntro: 'System calls for creating, writing, reading, seeking, deleting files.',
      definition: 'Basic operations provided by OS file system interface.',
      difficulty: 'Beginner',
      readingTime: '3 min read',
      whyWeNeedIt: 'Standard APIs allowing applications to read/write persistent storage.',
      analogy: 'Operations are like actions on a physical notebook: Open, Read, Write, Erase, Close.',
      realWorldApplications: ['POSIX `open()`, `read()`, `write()`, `lseek()`, `unlink()`.'],
      examEssentials: ['System calls: Create, Open, Read, Write, Seek, Delete.'],
      commonMistakes: ['Forgetting to close open file descriptors, leading to system file handle leaks.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_file_3',
          question: 'Which system call changes the current read/write file offset pointer within an open file?',
          options: ['seek() / lseek()', 'create()', 'delete()', 'fork()'],
          correctOptionIndex: 0,
          explanation: '`seek()` / `lseek()` adjusts the file position pointer for subsequent read/write operations.',
        )
      ],
      visualizerType: 'file_allocation',
    ),

    const TopicModel(
      id: 'file_4',
      categoryId: 'cat_file',
      title: 'Directory Structure',
      shortIntro: 'Single-level, Two-level, Tree-structured, and Acyclic-graph directories.',
      definition: 'Organizing directory nodes to map user path names to file descriptors.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Hierarchical organization allowing users to group related files logically in folders.',
      analogy: 'A directory structure is like a tree with subfolders acting as branches and files acting as leaves.',
      comparisonTable: ComparisonTableModel(
        title: 'Directory Hierarchy Types',
        headers: ['Directory Type', 'Structure', 'Name Collisions', 'Sharing'],
        rows: [
          ['Single-Level', 'All files in 1 flat list', 'High collision risk', 'No isolation'],
          ['Two-Level', 'Separate master directory per user', 'No collision between users', 'Limited sharing'],
          ['Tree-Structured', 'Hierarchical directories/subdirectories', 'Isolated subfolders', 'Path navigation'],
          ['Acyclic Graph', 'Directories with shared subfiles/links', 'Requires link tracking', 'Shared files (Hard/Soft links)']
        ],
      ),
      realWorldApplications: ['Linux Filesystem Hierarchy Standard (FHS: `/`, `/home`, `/bin`, `/etc`).'],
      examEssentials: ['Tree-Structured is standard in modern OS.', 'Acyclic graph supports file links.'],
      commonMistakes: ['Confusing Hard Links (direct inode references) with Symbolic Soft Links (path string pointers).'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_file_4',
          question: 'Which directory structure allows files and subdirectories to be shared across multiple paths via links without cycles?',
          options: ['Single-Level Directory', 'Acyclic-Graph Directory', 'Flat Directory', 'Binary Directory'],
          correctOptionIndex: 1,
          explanation: 'An Acyclic-Graph directory allows shared links while preventing circular directory reference loops.',
        )
      ],
      visualizerType: 'file_allocation',
    ),

    const TopicModel(
      id: 'file_5',
      categoryId: 'cat_file',
      title: 'File Allocation Methods',
      shortIntro: 'How disk blocks are allocated to store file data.',
      definition: 'Strategies used by file systems to map files to disk sectors.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Determines disk access performance, storage efficiency, and file fragmentation.',
      analogy: 'Allocation methods are strategies for placing multi-page documents in library binders.',
      realWorldApplications: ['FAT32, ext4, NTFS disk allocation schemes.'],
      examEssentials: ['3 Core Methods: Contiguous, Linked, Indexed.'],
      commonMistakes: ['Assuming all file systems use the exact same allocation scheme.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_file_5',
          question: 'What are the three primary file allocation methods used by operating systems?',
          options: [
            'Contiguous, Linked, and Indexed Allocation',
            'Paging, Segmentation, and Swap',
            'FCFS, SJF, and Round Robin',
            'FIFO, LRU, and Optimal'
          ],
          correctOptionIndex: 0,
          explanation: 'The 3 primary allocation methods are Contiguous, Linked, and Indexed allocation.',
        )
      ],
      visualizerType: 'file_allocation',
    ),

    const TopicModel(
      id: 'file_6',
      categoryId: 'cat_file',
      title: 'Contiguous Allocation',
      shortIntro: 'Each file occupies a set of contiguous disk sectors.',
      definition: 'Requires file to be saved in consecutive disk blocks. Fast sequential access, but suffers from external disk fragmentation.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Provides fastest disk read performance because disk head reads consecutive blocks without seeking.',
      analogy: 'Contiguous allocation is like reserving 10 adjacent seats together in a theater row.',
      advantages: ['Fastest sequential and random disk access.'],
      disadvantages: ['External disk fragmentation; difficult to grow file size dynamically.'],
      realWorldApplications: ['CD-ROMs, ISO image files, optical media.'],
      examEssentials: ['Fastest read speed.', 'Directory entry stores: `Start Block` and `Length`.'],
      commonMistakes: ['Trying to expand a contiguous file when adjacent disk blocks are already occupied.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_file_6',
          question: 'What information does a directory entry store for Contiguous Allocation?',
          options: ['Start Block Address and Length (count of blocks)', 'Index block pointer', 'Paging table', 'Mode bit'],
          correctOptionIndex: 0,
          explanation: 'Contiguous allocation requires only the starting sector address and total block count length.',
        )
      ],
      visualizerType: 'file_allocation',
    ),

    const TopicModel(
      id: 'file_7',
      categoryId: 'cat_file',
      title: 'Linked Allocation',
      shortIntro: 'Each file is a linked list of non-contiguous disk blocks.',
      definition: 'Disk blocks contain pointers to next block. Eliminates fragmentation, but random access is slow.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Completely eliminates external disk fragmentation and allows dynamic file growth.',
      analogy: 'Linked allocation is like a treasure hunt clue game—each clue tells you which location to visit next.',
      advantages: ['No external fragmentation.', 'Files grow easily by appending blocks.'],
      disadvantages: ['Random access is very slow (must traverse pointers).', 'Pointer storage overhead.'],
      realWorldApplications: ['MS-DOS FAT (File Allocation Table) file system.'],
      examEssentials: ['Directory stores: `Start Block` and `End Block`.', 'Random access is O(N) traversal.'],
      commonMistakes: ['Expecting fast random access in Linked Allocation. Random access requires traversing N pointers!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_file_7',
          question: 'Why is direct random access to Block 50 slow in Linked File Allocation?',
          options: [
            'The disk head must read blocks 1 through 49 sequentially to follow block pointers',
            'RAM is disabled',
            'Disk head stops spinning',
            'Paging blocks it'
          ],
          correctOptionIndex: 0,
          explanation: 'Linked allocation stores pointer to block N+1 inside block N, forcing sequential pointer traversal.',
        )
      ],
      visualizerType: 'file_allocation',
    ),

    const TopicModel(
      id: 'file_8',
      categoryId: 'cat_file',
      title: 'Indexed Allocation (inodes)',
      shortIntro: 'Brings all block pointers together into an Index Block (inode).',
      definition: 'Each file has an index block listing direct and indirect disk block addresses. Used in UNIX/Linux ext file systems.',
      difficulty: 'Advanced',
      readingTime: '5 min read',
      whyWeNeedIt: 'Supports fast direct random access AND dynamic file growth without external fragmentation.',
      analogy: 'Indexed allocation is like a table of contents in a textbook that lists exact page numbers for every section.',
      realWorldApplications: ['UNIX/Linux ext2/ext3/ext4 `inode` indexing structures.'],
      examEssentials: ['Inode contains direct pointers, single indirect pointers, double indirect pointers.', 'Fast random access.'],
      commonMistakes: ['Confusing Inode block index pointers with contiguous block offsets.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_file_8',
          question: 'Which file allocation strategy is used by Linux ext4 file system inodes?',
          options: ['Indexed Allocation', 'Contiguous Allocation', 'Pure Linked Allocation', 'Static Tape Allocation'],
          correctOptionIndex: 0,
          explanation: 'Linux ext file systems use Indexed Allocation via Inode structures.',
        )
      ],
      visualizerType: 'file_allocation',
    ),

    const TopicModel(
      id: 'file_9',
      categoryId: 'cat_file',
      title: 'Free Space Management',
      shortIntro: 'Tracking unused disk blocks using Bit Vector, Linked List, or Grouping.',
      definition: 'OS maintains free space list to quickly locate empty blocks for new file allocation.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Quickly locates available empty storage blocks when writing new file data.',
      analogy: 'Free space management is like an electronic parking display showing green lights above empty parking spaces.',
      importantPoints: [
        'Bit Vector (Bitmap): 1 bit per block (0 = Allocated, 1 = Free).',
        'Linked Free List: Pointer chain of free disk blocks.'
      ],
      realWorldApplications: ['Disk bitmap structures in modern file systems.'],
      examEssentials: ['Bit Vector is fast, requires bitwise CPU hardware support.'],
      commonMistakes: ['Assuming free space lists are stored in main RAM when powered off. They persist on disk!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_file_9',
          question: 'What data structure represents each disk block with 1 bit (0 for allocated, 1 for free)?',
          options: ['Bit Vector / Bitmap', 'Inode Table', 'Page Table', 'Gantt Chart'],
          correctOptionIndex: 0,
          explanation: 'A Bit Vector (or Bitmap) represents each disk block using a single 0/1 binary bit.',
        )
      ],
      visualizerType: 'file_allocation',
    ),

    // ==========================================
    // CATEGORY 9: DISK SCHEDULING
    // ==========================================
    const TopicModel(
      id: 'disk_1',
      categoryId: 'cat_disk',
      title: 'Disk Structure',
      shortIntro: 'Physical structure of magnetic disk drives (Platters, Tracks, Sectors, Cylinders).',
      definition: 'Disk drives consist of spinning platters coated with magnetic material, read by movable R/W arm heads.',
      difficulty: 'Beginner',
      readingTime: '3 min read',
      whyWeNeedIt: 'Understanding physical disk geometry is necessary to optimize I/O head seek times.',
      analogy: 'A magnetic hard disk is like a stack of spinning vinyl records with read needles moving back and forth.',
      importantPoints: [
        'Platters spin at high RPM (e.g. 7200 RPM).',
        'Cylinder: Same track position across all platters.'
      ],
      realWorldApplications: ['HDD mechanical drive architecture.'],
      examEssentials: ['Components: Platters, Read/Write Heads, Tracks, Sectors, Cylinders.'],
      commonMistakes: ['Confusing Sector (wedge on track) with Track (concentric ring).'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_disk_1',
          question: 'What is the set of all matching tracks across all platters in a disk drive called?',
          options: ['Cylinder', 'Sector', 'Header', 'Cluster'],
          correctOptionIndex: 0,
          explanation: 'A Cylinder consists of the set of tracks at identical arm positions across all spinning platters.',
        )
      ],
      visualizerType: 'disk_scheduling',
    ),

    const TopicModel(
      id: 'disk_2',
      categoryId: 'cat_disk',
      title: 'Disk Scheduling Introduction',
      shortIntro: 'Minimizing Disk Seek Time and Head Movement for I/O requests.',
      definition: 'Disk Scheduling algorithms order I/O read/write requests to minimize total head movement time.',
      conceptExplanation: 'Total Disk Access Time = Seek Time + Rotational Latency + Transfer Time. Seek Time (moving arm to cylinder) is the largest latency component.',
      difficulty: 'Beginner',
      readingTime: '4 min read',
      whyWeNeedIt: 'Mechanical disk arm head movement (Seek Time) is slow (~milliseconds). Scheduling reduces total head travel distance.',
      analogy: 'Disk scheduling is like an elevator picking up passengers on floors in an optimal sequence to save motor travel.',
      formula: 'Seek Time: Time taken to move disk head to target cylinder.',
      realWorldApplications: ['HDD I/O request queues in Linux kernel (`bfq`, `mq-deadline`).'],
      examEssentials: ['Seek Time dominates total disk I/O latency.', 'Goal: Minimize Total Head Seek Distance.'],
      commonMistakes: ['Confusing Seek Time (arm movement) with Rotational Latency (platter spin wait).'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_disk_2',
          question: 'Which component accounts for the largest delay during mechanical HDD data access?',
          options: ['Seek Time (Arm movement)', 'Cable delay', 'RAM lookup', 'CPU clock cycle'],
          correctOptionIndex: 0,
          explanation: 'Seek Time (moving physical disk head to target cylinder) is the slowest mechanical latency component.',
        )
      ],
      visualizerType: 'disk_scheduling',
    ),

    const TopicModel(
      id: 'disk_3',
      categoryId: 'cat_disk',
      title: 'FCFS Disk Scheduling',
      shortIntro: 'Services disk requests in arrival order.',
      definition: 'First-Come First-Served disk scheduling moves head sequentially according to request queue.',
      difficulty: 'Beginner',
      readingTime: '3 min read',
      whyWeNeedIt: 'Simplest disk scheduling policy, fair with zero overhead, but causes wild head swinging.',
      analogy: 'FCFS disk scheduling is like a delivery driver visiting addresses strictly by order time, driving back and forth across town.',
      isAlgorithmTopic: true,
      workedExample: WorkedExampleModel(
        title: 'FCFS Disk Head Travel',
        problemStatement: 'Initial head at 50. Queue: 98, 183, 37, 122, 14.',
        inputs: ['Head = 50', 'Queue: 98, 183, 37, 122, 14'],
        stepByStepCalculations: [
          '50 ➔ 98: |98-50| = 48',
          '98 ➔ 183: |183-98| = 85',
          '183 ➔ 37: |37-183| = 146',
          '37 ➔ 122: |122-37| = 85',
          '122 ➔ 14: |14-122| = 108',
          'Total = 48 + 85 + 146 + 85 + 108 = 472 cylinders'
        ],
        finalResults: ['Total Head Movement = 472 Cylinders'],
        explanation: 'FCFS results in large head travel (472 cylinders) due to wild direction swings.',
      ),
      realWorldApplications: ['Basic FIFO disk queues.'],
      examEssentials: ['FCFS moves head strictly in arrival order.'],
      commonMistakes: ['Sorting FCFS requests by track number. FCFS NEVER sorts!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_disk_3',
          question: 'How does FCFS Disk Scheduling order incoming I/O requests?',
          options: ['Strictly by arrival order in request queue', 'By closest track number', 'By smallest file size', 'By process priority'],
          correctOptionIndex: 0,
          explanation: 'FCFS services requests strictly in the order they arrive in the queue.',
        )
      ],
      visualizerType: 'disk_scheduling',
    ),

    const TopicModel(
      id: 'disk_4',
      categoryId: 'cat_disk',
      title: 'SSTF (Shortest Seek Time First)',
      shortIntro: 'Selects the request with minimum seek distance from current head position.',
      definition: 'Shortest Seek Time First (SSTF) services the disk request closest to current cylinder head position.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Significantly reduces total head seek distance compared to FCFS.',
      analogy: 'SSTF is like a shopping assistant picking items from store shelves closest to current location.',
      isAlgorithmTopic: true,
      advantages: ['Drastically reduces total seek distance.'],
      disadvantages: ['Can cause starvation for requests located far from current head position.'],
      workedExample: WorkedExampleModel(
        title: 'SSTF Disk Head Travel',
        problemStatement: 'Initial head at 50. Queue: 98, 183, 37, 122, 14, 65, 67.',
        inputs: ['Head = 50', 'Queue: 98, 183, 37, 122, 14, 65, 67'],
        stepByStepCalculations: [
          'From 50, closest is 37 (|37-50|=13)',
          'From 37, closest is 14 (|14-37|=23)',
          'From 14, closest is 65 (|65-14|=51)',
          'From 65 ➔ 67 ➔ 98 ➔ 122 ➔ 183'
        ],
        finalResults: ['Total Head Movement = 236 Cylinders'],
        explanation: 'SSTF cut total head travel down to 236 cylinders (vs 640+ in FCFS).',
      ),
      realWorldApplications: ['Greedy disk head optimization algorithms.'],
      examEssentials: ['SSTF selects minimum |request - current_head|.', 'Can cause starvation.'],
      commonMistakes: ['Overlooking a closer request when evaluating minimum seek distances.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_disk_4',
          question: 'What major drawback can occur in SSTF Disk Scheduling?',
          options: ['Starvation of distant track requests', 'Belady Anomaly', 'Thrashing', 'Memory leak'],
          correctOptionIndex: 0,
          explanation: 'SSTF can cause starvation for requests located far from current head position if closer requests keep arriving.',
        )
      ],
      visualizerType: 'disk_scheduling',
    ),

    const TopicModel(
      id: 'disk_5',
      categoryId: 'cat_disk',
      title: 'SCAN (Elevator Algorithm)',
      shortIntro: 'Disk head moves from one end of disk to other, servicing requests along way.',
      definition: 'SCAN moves disk arm toward one end of disk, servicing requests until reaching end cylinder, then reverses direction.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Eliminates starvation completely while keeping total seek distance low.',
      analogy: 'SCAN works like a building elevator going all the way to the top floor, stopping for passengers along the way, then reversing down.',
      isAlgorithmTopic: true,
      realWorldApplications: ['Elevator disk scheduling algorithms.'],
      examEssentials: ['SCAN goes ALL THE WAY to disk boundary (e.g. 0 or 199) before reversing.'],
      commonMistakes: ['Stopping at the last request instead of going to the physical end boundary in SCAN. (Going to end boundary = SCAN; stopping at last request = LOOK).'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_disk_5',
          question: 'How far does the disk arm travel in SCAN before reversing direction?',
          options: ['All the way to the physical end boundary of the disk', 'Only to the last request', 'Halfway', '10 cylinders'],
          correctOptionIndex: 0,
          explanation: 'SCAN travels all the way to the physical boundary cylinder of the disk before reversing direction.',
        )
      ],
      visualizerType: 'disk_scheduling',
    ),

    const TopicModel(
      id: 'disk_6',
      categoryId: 'cat_disk',
      title: 'C-SCAN (Circular SCAN)',
      shortIntro: 'Moves head in one direction servicing requests, then resets to start without servicing.',
      definition: 'Circular SCAN provides uniform wait time by servicing requests in 1 direction only, jumping back to cylinder 0 without servicing on return.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Provides uniform wait time distribution for all tracks across the disk surface.',
      analogy: 'C-SCAN is like a typewriter carriage returning to the left margin without printing during the return swing.',
      isAlgorithmTopic: true,
      realWorldApplications: ['Disk schedulers seeking uniform response time.'],
      examEssentials: ['Services requests in ONE direction only.', 'Jumps back to start without servicing on return.'],
      commonMistakes: ['Servicing requests during the return jump in C-SCAN. C-SCAN DOES NOT service requests on return!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_disk_6',
          question: 'Does C-SCAN service disk requests during its return jump back to cylinder 0?',
          options: ['No, return jump is un-serviced to ensure uniform wait time', 'Yes, always', 'Only even tracks', 'Depends on file size'],
          correctOptionIndex: 0,
          explanation: 'C-SCAN resets head to start without servicing requests on return, providing uniform wait times.',
        )
      ],
      visualizerType: 'disk_scheduling',
    ),

    const TopicModel(
      id: 'disk_7',
      categoryId: 'cat_disk',
      title: 'LOOK Scheduling',
      shortIntro: 'Variant of SCAN that reverses direction at last request rather than disk boundary.',
      definition: 'LOOK algorithm checks for requests in current direction before continuing to end of disk.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Saves unnecessary head travel by reversing immediately at the last request instead of walking to the physical edge of disk.',
      analogy: 'LOOK is like an elevator driver who looks ahead—if no passengers are waiting on upper floors, turns around immediately.',
      isAlgorithmTopic: true,
      realWorldApplications: ['Standard elevator algorithm optimizations in OS kernels.'],
      examEssentials: ['Reverses at last request in current direction.', 'Does NOT travel to physical disk boundary.'],
      commonMistakes: ['Confusing LOOK (reverses at last request) with SCAN (reverses at disk boundary).'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_disk_7',
          question: 'What is the main difference between LOOK and SCAN disk scheduling?',
          options: [
            'LOOK reverses at the last request in current direction instead of going to physical disk boundary',
            'LOOK is slower',
            'LOOK uses no head',
            'LOOK is non-preemptive'
          ],
          correctOptionIndex: 0,
          explanation: 'LOOK checks ahead and reverses at the last request, avoiding unnecessary travel to physical disk boundaries.',
        )
      ],
      visualizerType: 'disk_scheduling',
    ),

    const TopicModel(
      id: 'disk_8',
      categoryId: 'cat_disk',
      title: 'C-LOOK Scheduling',
      shortIntro: 'Variant of C-SCAN that jumps back from highest request to lowest request cylinder.',
      definition: 'C-LOOK moves head in 1 direction up to last request, then jumps directly to lowest cylinder request.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Optimized variant of C-SCAN avoiding unnecessary travel to boundary cylinder 0 or max boundary.',
      analogy: 'C-LOOK is like a shuttle bus driving from lowest active stop to highest active stop, then jumping straight back to lowest stop.',
      isAlgorithmTopic: true,
      realWorldApplications: ['Linux elevator default disk schedulers.'],
      examEssentials: ['1 direction service.', 'Jumps from highest request to lowest request cylinder.'],
      commonMistakes: ['Jumping to cylinder 0 in C-LOOK. C-LOOK jumps to the LOWEST REQUEST cylinder!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_disk_8',
          question: 'Where does C-LOOK jump back to after servicing the highest request cylinder?',
          options: ['To the lowest requested cylinder in the queue', 'To physical cylinder 0', 'To middle track', 'To end track'],
          correctOptionIndex: 0,
          explanation: 'C-LOOK jumps directly to the lowest requested cylinder in queue rather than physical cylinder 0.',
        )
      ],
      visualizerType: 'disk_scheduling',
    ),

    // ==========================================
    // CATEGORY 10: I/O MANAGEMENT
    // ==========================================
    const TopicModel(
      id: 'io_1',
      categoryId: 'cat_io',
      title: 'I/O Hardware',
      shortIntro: 'Storage, Communication, and User Interface I/O devices.',
      definition: 'I/O Hardware includes ports, buses, and device controllers that connect physical peripheral devices to main memory.',
      difficulty: 'Beginner',
      readingTime: '3 min read',
      whyWeNeedIt: 'Connects computer system to external physical world (keyboards, network cards, displays, storage).',
      analogy: 'I/O Hardware is like the senses and limbs of a human body (eyes, ears, hands).',
      realWorldApplications: ['PCIe buses, USB controllers, SATA ports.'],
      examEssentials: ['Components: Device Controllers, Ports, Buses, Registers.'],
      commonMistakes: ['Confusing physical device hardware with software device drivers.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_io_1',
          question: 'What hardware module interfaces physical peripheral devices to system buses?',
          options: ['Device Controller', 'Compiler', 'Page Table', 'Swap file'],
          correctOptionIndex: 0,
          explanation: 'Device Controllers are electronic components that operate peripheral devices and interface with CPU buses.',
        )
      ],
      visualizerType: 'io_dma_interrupt',
    ),

    const TopicModel(
      id: 'io_2',
      categoryId: 'cat_io',
      title: 'I/O System Calls',
      shortIntro: 'Standard system interfaces for device interaction (read, write, ioctl).',
      definition: 'Uniform user APIs for block, character, network, and clock I/O devices.',
      difficulty: 'Intermediate',
      readingTime: '3 min read',
      whyWeNeedIt: 'Abstracts diverse device hardware behind standard OS file APIs.',
      analogy: 'Standard steering wheel and gas pedal in any car model.',
      realWorldApplications: ['UNIX `read()`, `write()`, `ioctl()`.'],
      examEssentials: ['Device categories: Block devices (disks), Character devices (keyboards), Network sockets.'],
      commonMistakes: ['Assuming separate APIs are needed for file read vs device read in UNIX ("Everything is a file").'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_io_2',
          question: 'Which UNIX device category transfers data as a stream of individual bytes (e.g. keyboard, serial port)?',
          options: ['Character Devices', 'Block Devices', 'Page Devices', 'Buffer Devices'],
          correctOptionIndex: 0,
          explanation: 'Character Devices stream data byte-by-byte (keyboards, serial ports).',
        )
      ],
      visualizerType: 'io_dma_interrupt',
    ),

    const TopicModel(
      id: 'io_3',
      categoryId: 'cat_io',
      title: 'Device Controllers',
      shortIntro: 'Electronic components operating physical peripheral devices.',
      definition: 'Device controllers contain registers (Data-in, Data-out, Status, Control) bridging host CPU and device hardware.',
      difficulty: 'Intermediate',
      readingTime: '3 min read',
      whyWeNeedIt: 'Converts high-level bus commands into low-level electrical signals for motor drives and sensors.',
      analogy: 'Device controller is like an interpreter translating English commands into machine control signals.',
      importantPoints: ['Registers: Data-In, Data-Out, Status, Control.'],
      realWorldApplications: ['NVMe disk controllers, Wi-Fi network cards.'],
      examEssentials: ['Status Register: BUSY / READY bits.'],
      commonMistakes: ['Believing CPU directly drives physical disk motors without a device controller.'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_io_3',
          question: 'Which register in a device controller indicates whether the device is currently busy or ready for commands?',
          options: ['Status Register', 'Data-In Register', 'Program Counter', 'Stack Pointer'],
          correctOptionIndex: 0,
          explanation: 'The Status Register maintains state flags like BUSY or READY.',
        )
      ],
      visualizerType: 'io_dma_interrupt',
    ),

    const TopicModel(
      id: 'io_4',
      categoryId: 'cat_io',
      title: 'Interrupts',
      shortIntro: 'Hardware signals altering CPU instruction execution sequence.',
      definition: 'An Interrupt is a hardware signal sent by device controller to CPU pin triggering Interrupt Vector lookup.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'Eliminates CPU busy-waiting (polling) by notifying CPU instantly when an I/O event completes.',
      analogy: 'An Interrupt is like a doorbell ringing—you stop reading, answer the door, and return to your chair.',
      executionSteps: [
        StepItem(stepNumber: 1, title: 'Device Signal', description: 'Device controller asserts interrupt hardware line pin.'),
        StepItem(stepNumber: 2, title: 'CPU Trap', description: 'CPU finishes current instruction and saves state.'),
        StepItem(stepNumber: 3, title: 'Vector Lookup', description: 'CPU indexes Interrupt Vector Table for handler address.'),
        StepItem(stepNumber: 4, title: 'ISR Execution', description: 'Interrupt Service Routine executes.'),
        StepItem(stepNumber: 5, title: 'Resume', description: 'CPU restores state and resumes interrupted task.')
      ],
      realWorldApplications: ['Keyboard keypress interrupts, network packet arrival interrupts.'],
      examEssentials: ['IVT: Interrupt Vector Table.', 'ISR: Interrupt Service Routine.'],
      commonMistakes: ['Confusing hardware interrupts (device pins) with software traps (system calls).'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_io_4',
          question: 'What table does the CPU index when a hardware interrupt signal is received?',
          options: ['Interrupt Vector Table (IVT)', 'Page Table', 'Process Control Block', 'Gantt Table'],
          correctOptionIndex: 0,
          explanation: 'The CPU uses the Interrupt Vector Table (IVT) to locate the exact address of the Interrupt Service Routine (ISR).',
        )
      ],
      visualizerType: 'io_dma_interrupt',
    ),

    const TopicModel(
      id: 'io_5',
      categoryId: 'cat_io',
      title: 'Direct Memory Access (DMA)',
      shortIntro: 'High-speed data transfer directly between I/O device and RAM without CPU intervention.',
      definition: 'DMA controller takes over bus to transfer data blocks directly into main memory, raising interrupt only on block completion.',
      difficulty: 'Intermediate',
      readingTime: '4 min read',
      whyWeNeedIt: 'High-speed devices (disk, gigabit ethernet) transferring MBs of data would overwhelm CPU if transferred byte-by-byte via interrupts.',
      analogy: 'DMA is like hiring a moving company to transport your furniture into a new house while you work on your computer uninterrupted.',
      advantages: ['CPU freed from byte-by-byte transfer loop.', 'High data transfer throughput.'],
      disadvantages: ['Bus contention (Cycle Stealing) between DMA controller and CPU.'],
      realWorldApplications: ['NVMe SSD transfers, GPU memory transfers.'],
      examEssentials: ['DMA Controller takes bus mastership.', 'Interrupt raised ONLY on full block transfer completion.'],
      commonMistakes: ['Thinking CPU transfers every byte during a DMA transfer. DMA transfers directly to RAM!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_io_5',
          question: 'How often does a DMA transfer raise an interrupt to the CPU?',
          options: [
            'Only once per complete data block transfer',
            'Every single byte transferred',
            'Every microsecond',
            'Never'
          ],
          correctOptionIndex: 0,
          explanation: 'DMA transfers data blocks directly into RAM and raises a single interrupt when the entire block transfer completes.',
        )
      ],
      visualizerType: 'io_dma_interrupt',
    ),

    const TopicModel(
      id: 'io_6',
      categoryId: 'cat_io',
      title: 'Device Drivers',
      shortIntro: 'OS modules providing specific device control interfaces.',
      definition: 'Device drivers hide peripheral hardware specifics behind standard OS device interfaces.',
      difficulty: 'Intermediate',
      readingTime: '3 min read',
      whyWeNeedIt: 'Allows OS kernel to talk to thousands of different manufacturer hardware devices using standard uniform interfaces.',
      analogy: 'Device driver is like a specialized translator translating standard English commands into specific foreign dialects.',
      realWorldApplications: ['NVIDIA graphics drivers, USB Wi-Fi drivers in Windows/Linux.'],
      examEssentials: ['Bridges OS API and Hardware Device Controller.'],
      commonMistakes: ['Thinking device drivers are part of the physical hardware device. Drivers are software code!'],
      practiceQuestions: [
        ConceptQuestionModel(
          id: 'q_io_6',
          question: 'What is the role of a Device Driver software module in an Operating System?',
          options: [
            'Translates standard OS kernel I/O calls into device-specific hardware commands',
            'Increases monitor resolution',
            'Clears RAM cache',
            'Deletes viruses'
          ],
          correctOptionIndex: 0,
          explanation: 'Device Drivers translate general OS system requests into specific hardware controller commands.',
        )
      ],
      visualizerType: 'io_dma_interrupt',
    ),
  ];
}
