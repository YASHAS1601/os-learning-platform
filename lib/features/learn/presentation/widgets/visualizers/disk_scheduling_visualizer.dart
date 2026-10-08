import 'package:flutter/material.dart';
import 'package:os_learning_platform/core/theme/app_colors.dart';
import 'package:os_learning_platform/core/widgets/glass_container.dart';

// ============================================================================
// 1. DISK STRUCTURE VISUALIZER (disk_1)
// ============================================================================
class DiskStructureVisualizer extends StatelessWidget {
  const DiskStructureVisualizer({super.key});

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
              Icon(Icons.disc_full_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('Mechanical HDD Disk Geometry', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF7000FF))),
            child: const Text('Physical Disk Components:\n• Spinning Platters (e.g. 7200 RPM)\n• Read/Write Arm Heads\n• Concentric Tracks & Sectors (512B / 4KB)\n• Cylinder: Matching track position across all platters.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 2. DISK SCHEDULING LATENCY VISUALIZER (disk_2)
// ============================================================================
class DiskLatencyVisualizer extends StatefulWidget {
  const DiskLatencyVisualizer({super.key});

  @override
  State<DiskLatencyVisualizer> createState() => _DiskLatencyVisualizerState();
}

class _DiskLatencyVisualizerState extends State<DiskLatencyVisualizer> {
  final int _seekTime = 6; // ms
  final int _rotational = 4; // ms
  final int _transfer = 1; // ms

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final total = _seekTime + _rotational + _transfer;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: const Color(0xFF00F0FF).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timer_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('Total Disk I/O Access Time Calculator', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00F0FF))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Access Time = Seek Time + Rotational Latency + Transfer Time', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Total Latency = $_seekTime ms (Seek) + $_rotational ms (Rotation) + $_transfer ms (Transfer) = $total ms', style: const TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: Color(0xFF00F0FF))),
                const SizedBox(height: 4),
                const Text('⚡ Seek Time (moving mechanical arm) dominates total disk I/O latency!', style: TextStyle(fontSize: 10, color: Colors.amber, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 3. FCFS DISK SCHEDULING VISUALIZER (disk_3)
// ============================================================================
class DiskFcfsVisualizer extends StatelessWidget {
  const DiskFcfsVisualizer({super.key});

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
              Icon(Icons.queue_play_next_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('FCFS Disk Head Movement Trace', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFF007A))),
            child: const Text('FCFS Request Trace:\nHead start = 50 | Queue: [98, 183, 37, 122, 14]\nMovement: 50 ➔ 98 ➔ 183 ➔ 37 ➔ 122 ➔ 14\nTotal Head Seek Distance = 472 Cylinders (Wild swings!).', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 4. SSTF DISK SCHEDULING VISUALIZER (disk_4)
// ============================================================================
class DiskSstfVisualizer extends StatelessWidget {
  const DiskSstfVisualizer({super.key});

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
              Icon(Icons.near_me_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('SSTF Shortest Seek Distance Trace', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00FF66))),
            child: const Text('SSTF Request Trace:\nHead start = 50 | Selects closest cylinder request at each step.\nMovement: 50 ➔ 37 ➔ 14 ➔ 65 ➔ 67 ➔ 98 ➔ 122 ➔ 183\nTotal Head Seek Distance = 236 Cylinders (Drastic reduction!).', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 5. SCAN ELEVATOR VISUALIZER (disk_5)
// ============================================================================
class DiskScanVisualizer extends StatelessWidget {
  const DiskScanVisualizer({super.key});

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
              Icon(Icons.elevator_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('SCAN (Elevator) Disk Sweep', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFFB800))),
            child: const Text('SCAN Strategy:\nDisk head sweeps continuously in 1 direction ALL THE WAY to the boundary cylinder (e.g. 199) before reversing direction.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 6. C-SCAN VISUALIZER (disk_6)
// ============================================================================
class DiskCscanVisualizer extends StatelessWidget {
  const DiskCscanVisualizer({super.key});

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
              Icon(Icons.loop_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('C-SCAN Circular Un-serviced Return Sweep', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00F0FF))),
            child: const Text('C-SCAN Strategy:\nServices requests in ONE direction only. When reaching end boundary, jumps directly back to cylinder 0 WITHOUT servicing requests during return.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 7. LOOK VISUALIZER (disk_7)
// ============================================================================
class DiskLookVisualizer extends StatelessWidget {
  const DiskLookVisualizer({super.key});

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
              Icon(Icons.visibility_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('LOOK Last Request Reversal', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00FF66))),
            child: const Text('LOOK Optimization:\nChecks for requests in current direction. Reverses direction IMMEDIATELY at the last request instead of going to physical disk boundary!', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 8. C-LOOK VISUALIZER (disk_8)
// ============================================================================
class DiskClookVisualizer extends StatelessWidget {
  const DiskClookVisualizer({super.key});

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
              Icon(Icons.replay_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('C-LOOK Jump to Lowest Request', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF7000FF))),
            child: const Text('C-LOOK Optimization:\nServices requests in 1 direction up to highest requested cylinder, then jumps directly to the LOWEST REQUESTED cylinder in queue.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// Default Wrapper
class DiskSchedulingVisualizer extends StatelessWidget {
  const DiskSchedulingVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    return const DiskSstfVisualizer();
  }
}
