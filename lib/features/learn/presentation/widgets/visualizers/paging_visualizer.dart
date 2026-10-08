import 'package:flutter/material.dart';
import 'package:os_learning_platform/core/theme/app_colors.dart';
import 'package:os_learning_platform/core/widgets/glass_container.dart';

// ============================================================================
// 9. PAGING ADDRESS TRANSLATION VISUALIZER (mem_9)
// ============================================================================
class PagingAddressTranslationVisualizer extends StatefulWidget {
  const PagingAddressTranslationVisualizer({super.key});

  @override
  State<PagingAddressTranslationVisualizer> createState() => _PagingAddressTranslationVisualizerState();
}

class _PagingAddressTranslationVisualizerState extends State<PagingAddressTranslationVisualizer> {
  int _logicalAddress = 2172;
  static const int _pageSize = 1024; // 1 KB

  // Page Table: Page # -> Frame #
  static const Map<int, int> _pageTable = {
    0: 3,
    1: 7,
    2: 5,
    3: 1,
  };

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    final pageNum = _logicalAddress ~/ _pageSize;
    final offset = _logicalAddress % _pageSize;
    final frameNum = _pageTable[pageNum] ?? 0;
    final physicalAddress = (frameNum * _pageSize) + offset;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: const Color(0xFF00FF66).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.swap_horizontal_circle_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('MMU Paging Address Translation Hardware', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: Text('Logical Address: $_logicalAddress B', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
              Expanded(
                child: Slider(
                  value: _logicalAddress.toDouble(),
                  min: 0,
                  max: 4095,
                  activeColor: const Color(0xFF00FF66),
                  onChanged: (val) => setState(() => _logicalAddress = val.toInt()),
                ),
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00FF66))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('MMU Translation Breakdown (Page Size = 1024 B):', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.text1(context))),
                const SizedBox(height: 4),
                Text('1. Page Number (p) = $_logicalAddress / 1024 = $pageNum', style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                Text('2. Offset (d) = $_logicalAddress % 1024 = $offset (Copied directly!)', style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                Text('3. Page Table Lookup: Page Table[$pageNum] ➔ Frame $frameNum', style: const TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: Colors.blue)),
                Text('4. Physical Address = ($frameNum * 1024) + $offset = $physicalAddress', style: const TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: Color(0xFF00FF66))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 10. SEGMENTATION ADDRESS TRANSLATION VISUALIZER (mem_10)
// ============================================================================
class SegmentationVisualizer extends StatefulWidget {
  const SegmentationVisualizer({super.key});

  @override
  State<SegmentationVisualizer> createState() => _SegmentationVisualizerState();
}

class _SegmentationVisualizerState extends State<SegmentationVisualizer> {
  int _offset = 250;
  int _segmentNum = 0; // 0: Code, 1: Heap, 2: Stack

  static const List<Map<String, dynamic>> _segTable = [
    {'name': 'Segment 0 (Code)', 'base': 1400, 'limit': 1000},
    {'name': 'Segment 1 (Heap)', 'base': 6300, 'limit': 400},
    {'name': 'Segment 2 (Stack)', 'base': 4700, 'limit': 1000},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final seg = _segTable[_segmentNum];
    final base = seg['base'] as int;
    final limit = seg['limit'] as int;
    final isValid = _offset < limit;
    final physicalAddr = base + _offset;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (isValid ? const Color(0xFF00F0FF) : Colors.red).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.segment_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Segmentation Hardware Address Translator', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: List.generate(_segTable.length, (idx) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: ChoiceChip(
                    label: Text('Seg $idx', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    selected: _segmentNum == idx,
                    onSelected: (_) => setState(() => _segmentNum = idx),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(child: Text('Offset (d): $_offset', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
              Expanded(
                child: Slider(
                  value: _offset.toDouble(),
                  min: 0,
                  max: 1200,
                  activeColor: isValid ? const Color(0xFF00F0FF) : Colors.red,
                  onChanged: (val) => setState(() => _offset = val.toInt()),
                ),
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: isValid ? const Color(0xFF00F0FF) : Colors.red)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Segment Table Entry [Seg $_segmentNum]: Base = $base | Limit = $limit', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  isValid
                      ? '✓ VALID: Offset ($_offset) < Limit ($limit)\nPhysical RAM Address = Base ($base) + Offset ($_offset) = $physicalAddr'
                      : '🚨 SEGMENTATION FAULT! Offset ($_offset) >= Limit ($limit). Address out of bounds!',
                  style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: isValid ? Colors.green : Colors.redAccent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
