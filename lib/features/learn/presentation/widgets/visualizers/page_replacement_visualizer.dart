import 'package:flutter/material.dart';
import 'package:os_learning_platform/core/theme/app_colors.dart';
import 'package:os_learning_platform/core/widgets/glass_container.dart';

// ============================================================================
// 1. VIRTUAL MEMORY INTRO VISUALIZER (vm_1)
// ============================================================================
class VmIntroVisualizer extends StatelessWidget {
  const VmIntroVisualizer({super.key});

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
              Icon(Icons.cloud_done_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Virtual Memory & Secondary Swap Space', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00F0FF))),
            child: const Text('Virtual Address Space Abstraction:\nAllows executing 16GB applications on a 8GB physical RAM system by storing inactive pages on secondary disk swap space (`pagefile.sys`).', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 2. DEMAND PAGING VISUALIZER (vm_2)
// ============================================================================
class DemandPagingVisualizer extends StatefulWidget {
  const DemandPagingVisualizer({super.key});

  @override
  State<DemandPagingVisualizer> createState() => _DemandPagingVisualizerState();
}

class _DemandPagingVisualizerState extends State<DemandPagingVisualizer> {
  bool _pageLoaded = false;

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
                    Icon(Icons.download_for_offline_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Demand Paging Lazy Swapper', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: _pageLoaded ? Colors.green : Colors.red, borderRadius: BorderRadius.circular(6)),
                child: Text('Bit: ${_pageLoaded ? "V (Valid in RAM)" : "I (Invalid on Disk)"}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: _pageLoaded ? Colors.green : Colors.red)),
            child: Text(
              _pageLoaded
                  ? '✓ PAGE IN RAM: Page 4 referenced. Valid bit (V) set. Instructions executing at memory speed!'
                  : '⚠️ LAZY SWAP: Page 4 not loaded in RAM yet (Valid bit = I). Accessing Page 4 will trigger a Page Fault!',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: _pageLoaded ? Colors.green : Colors.redAccent),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => setState(() => _pageLoaded = !_pageLoaded),
              style: ElevatedButton.styleFrom(backgroundColor: _pageLoaded ? Colors.orange : Colors.green, foregroundColor: Colors.black),
              child: Text(_pageLoaded ? 'Unload Page 4' : 'Access Page 4 (Load on Demand ⬇️)', style: const TextStyle(fontSize: 11)),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 3. PAGE FAULT SERVICE ROUTINE VISUALIZER (vm_3)
// ============================================================================
class PageFaultVisualizer extends StatefulWidget {
  const PageFaultVisualizer({super.key});

  @override
  State<PageFaultVisualizer> createState() => _PageFaultVisualizerState();
}

class _PageFaultVisualizerState extends State<PageFaultVisualizer> {
  int _routineStep = 0;

  static const List<String> _routine = [
    '1. CPU accesses invalid page address (Mode Bit Trap).',
    '2. OS intercepts Trap exception and checks internal table.',
    '3. OS verifies memory request is legitimate (not illegal boundary).',
    '4. OS locates missing page frame location on secondary disk swap.',
    '5. OS issues disk read request to fetch page into free RAM frame.',
    '6. Disk I/O completes. Page Table entry updated from I to V (Valid).',
    '7. OS Restarts exact instruction that caused Page Fault!',
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
              Icon(Icons.report_problem_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('7-Step Page Fault Service Routine', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFF007A))),
            child: Text(
              _routine[_routineStep],
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: _routineStep == 6 ? Colors.green : const Color(0xFFFF007A)),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setState(() => _routineStep = (_routineStep + 1) % _routine.length),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007A), foregroundColor: Colors.white),
                  child: Text(_routineStep == 6 ? 'Restart Execution 🔄' : 'Next Routine Step (${_routineStep + 1}/${_routine.length}) ➔', style: const TextStyle(fontSize: 11)),
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
// 4. PAGE REPLACEMENT INTRO VISUALIZER (vm_4)
// ============================================================================
class PageReplIntroVisualizer extends StatelessWidget {
  const PageReplIntroVisualizer({super.key});

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
              Icon(Icons.swap_vert_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Victim Frame Eviction Policy', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFFB800))),
            child: const Text('Victim Selection Strategy:\nWhen physical RAM frames are 100% full, the OS must select a "victim frame" to swap out to disk. Goal: Minimize future page fault rate.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 5. FIFO PAGE REPLACEMENT & BELADY ANOMALY (vm_5)
// ============================================================================
class PageReplacementFifoVisualizer extends StatefulWidget {
  const PageReplacementFifoVisualizer({super.key});

  @override
  State<PageReplacementFifoVisualizer> createState() => _PageReplacementFifoVisualizerState();
}

class _PageReplacementFifoVisualizerState extends State<PageReplacementFifoVisualizer> {
  int _frames = 3;

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    // Belady string: 1, 2, 3, 4, 1, 2, 5, 1, 2, 3, 4, 5
    final faults = _frames == 3 ? 9 : 10; // 4 frames yields MORE faults (10) -> Belady!

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
                    Expanded(
                      child: Text('FIFO & Belady\'s Anomaly Tester', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  ElevatedButton(onPressed: () => setState(() => _frames = 3), child: const Text('3 Frames', style: TextStyle(fontSize: 10))),
                  const SizedBox(width: 4),
                  ElevatedButton(onPressed: () => setState(() => _frames = 4), child: const Text('4 Frames', style: TextStyle(fontSize: 10))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF7000FF))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ref String: [1, 2, 3, 4, 1, 2, 5, 1, 2, 3, 4, 5] | Frames = $_frames', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text('Total FIFO Page Faults: $faults', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _frames == 4 ? Colors.red : Colors.green)),
                const SizedBox(height: 4),
                if (_frames == 4)
                  const Text('🚨 BELADY\'S ANOMALY DEMONSTRATED! Increasing physical frames from 3 to 4 increased total page faults from 9 to 10!', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: Colors.redAccent, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 6. LRU PAGE REPLACEMENT VISUALIZER (vm_6)
// ============================================================================
class PageReplacementLruVisualizer extends StatelessWidget {
  const PageReplacementLruVisualizer({super.key});

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
              Icon(Icons.history_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Least Recently Used (LRU) Stack Eviction', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00FF66))),
            child: const Text('LRU Strategy:\nEvicts the page that has NOT been accessed for the longest past time interval. Belonging to Stack Algorithms, LRU NEVER exhibits Belady\'s Anomaly.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 7. OPTIMAL (OPT) PAGE REPLACEMENT VISUALIZER (vm_7)
// ============================================================================
class PageReplacementOptVisualizer extends StatelessWidget {
  const PageReplacementOptVisualizer({super.key});

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
              Icon(Icons.auto_awesome_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Optimal (OPT) Benchmark Algorithm', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00F0FF))),
            child: const Text('OPT Theoretical Benchmark:\nLooks ahead into the future to replace the page that will NOT be referenced for the longest time duration. Yields absolute minimum page fault count.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 8. THRASHING VISUALIZER (vm_8)
// ============================================================================
class ThrashingVisualizer extends StatefulWidget {
  const ThrashingVisualizer({super.key});

  @override
  State<ThrashingVisualizer> createState() => _ThrashingVisualizerState();
}

class _ThrashingVisualizerState extends State<ThrashingVisualizer> {
  int _degree = 4; // Degree of multiprogramming

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final isThrashing = _degree > 8;
    final cpuUtil = isThrashing ? (100 - (_degree - 8) * 20) : (_degree * 12);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (isThrashing ? Colors.red : const Color(0xFF00F0FF)).withAlpha(100),
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
                    Icon(Icons.speed_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('System Thrashing Simulator', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
                    ),
                  ],
                ),
              ),
              Text('Degree: $_degree Processes', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            ],
          ),
          Slider(
            value: _degree.toDouble(),
            min: 1,
            max: 12,
            activeColor: isThrashing ? Colors.red : Colors.green,
            onChanged: (val) => setState(() => _degree = val.toInt()),
          ),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: isThrashing ? Colors.red : Colors.green)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CPU Utilization: ${cpuUtil.clamp(5, 96)}%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isThrashing ? Colors.red : Colors.green)),
                const SizedBox(height: 4),
                Text(
                  isThrashing
                      ? '🚨 SYSTEM THRASHING! Page Fault Rate = 100%. CPU is spend 99% of time swapping pages to disk. System frozen!'
                      : '✓ STABLE EXECUTION: Process frames fit within Working-Set RAM boundary.',
                  style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: isThrashing ? Colors.redAccent : Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Default Wrapper
class PageReplacementVisualizer extends StatelessWidget {
  final String defaultAlgorithm;

  const PageReplacementVisualizer({
    super.key,
    this.defaultAlgorithm = 'LRU',
  });

  @override
  Widget build(BuildContext context) {
    switch (defaultAlgorithm) {
      case 'FIFO':
        return const PageReplacementFifoVisualizer();
      case 'OPT':
        return const PageReplacementOptVisualizer();
      case 'LRU':
      default:
        return const PageReplacementLruVisualizer();
    }
  }
}
