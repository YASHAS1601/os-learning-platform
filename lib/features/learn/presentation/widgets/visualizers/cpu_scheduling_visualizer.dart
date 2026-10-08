import 'package:flutter/material.dart';
import 'package:os_learning_platform/core/theme/app_colors.dart';
import 'package:os_learning_platform/core/widgets/glass_container.dart';

// ============================================================================
// 1. CPU SCHEDULING INTRO & METRICS VISUALIZER (cpu_1)
// ============================================================================
class CpuIntroVisualizer extends StatefulWidget {
  const CpuIntroVisualizer({super.key});

  @override
  State<CpuIntroVisualizer> createState() => _CpuIntroVisualizerState();
}

class _CpuIntroVisualizerState extends State<CpuIntroVisualizer> {
  int _at = 0;
  int _bt = 6;
  int _ct = 8;

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final tat = _ct - _at;
    final wt = tat - _bt;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.speed_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'CPU-I/O Burst & Metrics Calculator',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              _buildInputColumn('Arrival Time (AT)', _at, (val) => setState(() => _at = val)),
              const SizedBox(width: 8),
              _buildInputColumn('Burst Time (BT)', _bt, (val) => setState(() => _bt = val)),
              const SizedBox(width: 8),
              _buildInputColumn('Completion Time (CT)', _ct, (val) => setState(() => _ct = val)),
            ],
          ),

          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xCC08121E) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Calculated Performance Metrics:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.text1(context))),
                const SizedBox(height: 6),
                Text('• Turnaround Time (TAT) = CT - AT = $_ct - $_at = $tat ms', style: const TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: Colors.blue)),
                const SizedBox(height: 4),
                Text('• Waiting Time (WT) = TAT - BT = $tat - $_bt = ${wt >= 0 ? wt : 0} ms', style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: wt < 0 ? Colors.red : Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputColumn(String label, int val, Function(int) onChange) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            children: [
              IconButton(icon: const Icon(Icons.remove, size: 14), onPressed: () { if (val > 0) onChange(val - 1); }),
              Text('$val', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              IconButton(icon: const Icon(Icons.add, size: 14), onPressed: () => onChange(val + 1)),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 2. FCFS SCHEDULING & CONVOY EFFECT VISUALIZER (cpu_2)
// ============================================================================
class CpuFcfsVisualizer extends StatefulWidget {
  const CpuFcfsVisualizer({super.key});

  @override
  State<CpuFcfsVisualizer> createState() => _CpuFcfsVisualizerState();
}

class _CpuFcfsVisualizerState extends State<CpuFcfsVisualizer> {
  bool _showConvoy = false;

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
                    Icon(Icons.queue_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(child: Text('FCFS Scheduling & Convoy Effect', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
                  ],
                ),
              ),
              Switch(
                value: _showConvoy,
                activeThumbColor: Colors.purple,
                onChanged: (val) => setState(() => _showConvoy = val),
              ),
            ],
          ),
          Text(_showConvoy ? 'Mode: Convoy Effect (Long P1 BT=24 first)' : 'Mode: Normal Arrival Order', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _showConvoy ? Colors.purple : Colors.blue)),

          const SizedBox(height: 12),

          // Gantt Chart Visual
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.purple.withAlpha(80))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Gantt Chart Timeline:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: _showConvoy
                      ? [
                          Expanded(flex: 24, child: _chartBlock('P1 (24ms)', Colors.purple)),
                          Expanded(flex: 3, child: _chartBlock('P2 (3ms)', Colors.blue)),
                          Expanded(flex: 3, child: _chartBlock('P3 (3ms)', Colors.green)),
                        ]
                      : [
                          Expanded(flex: 3, child: _chartBlock('P2 (3ms)', Colors.blue)),
                          Expanded(flex: 3, child: _chartBlock('P3 (3ms)', Colors.green)),
                          Expanded(flex: 24, child: _chartBlock('P1 (24ms)', Colors.purple)),
                        ],
                ),
                const SizedBox(height: 8),
                Text(
                  _showConvoy
                      ? 'Convoy Effect: Avg WT = 17.0 ms (Short processes P2, P3 stuck waiting behind long P1!).'
                      : 'Optimal Arrival: Avg WT = 3.0 ms (Short processes executed first).',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _showConvoy ? Colors.redAccent : Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chartBlock(String label, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: color.withAlpha(50), borderRadius: BorderRadius.circular(4), border: Border.all(color: color)),
      child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: color)),
    );
  }
}

// ============================================================================
// 3. SJF SCHEDULING VISUALIZER (cpu_3)
// ============================================================================
class CpuSjfVisualizer extends StatefulWidget {
  const CpuSjfVisualizer({super.key});

  @override
  State<CpuSjfVisualizer> createState() => _CpuSjfVisualizerState();
}

class _CpuSjfVisualizerState extends State<CpuSjfVisualizer> {
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
              Icon(Icons.flash_on_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('Shortest Job First (SJF) Provable Optimal Queue', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00FF66))),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Processes in Ready Queue (Sorted by shortest BT):', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('1. P4 (BT = 3ms) ➔ Executes First (WT = 0ms)', style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: Colors.green, fontWeight: FontWeight.bold)),
                Text('2. P1 (BT = 6ms) ➔ Executes Second (WT = 3ms)', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
                Text('3. P3 (BT = 7ms) ➔ Executes Third (WT = 9ms)', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
                Text('4. P2 (BT = 8ms) ➔ Executes Last (WT = 16ms)', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
                SizedBox(height: 6),
                Text('✓ Minimum Average Waiting Time = 7.0 ms (Provably Optimal!)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF00FF66))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 4. SRTF PREEMPTIVE VISUALIZER (cpu_4)
// ============================================================================
class CpuSrtfVisualizer extends StatefulWidget {
  const CpuSrtfVisualizer({super.key});

  @override
  State<CpuSrtfVisualizer> createState() => _CpuSrtfVisualizerState();
}

class _CpuSrtfVisualizerState extends State<CpuSrtfVisualizer> {
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
              Icon(Icons.auto_delete_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('Shortest Remaining Time First (SRTF) Preemption', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFF007A))),
            child: const Text(
              'SRTF Re-evaluation Timeline:\n• t=0ms: P1 arrives (BT=8). Starts running (rem=7).\n• t=1ms: P2 arrives (BT=4). 4 < 7 ➔ PREEMPTS P1!\n• t=5ms: P2 completes. CPU resumes P1 (rem=7).\n(Compares remaining burst times on EVERY new arrival event!).',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 5. ROUND ROBIN VISUALIZER (cpu_5)
// ============================================================================
class CpuRrVisualizer extends StatefulWidget {
  const CpuRrVisualizer({super.key});

  @override
  State<CpuRrVisualizer> createState() => _CpuRrVisualizerState();
}

class _CpuRrVisualizerState extends State<CpuRrVisualizer> {
  double _tq = 4;

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
                    Icon(Icons.rotate_right_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(child: Text('Round Robin Time Quantum Rotation', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
                  ],
                ),
              ),
              Text('TQ = ${_tq.toInt()} ms', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF00F0FF))),
            ],
          ),
          Slider(
            value: _tq,
            min: 1,
            max: 20,
            divisions: 19,
            activeColor: const Color(0xFF00F0FF),
            onChanged: (val) => setState(() => _tq = val),
          ),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00F0FF))),
            child: Text(
              _tq == 1
                  ? '⚡ Extremely Small TQ (1ms):\nHigh Context Switch Overhead! CPU spends 50% time switching.'
                  : (_tq >= 15
                      ? '⚠️ Very Large TQ (${_tq.toInt()}ms):\nDegenerates into FCFS! No preemption for short jobs.'
                      : '✓ Optimal TQ (${_tq.toInt()}ms):\nBalanced interactive response & low overhead (~80% bursts finish in TQ).'),
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: _tq == 1 || _tq >= 15 ? Colors.orange : Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 6. PRIORITY SCHEDULING & AGING VISUALIZER (cpu_6)
// ============================================================================
class CpuPriorityVisualizer extends StatefulWidget {
  const CpuPriorityVisualizer({super.key});

  @override
  State<CpuPriorityVisualizer> createState() => _CpuPriorityVisualizerState();
}

class _CpuPriorityVisualizerState extends State<CpuPriorityVisualizer> {
  int _p3Priority = 5; // Low priority
  void _boostAging() {
    setState(() {
      if (_p3Priority > 1) _p3Priority--;
    });
  }

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
              Icon(Icons.star_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('Priority Scheduling & Aging Starvation Preventer', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFFB800))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Process Ranks (Lower Number = Higher Urgency):', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('• P1: Rank 1 (High Urgency) ➔ Running', style: TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold)),
                const Text('• P2: Rank 2 (Medium Urgency) ➔ Ready', style: TextStyle(fontSize: 11)),
                Text('• P3: Rank $_p3Priority (${_p3Priority > 2 ? "Low Urgency / Starving" : "Promoted via Aging!"}) ➔ Ready', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _p3Priority <= 2 ? Colors.green : Colors.red)),
              ],
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _boostAging,
              icon: const Icon(Icons.arrow_upward_rounded, size: 16),
              label: const Text('Apply Aging Clock Pulse (Boost Priority rank)'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB800), foregroundColor: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 7. PREEMPTIVE SCHEDULING VISUALIZER (cpu_7)
// ============================================================================
class CpuPreemptiveVisualizer extends StatelessWidget {
  const CpuPreemptiveVisualizer({super.key});

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
              Icon(Icons.call_split_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('Preemptive Scheduling Event Triggers', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00F0FF))),
            child: const Text(
              'Preemption Triggers (RUNNING ➔ READY):\n1. Timer Interrupt (Time Quantum expiry)\n2. Higher Priority Process Arrival\n3. I/O Completion Signal',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 8. NON-PREEMPTIVE SCHEDULING VISUALIZER (cpu_8)
// ============================================================================
class CpuNonPreemptiveVisualizer extends StatelessWidget {
  const CpuNonPreemptiveVisualizer({super.key});

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
              Icon(Icons.lock_clock_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('Non-Preemptive Execution Control', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF7000FF))),
            child: const Text(
              'Non-Preemptive Rules (CPU cannot be revoked forcibly):\nProcess retains CPU until:\n1. Process Voluntary Exit / Termination\n2. Process Requests I/O Wait',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// Default Wrapper
class CpuSchedulingVisualizer extends StatelessWidget {
  final String defaultAlgorithm;

  const CpuSchedulingVisualizer({
    super.key,
    this.defaultAlgorithm = 'FCFS',
  });

  @override
  Widget build(BuildContext context) {
    switch (defaultAlgorithm) {
      case 'SJF':
        return const CpuSjfVisualizer();
      case 'RR':
        return const CpuRrVisualizer();
      case 'Priority':
        return const CpuPriorityVisualizer();
      case 'FCFS':
      default:
        return const CpuFcfsVisualizer();
    }
  }
}
