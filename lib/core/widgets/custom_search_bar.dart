import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'glass_container.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const CustomSearchBar({
    super.key,
    this.hintText = "Search topics, algorithms...",
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final iconColor = isDark ? AppColors.neonCyan : AppColors.lightPurple;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final hintColor = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;

    return GlassContainer(
      padding: EdgeInsets.zero,
      borderRadius: 18,
      blur: 20.0,
      color: isDark ? null : const Color(0x8CFFFFFF),
      borderColor: isDark ? AppColors.neonCyan.withAlpha(40) : const Color(0x99FFFFFF),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: textColor, fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor, fontSize: 14),
          prefixIcon: Icon(Icons.search_rounded, color: iconColor, size: 20),
          suffixIcon: controller != null && controller!.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear_rounded, color: hintColor, size: 18),
                  onPressed: () {
                    controller!.clear();
                    if (onChanged != null) onChanged!('');
                  },
                )
              : null,
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
    );
  }
}
