import 'package:flutter/material.dart';
import 'package:os_learning_platform/core/theme/app_colors.dart';
import 'package:os_learning_platform/core/widgets/glass_container.dart';

// ============================================================================
// 1. FILE CONCEPTS VISUALIZER (file_1)
// ============================================================================
class FileConceptsVisualizer extends StatelessWidget {
  const FileConceptsVisualizer({super.key});

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
              Icon(Icons.insert_drive_file_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Logical File Abstraction', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFF007A))),
            child: const Text('File Storage Unit:\nA file is a named collection of persistent information stored on secondary media, abstracted by the OS into a stream of contiguous bytes.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 2. FILE ATTRIBUTES VISUALIZER (file_2)
// ============================================================================
class FileAttributesVisualizer extends StatelessWidget {
  const FileAttributesVisualizer({super.key});

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
              Icon(Icons.info_outline_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('File Metadata Attributes Inspector', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00F0FF))),
            child: const Text('Metadata Fields:\n• Name: "document.pdf"\n• Type: Regular File (0644)\n• Size: 4,194,304 Bytes (4MB)\n• Owner: user (UID 1000, GID 1000)\n• Timestamps: Access, Modify, Change', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 3. FILE OPERATIONS VISUALIZER (file_3)
// ============================================================================
class FileOperationsVisualizer extends StatefulWidget {
  const FileOperationsVisualizer({super.key});

  @override
  State<FileOperationsVisualizer> createState() => _FileOperationsVisualizerState();
}

class _FileOperationsVisualizerState extends State<FileOperationsVisualizer> {
  int _offset = 0;
  bool _isOpen = true;

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
                    Icon(Icons.edit_document, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('File Operations & Offset Pointer', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
                    ),
                  ],
                ),
              ),
              Text(_isOpen ? 'fd: 3 (OPEN)' : 'fd: NONE (CLOSED)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _isOpen ? Colors.green : Colors.red)),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00FF66))),
            child: Text('Current File Read/Write Offset Pointer: $_offset Bytes', style: const TextStyle(fontSize: 12, fontFamily: 'monospace', fontWeight: FontWeight.bold)),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: _isOpen ? () => setState(() => _offset += 512) : null, child: const Text('Read 512B', style: TextStyle(fontSize: 10)))),
              const SizedBox(width: 4),
              Expanded(child: ElevatedButton(onPressed: _isOpen ? () => setState(() => _offset = 0) : null, child: const Text('Seek(0)', style: TextStyle(fontSize: 10)))),
              const SizedBox(width: 4),
              Expanded(child: ElevatedButton(onPressed: () => setState(() => _isOpen = !_isOpen), style: ElevatedButton.styleFrom(backgroundColor: _isOpen ? Colors.red : Colors.green, foregroundColor: Colors.white), child: Text(_isOpen ? 'Close File' : 'Open File', style: const TextStyle(fontSize: 10)))),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 4. DIRECTORY STRUCTURE VISUALIZER (file_4)
// ============================================================================
class DirectoryStructureVisualizer extends StatelessWidget {
  const DirectoryStructureVisualizer({super.key});

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
              Icon(Icons.folder_copy_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Tree-Structured Directory Hierarchy', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFFB800))),
            child: const Text('Directory Hierarchy:\nRoot (/)\n ├── /bin (System Executables)\n ├── /etc (Config Files)\n └── /home/user\n      ├── docs/\n      └── script.sh', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 5. FILE ALLOCATION INTRO VISUALIZER (file_5)
// ============================================================================
class FileAllocIntroVisualizer extends StatelessWidget {
  const FileAllocIntroVisualizer({super.key});

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
              Icon(Icons.storage_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('File Block Allocation Strategies', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF7000FF))),
            child: const Text('3 Primary Methods:\n1. Contiguous: Fast reads, high fragmentation.\n2. Linked: No fragmentation, slow random access.\n3. Indexed (inodes): Fast random access, zero fragmentation.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 6. CONTIGUOUS FILE ALLOCATION VISUALIZER (file_6)
// ============================================================================
class ContiguousFileAllocVisualizer extends StatelessWidget {
  const ContiguousFileAllocVisualizer({super.key});

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
              Icon(Icons.view_array_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Contiguous File Block Allocation', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFF007A))),
            child: const Text('Directory Entry: Start Block = 12 | Length = 4\nDisk Blocks: [12, 13, 14, 15] (Consecutive Disk Sectors)\n(Fastest sequential read speed! Hard to grow file size).', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 7. LINKED FILE ALLOCATION VISUALIZER (file_7)
// ============================================================================
class LinkedFileAllocVisualizer extends StatelessWidget {
  const LinkedFileAllocVisualizer({super.key});

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
              Icon(Icons.link_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Linked List Block Pointer Chain', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00FF66))),
            child: const Text('Directory Entry: Start = 9 | End = 25\nBlock Chain: [ Block 9 ➔ ptr:16 ] ➔ [ Block 16 ➔ ptr:25 ] ➔ [ Block 25 ➔ ptr:nil ]\n(No external fragmentation! Random access requires sequential traversal).', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 8. INDEXED FILE ALLOCATION (INODES) VISUALIZER (file_8)
// ============================================================================
class IndexedFileAllocVisualizer extends StatelessWidget {
  const IndexedFileAllocVisualizer({super.key});

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
              Icon(Icons.format_list_numbered_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Indexed Allocation Inode Pointer Tree', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00F0FF))),
            child: const Text('UNIX ext4 Inode Structure:\n• Direct Block Pointers: [102, 103, 104, 105]\n• Single Indirect Pointer ➔ Block Index Table\n• Double Indirect Pointer ➔ Table of Tables\n(Supports fast O(1) random access & huge multi-TB files!).', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 9. FREE SPACE MANAGEMENT VISUALIZER (file_9)
// ============================================================================
class FreeSpaceMgmtVisualizer extends StatelessWidget {
  const FreeSpaceMgmtVisualizer({super.key});

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
              Icon(Icons.grid_on_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Bit Vector (Bitmap) Free Space Tracker', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFFB800))),
            child: const Text('Disk Bitmap Structure:\n0 0 1 1 0 1 0 0 1 1 (0 = Allocated, 1 = Free Block)\nFast bitwise hardware operations locate free blocks instantly.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// Default Wrapper
class FileSystemVisualizer extends StatelessWidget {
  const FileSystemVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    return const FileAllocIntroVisualizer();
  }
}
