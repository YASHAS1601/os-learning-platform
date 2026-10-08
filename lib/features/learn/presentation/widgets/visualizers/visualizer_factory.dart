import 'package:flutter/material.dart';
import '../../../models/topic_model.dart';
import 'basics_visualizers.dart';
import 'process_visualizers.dart';
import 'cpu_scheduling_visualizer.dart';
import 'synchronization_visualizer.dart';
import 'deadlock_visualizer.dart';
import 'memory_allocation_visualizer.dart';
import 'paging_visualizer.dart';
import 'page_replacement_visualizer.dart';
import 'disk_scheduling_visualizer.dart';
import 'file_system_visualizer.dart';
import 'io_management_visualizer.dart';

class VisualizerFactory extends StatelessWidget {
  final TopicModel topic;

  const VisualizerFactory({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    final type = topic.visualizerType ?? _deduceType(topic);

    switch (type) {
      // Category 1: OS Basics
      case 'os_architecture':
        return const OsArchitectureVisualizer();
      case 'os_functions':
        return const OsFunctionsVisualizer();
      case 'os_types':
        return const OsTypesVisualizer();
      case 'os_services':
        return const OsServicesVisualizer();
      case 'system_calls':
        return const SystemCallVisualizer();
      case 'kernel_arch':
        return const KernelArchVisualizer();
      case 'dual_mode':
        return const DualModeVisualizer();
      case 'booting_process':
        return const BootingVisualizer();

      // Category 2: Process Management
      case 'process_memory':
        return const ProcessMemoryVisualizer();
      case 'process_state':
        return const ProcessStateVisualizer();
      case 'pcb_structure':
      case 'pcb':
        return const PcbVisualizer();
      case 'context_switch':
        return const ContextSwitchVisualizer();
      case 'thread_memory':
        return const ThreadMemoryVisualizer();
      case 'multithreading_models':
        return const MultithreadingModelsVisualizer();
      case 'ipc_mechanisms':
        return const IpcVisualizer();
      case 'race_condition_guard':
        return const SyncIntroVisualizer();

      // Category 3: CPU Scheduling
      case 'cpu_intro':
        return const CpuIntroVisualizer();
      case 'cpu_fcfs':
      case 'cpu_gantt':
        return const CpuFcfsVisualizer();
      case 'cpu_sjf':
        return const CpuSjfVisualizer();
      case 'cpu_srtf':
        return const CpuSrtfVisualizer();
      case 'cpu_rr':
        return const CpuRrVisualizer();
      case 'cpu_priority':
        return const CpuPriorityVisualizer();
      case 'cpu_preemptive':
        return const CpuPreemptiveVisualizer();
      case 'cpu_non_preemptive':
        return const CpuNonPreemptiveVisualizer();

      // Category 4: Process Synchronization
      case 'cs_problem':
        return const CsProblemVisualizer();
      case 'race_condition':
        return const RaceConditionVisualizer();
      case 'mutex_lock':
        return const MutexLockVisualizer();
      case 'sync_peterson':
        return const PetersonVisualizer();
      case 'sync_semaphore':
        return const SemaphoreVisualizer();
      case 'mutex_ownership':
        return const MutexOwnershipVisualizer();
      case 'monitor_construct':
        return const MonitorConstructVisualizer();
      case 'producer_consumer':
        return const ProducerConsumerVisualizer();
      case 'readers_writers':
        return const ReadersWritersVisualizer();
      case 'dining_philosophers':
        return const DiningPhilosophersVisualizer();

      // Category 5: Deadlock
      case 'deadlock_intro':
        return const DeadlockIntroVisualizer();
      case 'coffman_conditions':
        return const CoffmanConditionsVisualizer();
      case 'deadlock_rag':
        return const RagVisualizer();
      case 'deadlock_prevention':
        return const DeadlockPreventionVisualizer();
      case 'deadlock_avoidance':
        return const DeadlockAvoidanceVisualizer();
      case 'bankers':
        return const BankersVisualizer();
      case 'deadlock_detection':
        return const DeadlockDetectionVisualizer();
      case 'deadlock_recovery':
        return const DeadlockRecoveryVisualizer();

      // Category 6: Memory Management
      case 'memory_intro':
        return const MemoryIntroVisualizer();
      case 'contiguous_mem':
        return const ContiguousMemVisualizer();
      case 'fixed_partitioning':
        return const FixedPartitioningVisualizer();
      case 'variable_partitioning':
        return const VariablePartitioningVisualizer();
      case 'first_fit':
        return const FirstFitVisualizer();
      case 'best_fit':
        return const BestFitVisualizer();
      case 'worst_fit':
        return const WorstFitVisualizer();
      case 'next_fit':
        return const NextFitVisualizer();
      case 'memory_allocation':
        return const MemoryAllocationVisualizer();
      case 'paging_translation':
        return const PagingAddressTranslationVisualizer();
      case 'segmentation_translation':
        return const SegmentationVisualizer();

      // Category 7: Virtual Memory
      case 'vm_intro':
        return const VmIntroVisualizer();
      case 'demand_paging':
        return const DemandPagingVisualizer();
      case 'page_fault':
        return const PageFaultVisualizer();
      case 'page_repl_intro':
        return const PageReplIntroVisualizer();
      case 'page_replacement_fifo':
        return const PageReplacementFifoVisualizer();
      case 'page_replacement_lru':
        return const PageReplacementLruVisualizer();
      case 'page_replacement_opt':
        return const PageReplacementOptVisualizer();
      case 'thrashing_sim':
        return const ThrashingVisualizer();

      // Category 8: File System
      case 'file_concepts':
        return const FileConceptsVisualizer();
      case 'file_attributes':
        return const FileAttributesVisualizer();
      case 'file_operations':
        return const FileOperationsVisualizer();
      case 'directory_structure':
        return const DirectoryStructureVisualizer();
      case 'file_alloc_intro':
        return const FileAllocIntroVisualizer();
      case 'contiguous_file_alloc':
        return const ContiguousFileAllocVisualizer();
      case 'linked_file_alloc':
        return const LinkedFileAllocVisualizer();
      case 'indexed_file_alloc':
        return const IndexedFileAllocVisualizer();
      case 'free_space_mgmt':
        return const FreeSpaceMgmtVisualizer();
      case 'file_allocation':
        return const FileSystemVisualizer();

      // Category 9: Disk Scheduling
      case 'disk_structure':
        return const DiskStructureVisualizer();
      case 'disk_latency':
        return const DiskLatencyVisualizer();
      case 'disk_fcfs':
        return const DiskFcfsVisualizer();
      case 'disk_sstf':
        return const DiskSstfVisualizer();
      case 'disk_scan':
        return const DiskScanVisualizer();
      case 'disk_cscan':
        return const DiskCscanVisualizer();
      case 'disk_look':
        return const DiskLookVisualizer();
      case 'disk_clook':
        return const DiskClookVisualizer();
      case 'disk_scheduling':
        return const DiskSchedulingVisualizer();

      // Category 10: I/O Management
      case 'io_hardware':
        return const IoHardwareVisualizer();
      case 'io_syscalls':
        return const IoSyscallsVisualizer();
      case 'device_controllers':
        return const DeviceControllersVisualizer();
      case 'hardware_interrupts':
        return const HardwareInterruptsVisualizer();
      case 'dma_transfer':
        return const DmaTransferVisualizer();
      case 'device_drivers':
        return const DeviceDriversVisualizer();
      case 'io_dma_interrupt':
        return const IoManagementVisualizer();

      default:
        return _fallbackCategoryVisualizer(topic.categoryId);
    }
  }

  static String _deduceType(TopicModel t) {
    final tid = t.id.toLowerCase();
    if (tid == 'bas_1') return 'os_architecture';
    if (tid == 'bas_2') return 'os_functions';
    if (tid == 'bas_3') return 'os_types';
    if (tid == 'bas_4') return 'os_services';
    if (tid == 'bas_5') return 'system_calls';
    if (tid == 'bas_6') return 'kernel_arch';
    if (tid == 'bas_7') return 'dual_mode';
    if (tid == 'bas_8') return 'booting_process';

    if (tid == 'proc_1') return 'process_memory';
    if (tid == 'proc_2') return 'process_state';
    if (tid == 'proc_3') return 'pcb_structure';
    if (tid == 'proc_4') return 'context_switch';
    if (tid == 'proc_5') return 'thread_memory';
    if (tid == 'proc_6') return 'multithreading_models';
    if (tid == 'proc_7') return 'ipc_mechanisms';
    if (tid == 'proc_8') return 'race_condition_guard';

    if (tid == 'cpu_1') return 'cpu_intro';
    if (tid == 'cpu_2') return 'cpu_fcfs';
    if (tid == 'cpu_3') return 'cpu_sjf';
    if (tid == 'cpu_4') return 'cpu_srtf';
    if (tid == 'cpu_5') return 'cpu_rr';
    if (tid == 'cpu_6') return 'cpu_priority';
    if (tid == 'cpu_7') return 'cpu_preemptive';
    if (tid == 'cpu_8') return 'cpu_non_preemptive';

    if (tid == 'sync_1') return 'cs_problem';
    if (tid == 'sync_2') return 'race_condition';
    if (tid == 'sync_3') return 'mutex_lock';
    if (tid == 'sync_4') return 'sync_peterson';
    if (tid == 'sync_5') return 'sync_semaphore';
    if (tid == 'sync_6') return 'mutex_ownership';
    if (tid == 'sync_7') return 'monitor_construct';
    if (tid == 'sync_8') return 'producer_consumer';
    if (tid == 'sync_9') return 'readers_writers';
    if (tid == 'sync_10') return 'dining_philosophers';

    if (tid == 'dl_1') return 'deadlock_intro';
    if (tid == 'dl_2') return 'coffman_conditions';
    if (tid == 'dl_3') return 'deadlock_rag';
    if (tid == 'dl_4') return 'deadlock_prevention';
    if (tid == 'dl_5') return 'deadlock_avoidance';
    if (tid == 'dl_6') return 'bankers';
    if (tid == 'dl_7') return 'deadlock_detection';
    if (tid == 'dl_8') return 'deadlock_recovery';

    if (tid == 'mem_1') return 'memory_intro';
    if (tid == 'mem_2') return 'contiguous_mem';
    if (tid == 'mem_3') return 'fixed_partitioning';
    if (tid == 'mem_4') return 'variable_partitioning';
    if (tid == 'mem_5') return 'first_fit';
    if (tid == 'mem_6') return 'best_fit';
    if (tid == 'mem_7') return 'worst_fit';
    if (tid == 'mem_8') return 'next_fit';
    if (tid == 'mem_9') return 'paging_translation';
    if (tid == 'mem_10') return 'segmentation_translation';

    if (tid == 'vm_1') return 'vm_intro';
    if (tid == 'vm_2') return 'demand_paging';
    if (tid == 'vm_3') return 'page_fault';
    if (tid == 'vm_4') return 'page_repl_intro';
    if (tid == 'vm_5') return 'page_replacement_fifo';
    if (tid == 'vm_6') return 'page_replacement_lru';
    if (tid == 'vm_7') return 'page_replacement_opt';
    if (tid == 'vm_8') return 'thrashing_sim';

    if (tid == 'file_1') return 'file_concepts';
    if (tid == 'file_2') return 'file_attributes';
    if (tid == 'file_3') return 'file_operations';
    if (tid == 'file_4') return 'directory_structure';
    if (tid == 'file_5') return 'file_alloc_intro';
    if (tid == 'file_6') return 'contiguous_file_alloc';
    if (tid == 'file_7') return 'linked_file_alloc';
    if (tid == 'file_8') return 'indexed_file_alloc';
    if (tid == 'file_9') return 'free_space_mgmt';

    if (tid == 'disk_1') return 'disk_structure';
    if (tid == 'disk_2') return 'disk_latency';
    if (tid == 'disk_3') return 'disk_fcfs';
    if (tid == 'disk_4') return 'disk_sstf';
    if (tid == 'disk_5') return 'disk_scan';
    if (tid == 'disk_6') return 'disk_cscan';
    if (tid == 'disk_7') return 'disk_look';
    if (tid == 'disk_8') return 'disk_clook';

    if (tid == 'io_1') return 'io_hardware';
    if (tid == 'io_2') return 'io_syscalls';
    if (tid == 'io_3') return 'device_controllers';
    if (tid == 'io_4') return 'hardware_interrupts';
    if (tid == 'io_5') return 'dma_transfer';
    if (tid == 'io_6') return 'device_drivers';

    return 'os_architecture';
  }

  Widget _fallbackCategoryVisualizer(String catId) {
    switch (catId) {
      case 'cat_basics':
        return const OsArchitectureVisualizer();
      case 'cat_process':
        return const ProcessStateVisualizer();
      case 'cat_cpu':
        return const CpuFcfsVisualizer();
      case 'cat_sync':
        return const CsProblemVisualizer();
      case 'cat_deadlock':
        return const DeadlockIntroVisualizer();
      case 'cat_memory':
        return const MemoryIntroVisualizer();
      case 'cat_vmemory':
        return const VmIntroVisualizer();
      case 'cat_disk':
        return const DiskStructureVisualizer();
      case 'cat_file':
        return const FileConceptsVisualizer();
      case 'cat_io':
        return const IoHardwareVisualizer();
      default:
        return const OsArchitectureVisualizer();
    }
  }
}
