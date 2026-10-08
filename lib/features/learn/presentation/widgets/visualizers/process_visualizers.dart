import 'package:flutter/material.dart';
import 'package:os_learning_platform/core/theme/app_colors.dart';
import 'package:os_learning_platform/core/widgets/glass_container.dart';

// ============================================================================
// 1. PROCESS MEMORY STRUCTURE VISUALIZER (proc_1)
// ============================================================================
class ProcessMemoryVisualizer extends StatefulWidget {
  const ProcessMemoryVisualizer({super.key});

  @override
  State<ProcessMemoryVisualizer> createState() => _ProcessMemoryVisualizerState();
}

class _ProcessMemoryVisualizerState extends State<ProcessMemoryVisualizer> {
  int _heapSize = 2; // KB
  int _stackSize = 2; // KB
  String _lastAllocLog = 'Process initialized. Stack at high memory address, Heap at low memory address.';

  void _allocHeap() {
    setState(() {
      if (_heapSize + _stackSize < 12) {
        _heapSize += 1;
        _lastAllocLog = 'malloc(1024) -> Allocated 1KB on Heap (grows upward ⬆️).';
      } else {
        _lastAllocLog = '🚨 STACK OVERFLOW / HEAP COLLISION RISK! RAM Segment limit reached.';
      }
    });
  }

  void _pushStackFrame() {
    setState(() {
      if (_heapSize + _stackSize < 12) {
        _stackSize += 1;
        _lastAllocLog = 'func_call() -> Pushed new Activation Record frame on Stack (grows downward ⬇️).';
      } else {
        _lastAllocLog = '🚨 STACK OVERFLOW / HEAP COLLISION RISK! RAM Segment limit reached.';
      }
    });
  }

  void _resetMemory() {
    setState(() {
      _heapSize = 2;
      _stackSize = 2;
      _lastAllocLog = 'Memory reset to default 4KB allocation.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(100),
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
                    Icon(Icons.memory_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Process Memory Layout Structure in RAM',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh_rounded, size: 18),
                onPressed: _resetMemory,
                tooltip: 'Reset Memory Layout',
              ),
            ],
          ),
          const SizedBox(height: 12),

          // RAM Address Stack Visualization Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xCC08121E) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(80)),
            ),
            child: Column(
              children: [
                // Top: High Address Label
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('High Address (0x7FFF...)', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: AppColors.text2(context))),
                ),
                const SizedBox(height: 4),

                // 1. Stack Section (Grows Down)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF007A).withAlpha(40),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFF007A)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('Stack Section (Local vars, Return addrs) ⬇️', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFFFF007A))),
                      ),
                      Text('${_stackSize}KB', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                // 2. Unallocated Gap (Free Space)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: isDark ? Colors.black26 : Colors.grey.withAlpha(20),
                  child: Center(
                    child: Text(
                      '↕ Unallocated Free RAM Gap (${12 - _heapSize - _stackSize}KB remaining)',
                      style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: AppColors.text2(context)),
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                // 3. Heap Section (Grows Up)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00FF66).withAlpha(40),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF00FF66)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('Heap Section (malloc / new dynamic memory) ⬆️', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF00FF66))),
                      ),
                      Text('${_heapSize}KB', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                // 4. Data Section (Globals)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB800).withAlpha(30),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFFFB800)),
                  ),
                  child: const Text('Data Section (Global & Static Variables: int count = 0)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),

                const SizedBox(height: 4),

                // 5. Text Section (Code)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00F0FF).withAlpha(30),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFF00F0FF)),
                  ),
                  child: const Text('Text Section (Compiled Assembly Code Instructions)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),

                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Low Address (0x0000...)', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: AppColors.text2(context))),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Interactive Allocation Controls
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _allocHeap,
                  icon: const Icon(Icons.add_rounded, size: 16),
                  label: const Text('malloc() (Expand Heap)', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00FF66),
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _pushStackFrame,
                  icon: const Icon(Icons.arrow_downward_rounded, size: 16),
                  label: const Text('func_call() (Push Stack)', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF007A),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Console Log Output
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xCC08121E) : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _lastAllocLog.contains('OVERFLOW') ? Colors.red : Colors.grey.withAlpha(80)),
            ),
            child: Text(
              _lastAllocLog,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: _lastAllocLog.contains('OVERFLOW') ? Colors.redAccent : AppColors.text1(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 2. PROCESS STATE MACHINE VISUALIZER (proc_2)
// ============================================================================
class ProcessStateVisualizer extends StatefulWidget {
  const ProcessStateVisualizer({super.key});

  @override
  State<ProcessStateVisualizer> createState() => _ProcessStateVisualizerState();
}

class _ProcessStateVisualizerState extends State<ProcessStateVisualizer> {
  int _currentStateIndex = 0;
  List<String> _processQueue = ['P1'];

  void _addProcess() {
    setState(() {
      final nextId = 'P${_processQueue.length + 1}';
      _processQueue.add(nextId);
      _currentStateIndex = 0;
    });
  }

  static const List<Map<String, String>> _states = [
    {'name': 'NEW', 'desc': 'Process is being created in memory.'},
    {'name': 'READY', 'desc': 'Process is in RAM queue, waiting for CPU assignment.'},
    {'name': 'RUNNING', 'desc': 'CPU is executing process instructions.'},
    {'name': 'WAITING', 'desc': 'Process is blocked, waiting for I/O completion or event.'},
    {'name': 'READY', 'desc': 'I/O completed, process returned to Ready queue.'},
    {'name': 'RUNNING', 'desc': 'CPU resumed process execution.'},
    {'name': 'TERMINATED', 'desc': 'Process completed execution. OS reclaims RAM.'},
  ];

  void _nextState() {
    setState(() {
      _currentStateIndex = (_currentStateIndex + 1) % _states.length;
    });
  }

  void _reset() {
    setState(() {
      _currentStateIndex = 0;
      _processQueue = ['P1'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final current = _states[_currentStateIndex];
    final activeStateName = current['name']!;
    final activeProc = _processQueue.last;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(100),
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
                    Icon(Icons.alt_route_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Interactive Process State Machine',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    onPressed: _reset,
                    tooltip: 'Reset State Machine',
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(40),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Step ${_currentStateIndex + 1}/${_states.length}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Processes Queue Display
          Row(
            children: [
              Text('Active Process: ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.text1(context))),
              Chip(
                label: Text(activeProc, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                backgroundColor: isDark ? AppColors.neonCyan.withAlpha(50) : AppColors.iconPrimaryLight.withAlpha(30),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // State Machine Nodes Grid
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['NEW', 'READY', 'RUNNING', 'WAITING', 'TERMINATED'].map((sName) {
              final isCurrent = sName == activeStateName;
              Color nodeColor = Colors.grey;
              if (sName == 'NEW') nodeColor = Colors.blue;
              if (sName == 'READY') nodeColor = Colors.orange;
              if (sName == 'RUNNING') nodeColor = Colors.green;
              if (sName == 'WAITING') nodeColor = Colors.red;
              if (sName == 'TERMINATED') nodeColor = Colors.purple;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isCurrent ? nodeColor : (isDark ? const Color(0x1F000000) : Colors.white),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: nodeColor, width: isCurrent ? 2 : 1),
                  boxShadow: isCurrent ? [BoxShadow(color: nodeColor.withAlpha(100), blurRadius: 10)] : [],
                ),
                child: Text(
                  sName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: isCurrent ? Colors.white : AppColors.text1(context),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 14),

          // Current State Description Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xCC08121E) : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Current State: ${current['name']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.text1(context))),
                const SizedBox(height: 4),
                Text(current['desc']!, style: TextStyle(fontSize: 12, color: AppColors.text2(context))),
              ],
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _nextState,
                  icon: const Icon(Icons.play_arrow_rounded, size: 18),
                  label: const Text('Transition State ➔', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight,
                    foregroundColor: isDark ? Colors.black : Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: _addProcess,
                child: const Text('+ New Process', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 3. PCB STRUCTURE INSPECTOR (proc_3)
// ============================================================================
class PcbVisualizer extends StatefulWidget {
  const PcbVisualizer({super.key});

  @override
  State<PcbVisualizer> createState() => _PcbVisualizerState();
}

class _PcbVisualizerState extends State<PcbVisualizer> {
  final int _pid = 1042;
  String _state = 'RUNNING';
  int _pc = 0x00401020;
  int _sp = 0x7FFF0040;

  void _stepInstruction() {
    setState(() {
      _pc += 4;
      _sp -= 8;
    });
  }

  void _toggleState() {
    setState(() {
      if (_state == 'RUNNING') {
        _state = 'WAITING (I/O)';
      } else if (_state == 'WAITING (I/O)') {
        _state = 'READY';
      } else {
        _state = 'RUNNING';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(100),
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
                    Icon(Icons.badge_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Process Control Block (PCB) Inspector',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.neonPurple.withAlpha(40) : AppColors.iconActiveLight.withAlpha(30),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('Kernel RAM: task_struct', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Table of PCB Fields
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xCC08121E) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(60)),
            ),
            child: Column(
              children: [
                _buildPcbRow('Process ID (PID)', '$_pid', context),
                _buildPcbRow('Process State', _state, context, isBadge: true),
                _buildPcbRow('Program Counter (PC)', '0x${_pc.toRadixString(16).toUpperCase()}', context),
                _buildPcbRow('Stack Pointer (SP)', '0x${_sp.toRadixString(16).toUpperCase()}', context),
                _buildPcbRow('CPU Registers', 'EAX: 0x05 | EBX: 0x1A | ECX: 0x00', context),
                _buildPcbRow('Memory Limits', 'Base: 0x100000 | Limit: 0x400000', context),
                _buildPcbRow('Open File Descriptors', 'fd[0]: stdin | fd[1]: stdout | fd[2]: stderr', context),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _stepInstruction,
                  icon: const Icon(Icons.redo_rounded, size: 16),
                  label: const Text('Exec Inst (PC += 4)', style: TextStyle(fontSize: 11)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _toggleState,
                  icon: const Icon(Icons.swap_horiz_rounded, size: 16),
                  label: const Text('Toggle State', style: TextStyle(fontSize: 11)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPcbRow(String key, String val, BuildContext context, {bool isBadge = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(key, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.text2(context))),
          if (isBadge)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.orange.withAlpha(40), borderRadius: BorderRadius.circular(4)),
              child: Text(val, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orange)),
            )
          else
            Text(val, style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.w600, color: AppColors.text1(context))),
        ],
      ),
    );
  }
}

// ============================================================================
// 4. CONTEXT SWITCH VISUALIZER (proc_4)
// ============================================================================
class ContextSwitchVisualizer extends StatefulWidget {
  const ContextSwitchVisualizer({super.key});

  @override
  State<ContextSwitchVisualizer> createState() => _ContextSwitchVisualizerState();
}

class _ContextSwitchVisualizerState extends State<ContextSwitchVisualizer> {
  int _activeProc = 1; // 1: P1, 2: P2
  bool _isSwitching = false;
  int _switchCount = 0;

  void _triggerContextSwitch() {
    if (_isSwitching) return;
    setState(() {
      _isSwitching = true;
      _switchCount++;
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _activeProc = _activeProc == 1 ? 2 : 1;
          _isSwitching = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(100),
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
                    Icon(Icons.published_with_changes_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'CPU Context Switch Overhead Simulator',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.purple.withAlpha(40), borderRadius: BorderRadius.circular(6)),
                child: Text('Switches: $_switchCount', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.purple)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Dual CPU Process Display
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _activeProc == 1 && !_isSwitching ? Colors.green.withAlpha(30) : (isDark ? Colors.black26 : Colors.white),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _activeProc == 1 && !_isSwitching ? Colors.green : Colors.grey.withAlpha(60), width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Text('Process P1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.text1(context))),
                      const SizedBox(height: 4),
                      Text(_activeProc == 1 && !_isSwitching ? '⚡ RUNNING ON CPU' : '⏸ IDLE (State in PCB 1)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _activeProc == 2 && !_isSwitching ? Colors.blue.withAlpha(30) : (isDark ? Colors.black26 : Colors.white),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _activeProc == 2 && !_isSwitching ? Colors.blue : Colors.grey.withAlpha(60), width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Text('Process P2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.text1(context))),
                      const SizedBox(height: 4),
                      Text(_activeProc == 2 && !_isSwitching ? '⚡ RUNNING ON CPU' : '⏸ IDLE (State in PCB 2)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: _isSwitching ? Colors.orange : (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(80))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CPU Hardware State:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.text1(context))),
                const SizedBox(height: 4),
                Text(
                  _isSwitching
                      ? '🔄 CONTEXT SWITCH IN PROGRESS...\n1. Save registers to PCB $_activeProc\n2. Flush L1 Cache & TLB entries\n3. Load PC & registers from PCB ${3 - _activeProc}'
                      : '⚡ CPU executing Process P$_activeProc at full speed.',
                  style: TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold, color: _isSwitching ? Colors.orange : Colors.green),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isSwitching ? null : _triggerContextSwitch,
              icon: const Icon(Icons.sync_rounded, size: 18),
              label: Text(_isSwitching ? 'Context Switching...' : 'Trigger CPU Context Switch (P1 ↔ P2)'),
              style: ElevatedButton.styleFrom(backgroundColor: isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight, foregroundColor: isDark ? Colors.black : Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 5. MULTITHREADED MEMORY VISUALIZER (proc_5)
// ============================================================================
class ThreadMemoryVisualizer extends StatefulWidget {
  const ThreadMemoryVisualizer({super.key});

  @override
  State<ThreadMemoryVisualizer> createState() => _ThreadMemoryVisualizerState();
}

class _ThreadMemoryVisualizerState extends State<ThreadMemoryVisualizer> {
  int _threadCount = 3;

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
                    Icon(Icons.account_tree_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Multi-threaded Memory Sharing Structure',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(icon: const Icon(Icons.remove_circle_outline, size: 18), onPressed: () { if (_threadCount > 1) setState(() => _threadCount--); }),
                  Text('Threads: $_threadCount', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  IconButton(icon: const Icon(Icons.add_circle_outline, size: 18), onPressed: () { if (_threadCount < 4) setState(() => _threadCount++); }),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Shared Memory Block
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.green.withAlpha(30), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.green)),
            child: const Text('SHARED MEMORY (All threads in Process access directly):\n[ Code Text Section | Global Data Section | Heap Allocation ]', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
          ),

          const SizedBox(height: 10),

          // Private Stacks Row
          Row(
            children: List.generate(_threadCount, (idx) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.purple.withAlpha(30), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.purple)),
                  child: Column(
                    children: [
                      Text('Thread T${idx + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.purple)),
                      const SizedBox(height: 4),
                      const Text('PRIVATE:\n• Stack\n• Registers\n• PC', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 6. MULTITHREADING MODELS VISUALIZER (proc_6)
// ============================================================================
class MultithreadingModelsVisualizer extends StatefulWidget {
  const MultithreadingModelsVisualizer({super.key});

  @override
  State<MultithreadingModelsVisualizer> createState() => _MultithreadingModelsVisualizerState();
}

class _MultithreadingModelsVisualizerState extends State<MultithreadingModelsVisualizer> {
  int _modelIdx = 1; // 0: Many-to-One, 1: One-to-One, 2: Many-to-Many

  static const List<Map<String, String>> _models = [
    {'name': 'Many-to-One', 'desc': 'Many User Threads map to 1 Kernel Thread. Blocked user thread blocks ALL threads! Cannot run parallel on multi-core CPU.'},
    {'name': 'One-to-One', 'desc': 'Each User Thread maps to 1 Kernel Thread (Standard in Linux/Windows). Full multi-core concurrency; non-blocking.'},
    {'name': 'Many-to-Many', 'desc': 'Multiplexes M User Threads over N Kernel Threads. Best flexibility and non-blocking performance.'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final current = _models[_modelIdx];

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: const Color(0xFFFFB800).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.hub_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Multithreading Mapping Models Simulator', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: List.generate(_models.length, (idx) {
              final isSel = idx == _modelIdx;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: ElevatedButton(
                    onPressed: () => setState(() => _modelIdx = idx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSel ? const Color(0xFFFFB800) : (isDark ? const Color(0x1F000000) : Colors.white),
                      foregroundColor: isSel ? Colors.black : AppColors.text1(context),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    child: Text(_models[idx]['name']!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFFFB800))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(current['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFFFFB800))),
                const SizedBox(height: 4),
                Text(current['desc']!, style: TextStyle(fontSize: 11, color: AppColors.text2(context), height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 7. IPC MECHANISMS VISUALIZER (proc_7)
// ============================================================================
class IpcVisualizer extends StatefulWidget {
  const IpcVisualizer({super.key});

  @override
  State<IpcVisualizer> createState() => _IpcVisualizerState();
}

class _IpcVisualizerState extends State<IpcVisualizer> {
  bool _isSharedMemory = true;

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
              Icon(Icons.swap_calls_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text('IPC: Shared Memory vs Message Passing', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setState(() => _isSharedMemory = true),
                  style: ElevatedButton.styleFrom(backgroundColor: _isSharedMemory ? const Color(0xFF00FF66) : Colors.grey.withAlpha(40), foregroundColor: Colors.black),
                  child: const Text('Shared Memory (Fast RAM)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setState(() => _isSharedMemory = false),
                  style: ElevatedButton.styleFrom(backgroundColor: !_isSharedMemory ? const Color(0xFF00F0FF) : Colors.grey.withAlpha(40), foregroundColor: Colors.black),
                  child: const Text('Message Passing (Kernel)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: _isSharedMemory ? const Color(0xFF00FF66) : const Color(0xFF00F0FF))),
            child: Text(
              _isSharedMemory
                  ? 'Shared Memory Model:\n[ Process A ] ➔ Read/Write Direct ➔ [ Shared RAM Region ] ⬅ Read/Write Direct ⬅ [ Process B ]\n(Bypasses kernel after setup. Fast memory speed! Requires user synchronization).'
                  : 'Message Passing Model:\n[ Process A ] ➔ send(msg) ➔ [ OS Kernel Queue ] ➔ recv(msg) ➔ [ Process B ]\n(Kernel handles synchronization. Safe for distributed network nodes).',
              style: const TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 8. RACE CONDITION & GUARD VISUALIZER (proc_8)
// ============================================================================
class SyncIntroVisualizer extends StatefulWidget {
  const SyncIntroVisualizer({super.key});

  @override
  State<SyncIntroVisualizer> createState() => _SyncIntroVisualizerState();
}

class _SyncIntroVisualizerState extends State<SyncIntroVisualizer> {
  int _counter = 0;
  bool _useGuard = false;
  String _log = 'Click "Run Concurrent Increments" to test data consistency.';

  void _runConcurrentIncrements() {
    if (_useGuard) {
      setState(() {
        _counter += 2;
        _log = '✓ MUTEX GUARD ENABLED: Thread A and B incremented atomically. Counter = $_counter (Correct!).';
      });
    } else {
      setState(() {
        _counter += 1; // Simulated lost increment
        _log = '🚨 RACE CONDITION DETECTED! Thread A and B read same value (counter was overwritten). Counter = $_counter (Data Loss!).';
      });
    }
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.sync_problem_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Race Condition Guard Simulator', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight)),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _useGuard,
                activeThumbColor: const Color(0xFF00FF66),
                onChanged: (val) => setState(() => _useGuard = val),
              ),
            ],
          ),
          Text(_useGuard ? 'Guard Mode: Mutex Lock ON' : 'Guard Mode: Unprotected Naked Counter', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _useGuard ? Colors.green : Colors.red)),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDark ? const Color(0xCC08121E) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: _log.contains('RACE') ? Colors.red : Colors.green)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shared Counter Value: $_counter', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(_log, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: _log.contains('RACE') ? Colors.redAccent : Colors.green)),
              ],
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _runConcurrentIncrements,
              icon: const Icon(Icons.flash_on_rounded, size: 18),
              label: const Text('Run Concurrent Increments (Thread A + B)'),
              style: ElevatedButton.styleFrom(backgroundColor: isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight, foregroundColor: isDark ? Colors.black : Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
