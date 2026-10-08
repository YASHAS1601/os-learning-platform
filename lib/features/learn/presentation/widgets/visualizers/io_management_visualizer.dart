import 'package:flutter/material.dart';
import 'package:os_learning_platform/core/theme/app_colors.dart';
import 'package:os_learning_platform/core/widgets/glass_container.dart';

// ============================================================================
// 1. I/O HARDWARE VISUALIZER (io_1)
// ============================================================================
class IoHardwareVisualizer extends StatelessWidget {
  const IoHardwareVisualizer({super.key});

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
              Icon(Icons.input_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('System Bus & I/O Hardware Architecture', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00F0FF))),
            child: const Text('I/O Bus Components:\nCPU ➔ PCIe / System Bus ➔ I/O Controller ➔ Peripheral Devices (Keyboard, Mouse, NVMe SSD, Wi-Fi).', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 2. I/O SYSTEM CALLS VISUALIZER (io_2)
// ============================================================================
class IoSyscallsVisualizer extends StatelessWidget {
  const IoSyscallsVisualizer({super.key});

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
              Icon(Icons.terminal_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('Block vs Character Device Interfaces', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00FF66))),
            child: const Text('Device Classes:\n• Block Devices (Disks, SSDs): Read/Write fixed 512B/4KB blocks, supports random access.\n• Character Devices (Keyboards, Serial): Stream of individual bytes, no seeking.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 3. DEVICE CONTROLLERS VISUALIZER (io_3)
// ============================================================================
class DeviceControllersVisualizer extends StatefulWidget {
  const DeviceControllersVisualizer({super.key});

  @override
  State<DeviceControllersVisualizer> createState() => _DeviceControllersVisualizerState();
}

class _DeviceControllersVisualizerState extends State<DeviceControllersVisualizer> {
  bool _isBusy = false;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.settings_input_component_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(child: Text('Device Controller Registers', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
                  ],
                ),
              ),
              Switch(value: _isBusy, activeThumbColor: Colors.amber, onChanged: (val) => setState(() => _isBusy = val)),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFFB800))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status Register: ${_isBusy ? "BUSY (0x01)" : "READY (0x00)"}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _isBusy ? Colors.orange : Colors.green)),
                const SizedBox(height: 4),
                const Text('• Data-In Register: [ Input byte data ]\n• Data-Out Register: [ Output byte data ]\n• Control Register: [ Command mode bits ]', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 4. HARDWARE INTERRUPTS VISUALIZER (io_4)
// ============================================================================
class HardwareInterruptsVisualizer extends StatefulWidget {
  const HardwareInterruptsVisualizer({super.key});

  @override
  State<HardwareInterruptsVisualizer> createState() => _HardwareInterruptsVisualizerState();
}

class _HardwareInterruptsVisualizerState extends State<HardwareInterruptsVisualizer> {
  int _step = 0;

  static const List<String> _interruptCycle = [
    '1. Hardware Device asserts Interrupt Request (IRQ) line.',
    '2. CPU finishes current instruction & saves registers to Stack.',
    '3. CPU indexes Interrupt Vector Table (IVT #0x20) for handler address.',
    '4. Interrupt Service Routine (ISR) executes to handle I/O data.',
    '5. CPU restores saved state and resumes interrupted user task.',
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
              Icon(Icons.bolt_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('5-Step Hardware Interrupt Cycle', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFF007A))),
            child: Text(
              _interruptCycle[_step],
              style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: _step == 4 ? Colors.green : const Color(0xFFFF007A)),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setState(() => _step = (_step + 1) % _interruptCycle.length),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007A), foregroundColor: Colors.white),
                  child: Text(_step == 4 ? 'Resume Task 🔄' : 'Advance Interrupt Step (${_step + 1}/${_interruptCycle.length}) ➔', style: const TextStyle(fontSize: 11)),
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
// 5. DIRECT MEMORY ACCESS (DMA) VISUALIZER (io_5)
// ============================================================================
class DmaTransferVisualizer extends StatelessWidget {
  const DmaTransferVisualizer({super.key});

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
              Icon(Icons.memory_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('Direct Memory Access (DMA) Bus Master', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF00FF66))),
            child: const Text('DMA Direct Data Flow:\n[ Disk Device ] ➔ Direct DMA Bus Transfer (4MB Block) ➔ [ RAM Memory ]\n(CPU is 100% UNINTERRUPTED during transfer! Single interrupt raised ONLY on 4MB completion).', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 6. DEVICE DRIVERS VISUALIZER (io_6)
// ============================================================================
class DeviceDriversVisualizer extends StatelessWidget {
  const DeviceDriversVisualizer({super.key});

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
              Icon(Icons.handyman_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text('Device Driver Translation Software Layer', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF7000FF))),
            child: const Text('Driver Translation:\nOS VFS Standard Request `read()` ➔ NVIDIA/Realtek Driver Code ➔ Hardware Port Out Commands.', style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// Default Wrapper
class IoManagementVisualizer extends StatelessWidget {
  const IoManagementVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    return const DmaTransferVisualizer();
  }
}
