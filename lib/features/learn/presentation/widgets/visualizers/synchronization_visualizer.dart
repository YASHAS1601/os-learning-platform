import 'package:flutter/material.dart';
import 'package:os_learning_platform/core/theme/app_colors.dart';
import 'package:os_learning_platform/core/widgets/glass_container.dart';

// ============================================================================
// 1. CRITICAL SECTION PROBLEM VISUALIZER (sync_1)
// ============================================================================
class CsProblemVisualizer extends StatefulWidget {
  const CsProblemVisualizer({super.key});

  @override
  State<CsProblemVisualizer> createState() => _CsProblemVisualizerState();
}

class _CsProblemVisualizerState extends State<CsProblemVisualizer> {
  int _activeProcessInCs = 0; // 0: None, 1: P1, 2: P2

  void _enterCs(int proc) {
    if (_activeProcessInCs == 0) {
      setState(() => _activeProcessInCs = proc);
    }
  }

  void _exitCs() {
    setState(() => _activeProcessInCs = 0);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: const Color(0xFF00F0FF).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lock_person_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Critical Section 3 Requirements Validator', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // CS Gate Box
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _activeProcessInCs != 0 ? Colors.red.withAlpha(30) : Colors.green.withAlpha(30),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _activeProcessInCs != 0 ? Colors.red : Colors.green, width: 1.5),
            ),
            child: Column(
              children: [
                Text(
                  _activeProcessInCs != 0 ? 'CRITICAL SECTION LOCKED (Occupied by P$_activeProcessInCs)' : 'CRITICAL SECTION FREE (Ready for entry)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: _activeProcessInCs != 0 ? Colors.redAccent : Colors.green),
                ),
                const SizedBox(height: 6),
                const Text('3 Rules Satisfied:\n1. Mutual Exclusion: Only 1 process in CS.\n2. Progress: Outside process cannot block others.\n3. Bounded Waiting: Limit on wait time.', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _activeProcessInCs == 0 ? () => _enterCs(1) : null,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('P1 Request Entry', style: TextStyle(fontSize: 11)),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: ElevatedButton(
                  onPressed: _activeProcessInCs == 0 ? () => _enterCs(2) : null,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  child: const Text('P2 Request Entry', style: TextStyle(fontSize: 11)),
                ),
              ),
              const SizedBox(width: 6),
              OutlinedButton(
                onPressed: _activeProcessInCs != 0 ? _exitCs : null,
                child: const Text('Exit CS', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 2. RACE CONDITION STEP-BY-STEP VISUALIZER (sync_2)
// ============================================================================
class RaceConditionVisualizer extends StatefulWidget {
  const RaceConditionVisualizer({super.key});

  @override
  State<RaceConditionVisualizer> createState() => _RaceConditionVisualizerState();
}

class _RaceConditionVisualizerState extends State<RaceConditionVisualizer> {
  int _step = 0;

  static const List<String> _steps = [
    'Initial State: Shared variable count = 5.',
    'Step 1: Thread A reads count (5) into Register A.',
    'Step 2: Thread B reads count (5) into Register B.',
    'Step 3: Thread A increments Register A to 6 and writes count = 6.',
    'Step 4: Thread B increments Register B to 6 and writes count = 6.',
    'Final Outcome: count = 6 (Expected 7, 1 increment permanently LOST!).',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: const Color(0xFFFF007A).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Step-by-Step Lost Increment Race Trace', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFF007A))),
            child: Text(
              _steps[_step],
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: _step == 5 ? Colors.red : AppColors.text1(context)),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setState(() => _step = (_step + 1) % _steps.length),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007A), foregroundColor: Colors.white),
                  child: Text(_step == 5 ? 'Reset Trace 🔄' : 'Next Step (${_step + 1}/${_steps.length}) ➔', style: const TextStyle(fontSize: 11)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 3. MUTEX LOCK VISUALIZER (sync_3)
// ============================================================================
class MutexLockVisualizer extends StatelessWidget {
  const MutexLockVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: const Color(0xFF00FF66).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lock_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Mutual Exclusion Lock Gate', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00FF66))),
            child: const Text('Mutual Exclusion Principle:\nOnly 1 process is permitted inside the Critical Section at any time t. All competing processes wait in lock queue.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 4. PETERSON\'S SOLUTION VISUALIZER (sync_4)
// ============================================================================
class PetersonVisualizer extends StatefulWidget {
  const PetersonVisualizer({super.key});

  @override
  State<PetersonVisualizer> createState() => _PetersonVisualizerState();
}

class _PetersonVisualizerState extends State<PetersonVisualizer> {
  bool _flag0 = false;
  bool _flag1 = false;
  int _turn = 0;
  String _csStatus = 'Critical Section Empty';

  void _p0Enter() {
    setState(() {
      _flag0 = true;
      _turn = 1;
      if (_flag1 && _turn == 1) {
        _csStatus = 'P0 waiting in while loop (P1 turn)';
      } else {
        _csStatus = 'P0 Entered Critical Section!';
      }
    });
  }

  void _p1Enter() {
    setState(() {
      _flag1 = true;
      _turn = 0;
      if (_flag0 && _turn == 0) {
        _csStatus = 'P1 waiting in while loop (P0 turn)';
      } else {
        _csStatus = 'P1 Entered Critical Section!';
      }
    });
  }

  void _reset() {
    setState(() {
      _flag0 = false;
      _flag1 = false;
      _turn = 0;
      _csStatus = 'Critical Section Empty';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: const Color(0xFF7000FF).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.code_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Peterson\'s 2-Process Algorithm', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
                    ),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.refresh_rounded, size: 18), onPressed: _reset),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF7000FF))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shared Variables: flag[0]=$_flag0 | flag[1]=$_flag1 | turn=$_turn', style: const TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text('Status: $_csStatus', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.purple)),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: _p0Enter, child: const Text('P0 Request CS', style: TextStyle(fontSize: 11)))),
              const SizedBox(width: 8),
              Expanded(child: ElevatedButton(onPressed: _p1Enter, child: const Text('P1 Request CS', style: TextStyle(fontSize: 11)))),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 5. SEMAPHORE BOUNCER VISUALIZER (sync_5)
// ============================================================================
class SemaphoreVisualizer extends StatefulWidget {
  const SemaphoreVisualizer({super.key});

  @override
  State<SemaphoreVisualizer> createState() => _SemaphoreVisualizerState();
}

class _SemaphoreVisualizerState extends State<SemaphoreVisualizer> {
  int _semaphoreValue = 3;

  void _wait() {
    if (_semaphoreValue > 0) {
      setState(() => _semaphoreValue--);
    }
  }

  void _signal() {
    setState(() => _semaphoreValue++);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: const Color(0xFF00F0FF).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.pin_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Counting Semaphore Bouncer', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF00F0FF), borderRadius: BorderRadius.circular(6)),
                child: Text('Count: $_semaphoreValue', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _semaphoreValue > 0 ? _wait : null,
                  icon: const Icon(Icons.remove, size: 16),
                  label: const Text('wait(S) [P Operation]', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.black),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _signal,
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('signal(S) [V Operation]', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 6. MUTEX OWNERSHIP VISUALIZER (sync_6)
// ============================================================================
class MutexOwnershipVisualizer extends StatelessWidget {
  const MutexOwnershipVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: const Color(0xFFFFB800).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.vpn_key_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Mutex Ownership Lock Rule', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFFB800))),
            child: const Text('Mutex Ownership Restriction:\nUnlike Binary Semaphore, ONLY the specific thread that acquired the mutex lock is legally permitted to unlock it.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 7. MONITOR CONSTRUCT VISUALIZER (sync_7)
// ============================================================================
class MonitorConstructVisualizer extends StatelessWidget {
  const MonitorConstructVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: const Color(0xFF7000FF).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.security_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('High-Level Monitor Language Construct', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF7000FF))),
            child: const Text('Monitor Abstract Data Type:\nEncapsulates private shared data and condition variables (`x.wait()`, `x.signal()`). Guarantees automatic mutual exclusion for methods (e.g. Java `synchronized`).', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 8. PRODUCER CONSUMER VISUALIZER (sync_8)
// ============================================================================
class ProducerConsumerVisualizer extends StatefulWidget {
  const ProducerConsumerVisualizer({super.key});

  @override
  State<ProducerConsumerVisualizer> createState() => _ProducerConsumerVisualizerState();
}

class _ProducerConsumerVisualizerState extends State<ProducerConsumerVisualizer> {
  int _itemCount = 0;
  static const int _capacity = 5;

  void _produce() {
    if (_itemCount < _capacity) setState(() => _itemCount++);
  }

  void _consume() {
    if (_itemCount > 0) setState(() => _itemCount--);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: const Color(0xFF00FF66).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.inventory_2_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Bounded Buffer Producer-Consumer', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
                    ),
                  ],
                ),
              ),
              Text('Items: $_itemCount/$_capacity', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),

          // Buffer Display
          Row(
            children: List.generate(_capacity, (idx) {
              final isFilled = idx < _itemCount;
              return Expanded(
                child: Container(
                  height: 36,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isFilled ? const Color(0xFF00FF66) : Colors.grey.withAlpha(30),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: isFilled ? const Color(0xFF00FF66) : Colors.grey),
                  ),
                  child: Center(child: Text(isFilled ? '📦' : 'Empty', style: TextStyle(fontSize: 10, color: isFilled ? Colors.black : Colors.grey))),
                ),
              );
            }),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: _produce, child: const Text('Produce Item', style: TextStyle(fontSize: 11)))),
              const SizedBox(width: 8),
              Expanded(child: ElevatedButton(onPressed: _consume, child: const Text('Consume Item', style: TextStyle(fontSize: 11)))),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 9. READERS WRITERS VISUALIZER (sync_9)
// ============================================================================
class ReadersWritersVisualizer extends StatefulWidget {
  const ReadersWritersVisualizer({super.key});

  @override
  State<ReadersWritersVisualizer> createState() => _ReadersWritersVisualizerState();
}

class _ReadersWritersVisualizerState extends State<ReadersWritersVisualizer> {
  int _activeReaders = 0;
  bool _activeWriter = false;

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: const Color(0xFF00F0FF).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.menu_book_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Readers-Writers Concurrency Lock', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00F0FF))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Active State: ${_activeWriter ? "WRITER ACCESS (EXCLUSIVE)" : "READERS ACCESS ($_activeReaders Active)"}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: _activeWriter ? Colors.red : Colors.green)),
                const SizedBox(height: 4),
                const Text('• Multiple Readers can read concurrently when no writer is active.\n• Writer requires exclusive access (blocks all readers and writers).', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: !_activeWriter ? () => setState(() => _activeReaders++) : null, child: const Text('+ Reader', style: TextStyle(fontSize: 11)))),
              const SizedBox(width: 6),
              Expanded(child: ElevatedButton(onPressed: _activeReaders > 0 ? () => setState(() => _activeReaders--) : null, child: const Text('- Reader', style: TextStyle(fontSize: 11)))),
              const SizedBox(width: 6),
              Expanded(child: ElevatedButton(onPressed: () => setState(() { _activeWriter = !_activeWriter; if (_activeWriter) _activeReaders = 0; }), style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white), child: Text(_activeWriter ? 'Release Writer' : 'Acquire Writer', style: const TextStyle(fontSize: 10)))),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 10. DINING PHILOSOPHERS VISUALIZER (sync_10)
// ============================================================================
class DiningPhilosophersVisualizer extends StatelessWidget {
  const DiningPhilosophersVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: const Color(0xFFFFB800).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.restaurant_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('5 Dining Philosophers Chopsticks Table', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFFB800))),
            child: const Text('Deadlock Condition:\nIf all 5 philosophers grab left chopstick simultaneously ➔ Circular Wait Deadlock!\nSolution: Asymmetric pickup (odd pick left first, even pick right first).', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4)),
          ),
        ],
      ),
    );
  }
}
