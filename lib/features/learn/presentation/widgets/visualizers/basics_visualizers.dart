import 'package:flutter/material.dart';
import 'package:os_learning_platform/core/theme/app_colors.dart';
import 'package:os_learning_platform/core/widgets/glass_container.dart';

// ============================================================================
// 1. WHAT IS AN OS VISUALIZER (bas_1)
// ============================================================================
class OsArchitectureVisualizer extends StatefulWidget {
  const OsArchitectureVisualizer({super.key});

  @override
  State<OsArchitectureVisualizer> createState() => _OsArchitectureVisualizerState();
}

class _OsArchitectureVisualizerState extends State<OsArchitectureVisualizer> {
  int _activeLayerIndex = 0;

  static const List<Map<String, dynamic>> _layers = [
    {
      'title': 'User / Application Layer',
      'icon': Icons.apps_rounded,
      'color': Color(0xFF00F0FF),
      'details': 'Web Browsers, Text Editors, Games, User Applications.',
      'action': 'Sends high-level request (e.g. read file "doc.txt").'
    },
    {
      'title': 'System Call API Gateway',
      'icon': Icons.vpn_key_rounded,
      'color': Color(0xFFFF007A),
      'details': 'POSIX / Win32 API Library interface wrappers.',
      'action': 'Traps to Kernel Mode (flips Mode Bit from 1 to 0).'
    },
    {
      'title': 'Operating System Kernel Core',
      'icon': Icons.memory_rounded,
      'color': Color(0xFF7000FF),
      'details': 'Process Manager, Virtual Memory Engine, File System, Scheduler.',
      'action': 'Executes privileged code & coordinates hardware safety.'
    },
    {
      'title': 'Device Driver Layer',
      'icon': Icons.settings_input_component_rounded,
      'color': Color(0xFFFFB800),
      'details': 'NVMe Controller, Display Driver, Network Adapter Drivers.',
      'action': 'Translates OS command to hardware register instructions.'
    },
    {
      'title': 'Computer Physical Hardware',
      'icon': Icons.developer_board_rounded,
      'color': Color(0xFF00FF66),
      'details': 'CPU Cores, RAM Chips, SSD Sectors, Network Interfaces.',
      'action': 'Performs physical electrical signals and data transfer.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final current = _layers[_activeLayerIndex];

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.layers_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Interactive OS Architecture Layer Stack',
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
          Text(
            'Tap any layer to simulate how user requests route down through hardware abstraction:',
            style: TextStyle(fontSize: 12, color: AppColors.text2(context)),
          ),
          const SizedBox(height: 14),

          // Stack of 5 Layers
          Column(
            children: List.generate(_layers.length, (index) {
              final layer = _layers[index];
              final isSelected = index == _activeLayerIndex;
              final color = layer['color'] as Color;

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  onTap: () => setState(() => _activeLayerIndex = index),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? color.withAlpha(isDark ? 50 : 35) : (isDark ? const Color(0x1F000000) : Colors.white),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? color : (isDark ? Colors.white12 : Colors.black12),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(layer['icon'] as IconData, color: color, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            layer['title'] as String,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: AppColors.text1(context),
                            ),
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.arrow_forward_ios_rounded, color: color, size: 14),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 14),

          // Active Layer Details Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (current['color'] as Color).withAlpha(isDark ? 30 : 20),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: current['color'] as Color, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(current['icon'] as IconData, color: current['color'] as Color, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        current['title'] as String,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: current['color'] as Color),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Components: ${current['details']}',
                  style: TextStyle(fontSize: 12, color: AppColors.text1(context)),
                ),
                const SizedBox(height: 4),
                Text(
                  'Hardware Abstraction Action: ${current['action']}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isDark ? AppColors.neonGold : Colors.brown),
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
// 2. FUNCTIONS OF OS VISUALIZER (bas_2)
// ============================================================================
class OsFunctionsVisualizer extends StatefulWidget {
  const OsFunctionsVisualizer({super.key});

  @override
  State<OsFunctionsVisualizer> createState() => _OsFunctionsVisualizerState();
}

class _OsFunctionsVisualizerState extends State<OsFunctionsVisualizer> {
  String _selectedFunc = 'cpu';

  static const Map<String, Map<String, dynamic>> _funcData = {
    'cpu': {
      'title': 'Processor Management',
      'icon': Icons.speed_rounded,
      'color': Color(0xFF7000FF),
      'desc': 'Allocates CPU time slices to multiple active processes using scheduling algorithms (FCFS, Round Robin, SJF).',
      'metrics': ['CPU Utilization: 98%', 'Active Tasks: 4 Processes', 'Current Quantum: 4ms'],
      'diagram': 'CPU Core ➔ [ P1 (4ms) ] ➔ [ P2 (4ms) ] ➔ [ P3 (4ms) ]'
    },
    'memory': {
      'title': 'Memory Management',
      'icon': Icons.grid_view_rounded,
      'color': Color(0xFF00FF66),
      'desc': 'Tracks every byte of primary RAM. Allocates & reclaims memory blocks while preventing illegal memory access.',
      'metrics': ['RAM Total: 16 GB', 'Used: 6.4 GB', 'Free: 9.6 GB', 'Paging: Active'],
      'diagram': 'RAM [ OS Kernel (2GB) | App P1 (2GB) | App P2 (2.4GB) | Free (9.6GB) ]'
    },
    'file': {
      'title': 'File System Management',
      'icon': Icons.folder_copy_rounded,
      'color': Color(0xFFFF007A),
      'desc': 'Organizes persistent files into directory trees. Controls file creation, deletion, access permissions, and disk block allocations.',
      'metrics': ['Mounted: /dev/nvme0n1p2', 'Type: ext4', 'Inodes Used: 245,102'],
      'diagram': 'Root (/) ➔ /home ➔ /user ➔ doc.pdf (Inode #84912)'
    },
    'device': {
      'title': 'Device Management',
      'icon': Icons.tune_rounded,
      'color': Color(0xFF00F0FF),
      'desc': 'Manages communication with hardware peripherals via device drivers, I/O buffering, spooling, and DMA controllers.',
      'metrics': ['Connected: GPU, NVMe, Wi-Fi', 'Buffer Status: Clean', 'Interrupt Vector: 0x20'],
      'diagram': 'App ➔ OS Device Driver ➔ Status Register (READY) ➔ DMA ➔ RAM'
    },
    'security': {
      'title': 'Protection & Security',
      'icon': Icons.security_rounded,
      'color': Color(0xFFFFB800),
      'desc': 'Ensures user programs cannot overwrite OS memory or read unauthorized files using Dual-Mode bits and Access Control Lists.',
      'metrics': ['Mode Bit: 1 (User)', 'Memory Boundary: Limit Check PASS', 'Access Rules: R/W'],
      'diagram': 'User Request ➔ ACL Verification ➔ Granted / Denied (Security Trap)'
    },
  };

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final current = _funcData[_selectedFunc]!;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (current['color'] as Color).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.dashboard_customize_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '5 Core Functions of Operating System',
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

          // Category Chips Row
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _funcData.entries.map((e) {
              final isSel = e.key == _selectedFunc;
              final col = e.value['color'] as Color;

              return ChoiceChip(
                showCheckmark: false,
                avatar: Icon(e.value['icon'] as IconData, size: 16, color: isSel ? Colors.black : col),
                label: Text(
                  e.value['title'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isSel ? Colors.black : AppColors.text1(context),
                  ),
                ),
                selected: isSel,
                selectedColor: col,
                backgroundColor: isDark ? const Color(0x1F000000) : Colors.white,
                onSelected: (_) => setState(() => _selectedFunc = e.key),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // Detail Display Box
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: (current['color'] as Color).withAlpha(isDark ? 30 : 20),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: current['color'] as Color, width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  current['title'] as String,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: current['color'] as Color),
                ),
                const SizedBox(height: 6),
                Text(
                  current['desc'] as String,
                  style: TextStyle(fontSize: 12, color: AppColors.text1(context), height: 1.4),
                ),
                const SizedBox(height: 12),
                Text(
                  'Live OS Metrics:',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.text2(context)),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: (current['metrics'] as List<String>).map((m) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.black45 : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: (current['color'] as Color).withAlpha(80)),
                      ),
                      child: Text(m, style: TextStyle(fontSize: 11, color: AppColors.text1(context))),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xCC08121E) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Execution Flow Diagram:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: current['color'] as Color)),
                      const SizedBox(height: 4),
                      Text(current['diagram'] as String, style: const TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.w600)),
                    ],
                  ),
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
// 3. TYPES OF OS VISUALIZER (bas_3)
// ============================================================================
class OsTypesVisualizer extends StatefulWidget {
  const OsTypesVisualizer({super.key});

  @override
  State<OsTypesVisualizer> createState() => _OsTypesVisualizerState();
}

class _OsTypesVisualizerState extends State<OsTypesVisualizer> {
  int _typeIndex = 1; // 0: Batch, 1: Time-Sharing, 2: Hard RTOS, 3: Distributed

  static const List<Map<String, dynamic>> _types = [
    {
      'name': 'Batch OS',
      'goal': 'Maximize CPU Throughput',
      'response': 'Hours / Days',
      'example': 'Mainframe Payroll Processing',
      'icon': Icons.dataset_rounded,
      'color': Color(0xFFFFB800),
      'mechanism': 'Jobs with similar requirements are grouped into batches and processed sequentially without human intervention.',
      'timeline': ['Batch Queue ➔', 'Job 1', 'Job 2', 'Job 3', '➔ CPU Execution']
    },
    {
      'name': 'Time-Sharing OS',
      'goal': 'Minimize User Response Time',
      'response': 'Milliseconds (Interactive)',
      'example': 'Linux Desktop, macOS, Windows 11',
      'icon': Icons.shutter_speed_rounded,
      'color': Color(0xFF00F0FF),
      'mechanism': 'CPU switches rapidly among multiple interactive user processes using fixed Time Quanta (e.g., 10ms).',
      'timeline': ['User 1 (10ms)', 'User 2 (10ms)', 'User 3 (10ms)', 'User 1 (10ms)']
    },
    {
      'name': 'Hard Real-Time OS (RTOS)',
      'goal': 'Guarantee Rigid Time Deadlines',
      'response': 'Microseconds (Strict)',
      'example': 'Flight Control, Cardiac Pacemaker, Automotive ECU',
      'icon': Icons.timer_rounded,
      'color': Color(0xFFFF007A),
      'mechanism': 'Critical tasks MUST complete within strict deadline boundaries. Missing a deadline causes fatal system failure.',
      'timeline': ['Interrupt Event ➔', 'Immediate Preemption ➔', 'Execution <= 50µs ➔', 'Deadline MET']
    },
    {
      'name': 'Distributed OS',
      'goal': 'Computation Speedup & Scalability',
      'response': 'Variable Network Latency',
      'example': 'Google Cloud Cluster, Apache Spark Grid',
      'icon': Icons.hub_rounded,
      'color': Color(0xFF00FF66),
      'mechanism': 'Manages a collection of independent physical nodes, presenting them to users as a single unified supercomputer.',
      'timeline': ['Client Task ➔', 'Master Allocator ➔', 'Node A (Sub-task)', 'Node B (Sub-task)', '➔ Aggregated Result']
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final current = _types[_typeIndex];
    final color = current['color'] as Color;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: color.withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.category_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Text(
                'Operating System Types Simulator',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Selector Tabs
          Row(
            children: List.generate(_types.length, (idx) {
              final isSel = idx == _typeIndex;
              final itemColor = _types[idx]['color'] as Color;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: ElevatedButton(
                    onPressed: () => setState(() => _typeIndex = idx),
                    style: ElevatedButton.styleFrom(
                      elevation: isSel ? 4 : 0,
                      backgroundColor: isSel ? itemColor : (isDark ? const Color(0x1F000000) : Colors.white),
                      foregroundColor: isSel ? Colors.black : AppColors.text1(context),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      _types[idx]['name'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 16),

          // Active Details Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withAlpha(isDark ? 30 : 20),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color, width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(current['icon'] as IconData, color: color, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              current['name'] as String,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
                      child: Text('Resp: ${current['response']}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Primary Goal: ${current['goal']}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.text1(context))),
                Text('Real Example: ${current['example']}', style: TextStyle(fontSize: 12, color: AppColors.text2(context))),
                const SizedBox(height: 10),
                Text(current['mechanism'] as String, style: TextStyle(fontSize: 12, height: 1.4, color: AppColors.text1(context))),
                const SizedBox(height: 12),
                Text('Execution Workflow Sequence:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
                const SizedBox(height: 6),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: (current['timeline'] as List<String>).map((step) {
                      return Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xCC08121E) : Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: color.withAlpha(80)),
                        ),
                        child: Text(step, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.text1(context))),
                      );
                    }).toList(),
                  ),
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
// 4. OS SERVICES VISUALIZER (bas_4)
// ============================================================================
class OsServicesVisualizer extends StatefulWidget {
  const OsServicesVisualizer({super.key});

  @override
  State<OsServicesVisualizer> createState() => _OsServicesVisualizerState();
}

class _OsServicesVisualizerState extends State<OsServicesVisualizer> {
  bool _isUserConvenience = true;

  static const List<Map<String, String>> _userServices = [
    {'title': 'User Interface (UI)', 'desc': 'CLI Shell, GUI Desktop, Touch Screen interfaces.'},
    {'title': 'Program Execution', 'desc': 'Loads binary files into RAM and executes instructions.'},
    {'title': 'I/O Operations', 'desc': 'Handles reading/writing for storage, network, and displays.'},
    {'title': 'File-System Manipulation', 'desc': 'Directories, read/write/seek permissions, and deletion.'},
    {'title': 'Communications', 'desc': 'Inter-process shared memory and message passing.'},
    {'title': 'Error Detection', 'desc': 'Monitors CPU faults, parity checks, and disk read errors.'},
  ];

  static const List<Map<String, String>> _systemServices = [
    {'title': 'Resource Allocation', 'desc': 'Schedules CPU cycles, allocates memory, and manages disk queues.'},
    {'title': 'Accounting', 'desc': 'Tracks resource usage statistics per user and process.'},
    {'title': 'Protection & Security', 'desc': 'Prevents process memory corruption and unauthorized access.'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final activeList = _isUserConvenience ? _userServices : _systemServices;
    final accent = _isUserConvenience ? const Color(0xFF00F0FF) : const Color(0xFFFFB800);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: accent.withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.home_repair_service_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Text(
                'OS Services Dual Taxonomy',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Toggle Switcher
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => setState(() => _isUserConvenience = true),
                  icon: const Icon(Icons.person_rounded, size: 16),
                  label: const Text('User Convenience (6)', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isUserConvenience ? const Color(0xFF00F0FF) : (isDark ? const Color(0x1F000000) : Colors.white),
                    foregroundColor: _isUserConvenience ? Colors.black : AppColors.text1(context),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => setState(() => _isUserConvenience = false),
                  icon: const Icon(Icons.shield_rounded, size: 16),
                  label: const Text('System Efficiency (3)', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !_isUserConvenience ? const Color(0xFFFFB800) : (isDark ? const Color(0x1F000000) : Colors.white),
                    foregroundColor: !_isUserConvenience ? Colors.black : AppColors.text1(context),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Cards List
          Column(
            children: activeList.map((item) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xCC08121E) : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: accent.withAlpha(60)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_rounded, color: accent, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['title']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.text1(context))),
                          const SizedBox(height: 2),
                          Text(item['desc']!, style: TextStyle(fontSize: 11, color: AppColors.text2(context))),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 5. SYSTEM CALLS VISUALIZER (bas_5)
// ============================================================================
class SystemCallVisualizer extends StatefulWidget {
  const SystemCallVisualizer({super.key});

  @override
  State<SystemCallVisualizer> createState() => _SystemCallVisualizerState();
}

class _SystemCallVisualizerState extends State<SystemCallVisualizer> {
  int _stepIndex = 0;

  static const List<Map<String, String>> _steps = [
    {
      'title': '1. User Application Invoke',
      'mode': 'User Mode (Mode Bit = 1)',
      'desc': 'C Program calls standard library API function `open("file.txt", O_RDONLY)`.',
      'icon': '💻'
    },
    {
      'title': '2. Software Trap Exception',
      'mode': 'Mode Transition 1 ➔ 0',
      'desc': 'API library executes trap instruction `int 0x80` or `syscall`. Mode Bit flips from 1 (User) to 0 (Kernel).',
      'icon': '⚡'
    },
    {
      'title': '3. System Call Table Lookup',
      'mode': 'Kernel Mode (Mode Bit = 0)',
      'desc': 'Kernel System Call Interface (SCI) indexes system table for syscall #5 (`sys_open`).',
      'icon': '📑'
    },
    {
      'title': '4. Kernel Driver Hardware Exec',
      'mode': 'Kernel Mode (Mode Bit = 0)',
      'desc': 'Kernel executes privileged disk read command and retrieves file block from NVMe SSD.',
      'icon': '⚙️'
    },
    {
      'title': '5. Return & Mode Reset',
      'mode': 'Mode Transition 0 ➔ 1',
      'desc': 'File descriptor int returned to application. CPU Mode Bit resets back to 1 (User Mode).',
      'icon': '🔄'
    },
  ];

  void _nextStep() {
    setState(() => _stepIndex = (_stepIndex + 1) % _steps.length);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final current = _steps[_stepIndex];
    final isKernelMode = current['mode']!.contains('Kernel Mode') || current['mode']!.contains('1 ➔ 0');

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (isKernelMode ? const Color(0xFFFF007A) : const Color(0xFF00F0FF)).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Icon(Icons.terminal_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'System Call Execution Lifecycle',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (isKernelMode ? const Color(0xFFFF007A) : const Color(0xFF00F0FF)).withAlpha(40),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      current['mode']!,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isKernelMode ? const Color(0xFFFF007A) : const Color(0xFF00F0FF),
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Lifecycle Box
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xCC08121E) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isKernelMode ? const Color(0xFFFF007A) : const Color(0xFF00F0FF),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(current['icon']!, style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        current['title']!,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.text1(context)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  current['desc']!,
                  style: TextStyle(fontSize: 12, height: 1.4, color: AppColors.text2(context)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Action Stepper Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _nextStep,
              icon: const Icon(Icons.play_arrow_rounded, size: 18),
              label: Text('Next Step (${_stepIndex + 1}/${_steps.length})'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight,
                foregroundColor: isDark ? Colors.black : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 6. KERNEL ARCHITECTURE VISUALIZER (bas_6)
// ============================================================================
class KernelArchVisualizer extends StatefulWidget {
  const KernelArchVisualizer({super.key});

  @override
  State<KernelArchVisualizer> createState() => _KernelArchVisualizerState();
}

class _KernelArchVisualizerState extends State<KernelArchVisualizer> {
  bool _isMonolithic = true;

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (_isMonolithic ? const Color(0xFF7000FF) : const Color(0xFF00FF66)).withAlpha(100),
      color: isDark ? const Color(0x2B00F0FF) : const Color(0xFFF0F5FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.architecture_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
              const SizedBox(width: 8),
              Text(
                'Monolithic vs Microkernel Architecture',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Toggle Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setState(() => _isMonolithic = true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isMonolithic ? const Color(0xFF7000FF) : (isDark ? const Color(0x1F000000) : Colors.white),
                    foregroundColor: _isMonolithic ? Colors.white : AppColors.text1(context),
                  ),
                  child: const Text('Monolithic (Linux/Windows)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setState(() => _isMonolithic = false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !_isMonolithic ? const Color(0xFF00FF66) : (isDark ? const Color(0x1F000000) : Colors.white),
                    foregroundColor: !_isMonolithic ? Colors.black : AppColors.text1(context),
                  ),
                  child: const Text('Microkernel (Minix/seL4)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Architecture Visualization Box
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xCC08121E) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isMonolithic ? const Color(0xFF7000FF) : const Color(0xFF00FF66),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isMonolithic ? 'Monolithic Kernel Space (Single Unified Address Space)' : 'Microkernel Space (Minimal IPC Core)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: _isMonolithic ? const Color(0xFF7000FF) : const Color(0xFF00FF66),
                  ),
                ),
                const SizedBox(height: 10),

                if (_isMonolithic) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7000FF).withAlpha(30),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF7000FF)),
                    ),
                    child: const Text(
                      'KERNEL SPACE (Mode Bit = 0):\n[ VFS File System | Scheduler | Memory Mgmt | IPC | Device Drivers ]\n(All run in 1 shared memory space ➔ Fast execution, but driver bug can crash entire OS!)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4),
                    ),
                  ),
                ] else ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: const Text(
                      'USER SPACE (Mode Bit = 1):\n[ File Server ]  [ Device Drivers ]  [ User Apps ]',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00FF66).withAlpha(30),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF00FF66)),
                    ),
                    child: const Text(
                      'MINIMAL KERNEL SPACE (Mode Bit = 0):\n[ IPC Messaging | Memory Paging | CPU Scheduling ]\n(Driver crash only restarts user-space driver server ➔ High Fault Isolation!)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, fontFamily: 'monospace', height: 1.4),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 7. DUAL MODE VISUALIZER (bas_7)
// ============================================================================
class DualModeVisualizer extends StatefulWidget {
  const DualModeVisualizer({super.key});

  @override
  State<DualModeVisualizer> createState() => _DualModeVisualizerState();
}

class _DualModeVisualizerState extends State<DualModeVisualizer> {
  int _modeBit = 1; // 1: User Mode, 0: Kernel Mode
  String _lastLog = 'Ready. Click a command to test execution privilege.';

  void _execCmd(String cmd, bool isPrivileged) {
    setState(() {
      if (_modeBit == 1 && isPrivileged) {
        _lastLog = '🚨 HARDWARE PRIVILEGE TRAP FAULT! Cannot execute "$cmd" in User Mode (Mode Bit = 1).';
      } else if (_modeBit == 1 && !isPrivileged) {
        _lastLog = '✓ Executed "$cmd" safely in User Mode.';
      } else {
        _lastLog = '⚡ Executed privileged "$cmd" in Kernel Mode (Mode Bit = 0).';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final isKernel = _modeBit == 0;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: (isKernel ? const Color(0xFFFF007A) : const Color(0xFF00F0FF)).withAlpha(100),
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
                    Icon(Icons.toggle_on_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'CPU Dual-Mode Protection Switcher',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Switch(
                value: isKernel,
                activeThumbColor: const Color(0xFFFF007A),
                inactiveThumbColor: const Color(0xFF00F0FF),
                onChanged: (val) => setState(() => _modeBit = val ? 0 : 1),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Hardware CPU Mode Bit: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.text1(context))),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isKernel ? const Color(0xFFFF007A) : const Color(0xFF00F0FF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      isKernel ? '0 (KERNEL MODE - Privileged)' : '1 (USER MODE - Unprivileged)',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Command Buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => _execCmd('add eax, ebx', false),
                child: const Text('Exec Normal: Math Add', style: TextStyle(fontSize: 11)),
              ),
              ElevatedButton(
                onPressed: () => _execCmd('cli (Disable Interrupts)', true),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF007A), foregroundColor: Colors.white),
                child: const Text('Exec Privileged: Disable Interrupts', style: TextStyle(fontSize: 11)),
              ),
              ElevatedButton(
                onPressed: () => _execCmd('outb (Direct I/O Port Write)', true),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB800), foregroundColor: Colors.black),
                child: const Text('Exec Privileged: Disk I/O Write', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Console Log Output Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xCC08121E) : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _lastLog.contains('TRAP') ? Colors.red : Colors.grey.withAlpha(100)),
            ),
            child: Text(
              _lastLog,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: _lastLog.contains('TRAP') ? Colors.redAccent : (isKernel ? const Color(0xFFFF007A) : const Color(0xFF00F0FF)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 8. BOOTING PROCESS VISUALIZER (bas_8)
// ============================================================================
class BootingVisualizer extends StatefulWidget {
  const BootingVisualizer({super.key});

  @override
  State<BootingVisualizer> createState() => _BootingVisualizerState();
}

class _BootingVisualizerState extends State<BootingVisualizer> {
  int _bootStep = 0;

  static const List<Map<String, String>> _steps = [
    {'stage': '1. Power On', 'action': 'Power supply stabilizes. CPU receives reset signal and jumps to ROM address 0xFFFF0.', 'icon': '🔌'},
    {'stage': '2. BIOS / UEFI Firmware', 'action': 'Executes code stored in non-volatile ROM/UEFI flash memory chip.', 'icon': '⚙️'},
    {'stage': '3. POST Diagnostic Test', 'action': 'Power-On Self-Test verifies RAM, Keyboard, and NVMe drives are functional.', 'icon': '🔍'},
    {'stage': '4. Load Bootloader', 'action': 'BIOS reads Sector 0 (MBR/EFI) and loads GRUB bootloader into RAM.', 'icon': '📀'},
    {'stage': '5. Kernel & Init Launch', 'action': 'Bootloader loads OS Kernel (`vmlinuz`) into RAM and launches `systemd` (PID 1).', 'icon': '🚀'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final current = _steps[_bootStep];

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
                    Icon(Icons.power_settings_new_rounded, color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '5-Step Computer Booting Sequence',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.neonCyan : AppColors.iconActiveLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh_rounded, size: 20),
                onPressed: () => setState(() => _bootStep = 0),
                tooltip: 'Reboot Sequence',
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Stepper Indicator Progress Bar
          Row(
            children: List.generate(_steps.length, (idx) {
              final isPassed = idx <= _bootStep;
              return Expanded(
                child: Container(
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isPassed ? const Color(0xFF00FF66) : (isDark ? Colors.white12 : Colors.black12),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 16),

          // Active Boot Step Details
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xCC08121E) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF00FF66), width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(current['icon']!, style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 10),
                    Expanded(child: Text(current['stage']!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.text1(context)))),
                  ],
                ),
                const SizedBox(height: 8),
                Text(current['action']!, style: TextStyle(fontSize: 12, height: 1.4, color: AppColors.text2(context))),
              ],
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => setState(() => _bootStep = (_bootStep + 1) % _steps.length),
              icon: const Icon(Icons.play_circle_outline_rounded, size: 18),
              label: Text(_bootStep == _steps.length - 1 ? 'Reboot System 🔄' : 'Advance Boot Step ➔'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FF66),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
