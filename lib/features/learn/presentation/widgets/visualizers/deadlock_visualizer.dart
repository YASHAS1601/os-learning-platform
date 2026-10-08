import 'package:flutter/material.dart';
import 'package:os_learning_platform/core/theme/app_colors.dart';
import 'package:os_learning_platform/core/widgets/glass_container.dart';

// ============================================================================
// 1. DEADLOCK INTRO VISUALIZER (dl_1)
// ============================================================================
class DeadlockIntroVisualizer extends StatelessWidget {
  const DeadlockIntroVisualizer({super.key});

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
              Icon(Icons.warning_amber_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('4-Way Traffic Gridlock Analogy', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFFB800))),
            child: const Text(
              'Deadlock Traffic Analogy:\n4 cars enter an intersection simultaneously. Each car holds its lane (Resource) and waits for the next car to advance.\nNo car can move ➔ Permanent Gridlock Freeze!',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 2. 4 COFFMAN CONDITIONS VISUALIZER (dl_2)
// ============================================================================
class CoffmanConditionsVisualizer extends StatefulWidget {
  const CoffmanConditionsVisualizer({super.key});

  @override
  State<CoffmanConditionsVisualizer> createState() => _CoffmanConditionsVisualizerState();
}

class _CoffmanConditionsVisualizerState extends State<CoffmanConditionsVisualizer> {
  bool _c1 = true; // Mutual Exclusion
  bool _c2 = true; // Hold and Wait
  bool _c3 = true; // No Preemption
  bool _c4 = true; // Circular Wait

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final isDeadlock = _c1 && _c2 && _c3 && _c4;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (isDeadlock ? Colors.red : Colors.green).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.rule_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('4 Coffman Deadlock Conditions Switchboard', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          CheckboxListTile(
            title: const Text('1. Mutual Exclusion (Non-shareable resource)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            value: _c1,
            onChanged: (val) => setState(() => _c1 = val ?? false),
          ),
          CheckboxListTile(
            title: const Text('2. Hold and Wait (Holding resource while requesting)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            value: _c2,
            onChanged: (val) => setState(() => _c2 = val ?? false),
          ),
          CheckboxListTile(
            title: const Text('3. No Preemption (Resource cannot be revoked forcibly)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            value: _c3,
            onChanged: (val) => setState(() => _c3 = val ?? false),
          ),
          CheckboxListTile(
            title: const Text('4. Circular Wait (Closed loop waiting chain)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            value: _c4,
            onChanged: (val) => setState(() => _c4 = val ?? false),
          ),

          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDeadlock ? Colors.red.withAlpha(40) : Colors.green.withAlpha(40), borderRadius: BorderRadius.circular(8), border: Border.all(color: isDeadlock ? Colors.red : Colors.green)),
            child: Text(
              isDeadlock ? '🚨 ALL 4 CONDITIONS ACTIVE ➔ DEADLOCK IS POSSIBLE!' : '✓ AT LEAST 1 CONDITION BROKEN ➔ DEADLOCK IS IMPOSSIBLE!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isDeadlock ? Colors.redAccent : Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 3. RESOURCE ALLOCATION GRAPH (RAG) VISUALIZER (dl_3)
// ============================================================================
class RagVisualizer extends StatefulWidget {
  const RagVisualizer({super.key});

  @override
  State<RagVisualizer> createState() => _RagVisualizerState();
}

class _RagVisualizerState extends State<RagVisualizer> {
  bool _hasCycle = true;

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (_hasCycle ? Colors.red : Colors.green).withAlpha(100),
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
                    Icon(Icons.account_tree_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Resource Allocation Graph (RAG)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _hasCycle,
                activeThumbColor: Colors.red,
                onChanged: (val) => setState(() => _hasCycle = val),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: _hasCycle ? Colors.red : Colors.green)),
            child: Text(
              _hasCycle
                  ? 'RAG Status: Cycle Detected!\nEdges: [P1 ➔ R1], [R1 ➔ P2], [P2 ➔ R2], [R2 ➔ P1]\n(Single instance resource with cycle ➔ Deadlock Exists!).'
                  : 'RAG Status: No Cycle Detected.\nEdges: [P1 ➔ R1], [R1 ➔ P2]\n(Acyclic graph guarantees Deadlock-Free system!).',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: _hasCycle ? Colors.redAccent : Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 4. DEADLOCK PREVENTION VISUALIZER (dl_4)
// ============================================================================
class DeadlockPreventionVisualizer extends StatelessWidget {
  const DeadlockPreventionVisualizer({super.key});

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
              Icon(Icons.gavel_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Linear Lock Ordering Prevention', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00FF66))),
            child: const Text('Strict Resource Hierarchy:\nAssign numerical ranks: F(Tape)=1, F(Disk)=2, F(Printer)=3.\nRule: Processes MUST acquire locks in strictly increasing numerical order.\n(Prevents Circular Wait cycles completely!).', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 5. DEADLOCK AVOIDANCE SAFE STATE VISUALIZER (dl_5)
// ============================================================================
class DeadlockAvoidanceVisualizer extends StatelessWidget {
  const DeadlockAvoidanceVisualizer({super.key});

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
              Icon(Icons.shield_moon_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Safe vs Unsafe State Space Trajectory', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00F0FF))),
            child: const Text('State Trajectory:\n• Safe State: At least 1 safe execution sequence exists (Deadlock impossible).\n• Unsafe State: Potential for deadlock if worst-case claims occur.\n• Deadlock State: Unsafe state that triggered circular wait.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 6. BANKER\'S ALGORITHM MATRIX VISUALIZER (dl_6)
// ============================================================================
class BankersVisualizer extends StatefulWidget {
  const BankersVisualizer({super.key});

  @override
  State<BankersVisualizer> createState() => _BankersVisualizerState();
}

class _BankersVisualizerState extends State<BankersVisualizer> {
  bool _isSafe = true;

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (_isSafe ? const Color(0xFF00FF66) : Colors.red).withAlpha(100),
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
                    Icon(Icons.calculate_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Banker\'s Algorithm Need Matrix', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
                    ),
                  ],
                ),
              ),
              Switch(value: _isSafe, activeThumbColor: const Color(0xFF00FF66), onChanged: (val) => setState(() => _isSafe = val)),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: _isSafe ? const Color(0xFF00FF66) : Colors.red)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Need Matrix = Max - Allocation:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('P0 Need: [7, 4, 3] | P1 Need: [1, 2, 2]\nP2 Need: [6, 0, 0] | P3 Need: [0, 1, 1]', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
                const SizedBox(height: 6),
                Text(
                  _isSafe ? '✓ Safe Sequence Found: < P1, P3, P4, P0, P2 >' : '🚨 UNSAFE STATE! No execution sequence can guarantee zero deadlock.',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _isSafe ? Colors.green : Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 7. DEADLOCK DETECTION (WFG) VISUALIZER (dl_7)
// ============================================================================
class DeadlockDetectionVisualizer extends StatelessWidget {
  const DeadlockDetectionVisualizer({super.key});

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
              Icon(Icons.search_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Wait-For Graph (WFG) Deadlock Detector', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFFB800))),
            child: const Text('Wait-For Graph Reduction:\nRemoves resource nodes from RAG, creating direct process wait edges: [P1 ➔ P2]. Running cycle detection algorithms periodically locates deadlocked processes.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 8. DEADLOCK RECOVERY VISUALIZER (dl_8)
// ============================================================================
class DeadlockRecoveryVisualizer extends StatefulWidget {
  const DeadlockRecoveryVisualizer({super.key});

  @override
  State<DeadlockRecoveryVisualizer> createState() => _DeadlockRecoveryVisualizerState();
}

class _DeadlockRecoveryVisualizerState extends State<DeadlockRecoveryVisualizer> {
  bool _isRecovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (_isRecovered ? Colors.green : Colors.red).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.cleaning_services_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Deadlock Recovery Strategy', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: _isRecovered ? Colors.green : Colors.red)),
            child: Text(
              _isRecovered
                  ? '✓ RECOVERY COMPLETE: Aborted Process P2. Released Resource R2 to P1. Cycle broken!'
                  : '🚨 DEADLOCK DETECTED: [P1 ➔ R1 ➔ P2 ➔ R2 ➔ P1]. Click button to abort P2.',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: _isRecovered ? Colors.green : Colors.redAccent),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => setState(() => _isRecovered = !_isRecovered),
              style: ElevatedButton.styleFrom(backgroundColor: _isRecovered ? Colors.green : Colors.red, foregroundColor: Colors.white),
              child: Text(_isRecovered ? 'Reset Deadlock' : 'Abort Process P2 to Recover 🛠️', style: const TextStyle(fontSize: 11)),
            ),
          ),
        ],
      ),
    );
  }
}
