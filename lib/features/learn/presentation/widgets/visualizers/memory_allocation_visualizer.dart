import 'package:flutter/material.dart';
import 'package:os_learning_platform/core/theme/app_colors.dart';
import 'package:os_learning_platform/core/widgets/glass_container.dart';

// ============================================================================
// 1. MEMORY INTRO VISUALIZER (mem_1)
// ============================================================================
class MemoryIntroVisualizer extends StatelessWidget {
  const MemoryIntroVisualizer({super.key});

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
              Icon(Icons.grid_view_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('RAM Physical Memory Tracking Map', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00FF66))),
            child: const Text('Primary Memory Allocator:\nTracks physical RAM addresses, allocates space for executing programs, and reclaims memory upon process termination.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 2. CONTIGUOUS MEMORY VISUALIZER (mem_2)
// ============================================================================
class ContiguousMemVisualizer extends StatefulWidget {
  const ContiguousMemVisualizer({super.key});

  @override
  State<ContiguousMemVisualizer> createState() => _ContiguousMemVisualizerState();
}

class _ContiguousMemVisualizerState extends State<ContiguousMemVisualizer> {
  int _logicalAddr = 150;
  static const int _base = 3000;
  static const int _limit = 400;

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final isValid = _logicalAddr < _limit;
    final physicalAddr = _base + _logicalAddr;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (isValid ? Colors.green : Colors.red).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.straighten_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Base & Limit Register Protection Hardware', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: Text('Logical Address: $_logicalAddr', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
              Expanded(
                child: Slider(
                  value: _logicalAddr.toDouble(),
                  min: 0,
                  max: 600,
                  activeColor: isValid ? Colors.green : Colors.red,
                  onChanged: (val) => setState(() => _logicalAddr = val.toInt()),
                ),
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: isValid ? Colors.green : Colors.red)),
            child: Text(
              isValid
                  ? '✓ ADDRESS VALID: Logical ($_logicalAddr) < Limit ($_limit)\nPhysical RAM Address = Base ($_base) + Logical ($_logicalAddr) = $physicalAddr'
                  : '🚨 ADDRESS TRAP FAULT! Logical ($_logicalAddr) >= Limit ($_limit). Illegal memory access prevented by hardware!',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: isValid ? Colors.green : Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 3. FIXED PARTITIONING MFT VISUALIZER (mem_3)
// ============================================================================
class FixedPartitioningVisualizer extends StatelessWidget {
  const FixedPartitioningVisualizer({super.key});

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
              Icon(Icons.view_module_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Fixed Partitioning (MFT) & Internal Frag', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFFB800))),
            child: const Text('MFT Partitioning:\nFixed 500KB partition holds Process P1 (300KB).\nInternal Fragmentation = 500KB - 300KB = 200KB WASTED inside partition!', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 4. VARIABLE PARTITIONING MVT VISUALIZER (mem_4)
// ============================================================================
class VariablePartitioningVisualizer extends StatefulWidget {
  const VariablePartitioningVisualizer({super.key});

  @override
  State<VariablePartitioningVisualizer> createState() => _VariablePartitioningVisualizerState();
}

class _VariablePartitioningVisualizerState extends State<VariablePartitioningVisualizer> {
  bool _compacted = false;

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
                    Icon(Icons.compress_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Variable Partitioning & Compaction', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => setState(() => _compacted = !_compacted),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00F0FF), foregroundColor: Colors.black),
                child: Text(_compacted ? 'Reset' : 'Compact RAM', style: const TextStyle(fontSize: 10)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00F0FF))),
            child: Text(
              _compacted
                  ? '✓ COMPACTION COMPLETE:\nMerged 100KB + 200KB scattered holes into 1 single contiguous 300KB free block! Big 250KB process can now be allocated!'
                  : '⚠️ EXTERNAL FRAGMENTATION:\nFree RAM: 100KB hole + 200KB hole (Total 300KB free). Cannot allocate 250KB process because space is non-contiguous!',
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: _compacted ? Colors.green : Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 5. FIRST FIT VISUALIZER (mem_5)
// ============================================================================
class FirstFitVisualizer extends StatelessWidget {
  const FirstFitVisualizer({super.key});

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
              Icon(Icons.fast_forward_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('First Fit Memory Allocation', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00F0FF))),
            child: const Text('First Fit Search Trace:\nHoles: [100KB, 500KB, 200KB, 300KB]. Process Request = 212KB.\n1. Hole 1 (100KB) < 212KB ➔ Skip\n2. Hole 2 (500KB) >= 212KB ➔ ALLOCATED instantly! (Leftover = 288KB).', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 6. BEST FIT VISUALIZER (mem_6)
// ============================================================================
class BestFitVisualizer extends StatelessWidget {
  const BestFitVisualizer({super.key});

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
              Icon(Icons.fit_screen_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Best Fit Memory Allocation', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00FF66))),
            child: const Text('Best Fit Search Trace:\nHoles: [100KB, 500KB, 200KB, 300KB]. Process Request = 212KB.\nSearches ENTIRE list ➔ Selects 300KB block (Minimum leftover fragment = 88KB!).', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 7. WORST FIT VISUALIZER (mem_7)
// ============================================================================
class WorstFitVisualizer extends StatelessWidget {
  const WorstFitVisualizer({super.key});

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
              Icon(Icons.open_in_full_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Worst Fit Memory Allocation', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFFB800))),
            child: const Text('Worst Fit Search Trace:\nHoles: [100KB, 500KB, 200KB, 300KB, 600KB]. Process Request = 212KB.\nSearches ENTIRE list ➔ Selects LARGEST block 600KB (Leftover = 388KB!).', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 8. NEXT FIT VISUALIZER (mem_8)
// ============================================================================
class NextFitVisualizer extends StatelessWidget {
  const NextFitVisualizer({super.key});

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
              Icon(Icons.redo_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Next Fit Moving Pointer Allocation', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF7000FF))),
            child: const Text('Next Fit Cursor Trace:\nResumes searching for free holes from location of previous allocation rather than starting from index 0.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// Default Wrapper
class MemoryAllocationVisualizer extends StatelessWidget {
  const MemoryAllocationVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    return const FirstFitVisualizer();
  }
}
