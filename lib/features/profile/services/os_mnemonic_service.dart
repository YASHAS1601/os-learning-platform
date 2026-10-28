class OsMnemonicService {
  /// Provides an intuitive conceptual hint to guide the student during a review quiz
  static String getHint({
    required String topicId,
    required String topicName,
    required String questionText,
    required String explanation,
  }) {
    final lowerTopic = '$topicId $topicName $questionText'.toLowerCase();

    if (lowerTopic.contains('dual mode') || lowerTopic.contains('user mode') || lowerTopic.contains('kernel mode')) {
      return "💡 Hint: Distinguish between the privileged Ring 0 (unrestricted hardware access) and unprivileged Ring 3 (where regular apps execute).";
    }
    if (lowerTopic.contains('system call') || lowerTopic.contains('syscall')) {
      return "💡 Hint: Think about what bridge a user application triggers (via a software interrupt or trap) when it needs hardware services from the kernel.";
    }
    if (lowerTopic.contains('pcb') || lowerTopic.contains('process control block')) {
      return "💡 Hint: The PCB acts like a student's ID passport containing program counter, registers, PID, and open file descriptors.";
    }
    if (lowerTopic.contains('process state') || lowerTopic.contains('state')) {
      return "💡 Hint: Follow the lifecycle of a task: Created (New) ➔ Waiting for CPU (Ready) ➔ On CPU (Running) ➔ Waiting for I/O (Waiting) ➔ Done.";
    }
    if (lowerTopic.contains('context switch')) {
      return "💡 Hint: Saving the state of the old process and loading the state of the new process is pure CPU overhead that does no useful user work.";
    }
    if (lowerTopic.contains('fcfs') || lowerTopic.contains('first-come')) {
      return "💡 Hint: The earliest arriving job gets the CPU first, which can cause the 'Convoy Effect' if a long CPU burst blocks short tasks.";
    }
    if (lowerTopic.contains('sjf') || lowerTopic.contains('shortest job')) {
      return "💡 Hint: Picking the shortest burst time minimizes the average waiting time, though future burst lengths must be predicted.";
    }
    if (lowerTopic.contains('round robin') || lowerTopic.contains('time quantum')) {
      return "💡 Hint: Each process receives a fixed time slice (quantum). If quantum is too small, context switch overhead kills performance.";
    }
    if (lowerTopic.contains('deadlock') && (lowerTopic.contains('condition') || lowerTopic.contains('coffman'))) {
      return "💡 Hint: Remember the 4 simultaneous conditions: Mutual Exclusion, Hold & Wait, No Preemption, and Circular Wait.";
    }
    if (lowerTopic.contains('banker')) {
      return "💡 Hint: The Banker's Algorithm only grants resources if the resulting state guarantees at least one safe execution sequence.";
    }
    if (lowerTopic.contains('semaphore') || lowerTopic.contains('mutex')) {
      return "💡 Hint: Wait (P) decrements and blocks if zero; Signal (V) increments and wakes up a waiting process.";
    }
    if (lowerTopic.contains('critical section')) {
      return "💡 Hint: A valid solution must satisfy three rules: Mutual Exclusion (only one), Progress (no deadlock), and Bounded Waiting (no starvation).";
    }
    if (lowerTopic.contains('paging') || lowerTopic.contains('page table')) {
      return "💡 Hint: Logical memory is split into fixed-size Pages, while physical memory is split into equal-size Frames. Offset stays unchanged!";
    }
    if (lowerTopic.contains('tlb') || lowerTopic.contains('translation lookaside')) {
      return "💡 Hint: The TLB is an associative fast hardware cache that avoids doing 2 memory accesses per address translation.";
    }
    if (lowerTopic.contains('belady') || lowerTopic.contains('anomaly')) {
      return "💡 Hint: Belady's Anomaly occurs in FIFO page replacement, where adding MORE frame slots actually INCREASES page faults.";
    }
    if (lowerTopic.contains('lru') || lowerTopic.contains('least recently')) {
      return "💡 Hint: Look backward in time: replace the page that has not been accessed for the longest past duration.";
    }
    if (lowerTopic.contains('scan') || lowerTopic.contains('elevator')) {
      return "💡 Hint: SCAN acts like a building elevator: moves in one direction servicing all requests until the end, then reverses.";
    }
    if (lowerTopic.contains('c-scan')) {
      return "💡 Hint: Circular SCAN moves in one direction to the end, then immediately returns to the start without servicing on the return trip.";
    }
    if (lowerTopic.contains('inode') || lowerTopic.contains('file allocation')) {
      return "💡 Hint: Inodes store metadata (permissions, owner, size) and pointers to disk blocks rather than the file data itself.";
    }
    if (lowerTopic.contains('kernel') || lowerTopic.contains('monolithic') || lowerTopic.contains('microkernel')) {
      return "💡 Hint: Monolithic puts all drivers & file systems in kernel space (fast, but large crash surface). Microkernel keeps only IPC, scheduling & basic memory in Ring 0.";
    }

    // Contextual fallback
    if (explanation.length > 20) {
      final firstSentence = explanation.split('.').first;
      return "💡 Hint: Focus on the core concept: $firstSentence.";
    }
    return "💡 Hint: Consider the core responsibility of the OS kernel and how hardware resources are safely partitioned.";
  }

  /// Provides a memorable mnemonic, acronym, or mental hook to permanently remember the concept
  static String getMnemonic({
    required String topicId,
    required String topicName,
    required String questionText,
    required String explanation,
  }) {
    final lower = '$topicId $topicName $questionText'.toLowerCase();

    if (lower.contains('dual mode') || lower.contains('user mode') || lower.contains('kernel mode')) {
      return "🧠 Mnemonic: 'KING vs CITIZEN'\n• Kernel = KING (Ring 0, full hardware power)\n• User App = CITIZEN (Ring 3, must knock with a System Call)";
    }
    if (lower.contains('system call') || lower.contains('syscall')) {
      return "🧠 Mnemonic: 'TRAP to GAP'\n• System calls fire a TRAP (software interrupt) to cross the GAP from user mode into kernel mode.";
    }
    if (lower.contains('process state') || lower.contains('state')) {
      return "🧠 Mnemonic: 'N-R-R-W-T' (Never Rush, Run When Trained)\n• New ➔ Ready ➔ Running ➔ Waiting ➔ Terminated";
    }
    if (lower.contains('pcb') || lower.contains('process control block')) {
      return "🧠 Mnemonic: '3P & 3R'\n• PID, Program Counter, Priority (3P)\n• Registers, Resources, accounting Records (3R)";
    }
    if (lower.contains('deadlock') && (lower.contains('condition') || lower.contains('coffman'))) {
      return "🧠 Mnemonic: 'M-H-N-C' (Must Have No Circularity)\n• M: Mutual Exclusion\n• H: Hold and Wait\n• N: No Preemption\n• C: Circular Wait";
    }
    if (lower.contains('banker')) {
      return "🧠 Mnemonic: 'SAFE First, SERVE Later'\n• If Need <= Available, state is SAFE ➔ Allocate!\n• If ANY branch could deadlock ➔ Deny request!";
    }
    if (lower.contains('critical section') || lower.contains('peterson')) {
      return "🧠 Mnemonic: 'M-P-B' (Must Protect Boundaries)\n• M: Mutual Exclusion (Only 1 in critical zone)\n• P: Progress (No deadlock when vacant)\n• B: Bounded Waiting (No starvation)";
    }
    if (lower.contains('semaphore')) {
      return "🧠 Mnemonic: 'P = Pause (Wait), V = Vacate (Signal)'\n• P(S): S-- (Pause/Sleep if S < 0)\n• V(S): S++ (Vacate/Signal next waiting process)";
    }
    if (lower.contains('scheduling') && (lower.contains('criteria') || lower.contains('metric'))) {
      return "🧠 Mnemonic: 'MAX C-T, MIN T-W-R'\n• MAXimize: CPU Utilization & Throughput\n• MINimize: Turnaround time, Waiting time, Response time";
    }
    if (lower.contains('fcfs')) {
      return "🧠 Mnemonic: 'CONVOY at the Drive-thru'\n• First Come, First Served: One giant truck in front makes all tiny sports cars wait behind it.";
    }
    if (lower.contains('sjf') || lower.contains('shortest')) {
      return "🧠 Mnemonic: 'EXPRESS Checkout'\n• Shortest Job First: Always serve 1-item customers first to minimize average queue wait time.";
    }
    if (lower.contains('paging') || lower.contains('page table')) {
      return "🧠 Mnemonic: 'P-to-F, Offset is FREE'\n• Page (P) maps to Frame (F) through Page Table\n• Offset (d) stays identical across Logical & Physical!";
    }
    if (lower.contains('replacement') || lower.contains('lru') || lower.contains('fifo')) {
      return "🧠 Mnemonic: 'OLDEST, COLDEST, FURTHEST'\n• FIFO = OLDEST in arrival time\n• LRU = COLDEST in recent usage\n• OPT = FURTHEST away in future reference";
    }
    if (lower.contains('belady')) {
      return "🧠 Mnemonic: 'MORE Frames, MORE Pain'\n• Belady's Anomaly = FIFO paradox where adding more page frames ironically increases page faults!";
    }
    if (lower.contains('thrashing')) {
      return "🧠 Mnemonic: 'SPINNING Wheels'\n• Thrashing = OS spends 99% of time swapping pages in/out and 1% doing real computation.";
    }
    if (lower.contains('scan') || lower.contains('elevator')) {
      return "🧠 Mnemonic: 'ELEVATOR Rule'\n• SCAN moves top-to-bottom like an elevator, sweeping every floor in its path.";
    }
    if (lower.contains('c-scan')) {
      return "🧠 Mnemonic: 'ONE-WAY Express'\n• C-SCAN sweeps in one direction, then immediately jumps back to track 0 without servicing on the way back.";
    }
    if (lower.contains('memory allocation') || lower.contains('first fit') || lower.contains('best fit')) {
      return "🧠 Mnemonic: 'F-B-W (Fastest, Tightest, Roomiest)'\n• First Fit = FASTEST search\n• Best Fit = TIGHTEST fit (leaves tiny unusable holes)\n• Worst Fit = ROOMIEST leftover space";
    }

    // Default dynamic memory anchor
    return "🧠 Mnemonic: 'OBSERVE & ANCHOR'\n• $topicName: Remember that OS coordinates conflicting demands by guaranteeing fairness, isolation, and controlled hardware access.";
  }
}

