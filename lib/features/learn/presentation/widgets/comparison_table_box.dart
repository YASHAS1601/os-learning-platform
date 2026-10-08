import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../models/topic_model.dart';

class ComparisonTableBox extends StatelessWidget {
  final ComparisonTableModel table;

  const ComparisonTableBox({
    super.key,
    required this.table,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final accent = isDark ? AppColors.neonPurple : AppColors.iconActiveLight;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderColor: accent.withAlpha(isDark ? 60 : 40),
      color: isDark ? const Color(0x1F9D00FF) : const Color(0xFFF8F0FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.table_chart_rounded, color: accent, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  table.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(accent.withAlpha(40)),
              dataRowMinHeight: 38,
              dataRowMaxHeight: 60,
              columns: table.headers.map((h) {
                return DataColumn(
                  label: Text(
                    h,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: accent,
                    ),
                  ),
                );
              }).toList(),
              rows: table.rows.map((row) {
                return DataRow(
                  cells: row.map((cell) {
                    return DataCell(
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 180),
                        child: Text(
                          cell,
                          style: TextStyle(fontSize: 12, color: AppColors.text1(context)),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
