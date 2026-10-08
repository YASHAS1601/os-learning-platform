import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../models/tutor_mode.dart';

class RiyahModeSelector extends StatelessWidget {
  final TutorMode selectedMode;
  final ValueChanged<TutorMode> onModeSelected;

  const RiyahModeSelector({
    super.key,
    required this.selectedMode,
    required this.onModeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: TutorMode.values.length,
        itemBuilder: (context, index) {
          final mode = TutorMode.values[index];
          final isSelected = mode == selectedMode;
          final isDark = AppColors.isDark(context);
          final modeColor = isDark ? mode.color : (isSelected ? AppColors.iconActiveLight : AppColors.iconPrimaryLight);

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              showCheckmark: false,
              avatar: Icon(
                mode.icon,
                size: 14,
                color: isSelected ? (isDark ? Colors.black : Colors.white) : modeColor,
              ),
              label: Text(
                mode.label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected ? (isDark ? Colors.black : Colors.white) : AppColors.text2(context),
                ),
              ),
              backgroundColor: isDark ? AppColors.surfaceGlassDark : const Color(0x8CFFFFFF),
              selectedColor: isDark ? modeColor : AppColors.iconActiveLight,
              side: BorderSide(
                color: isSelected ? modeColor : (isDark ? modeColor.withAlpha(50) : const Color(0x99FFFFFF)),
                width: isSelected ? 1.5 : 1.0,
              ),
              onSelected: (_) => onModeSelected(mode),
            ),
          );
        },
      ),
    );
  }
}
