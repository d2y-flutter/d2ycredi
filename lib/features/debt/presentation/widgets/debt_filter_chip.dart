import 'package:flutter/material.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';

class DebtFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color? color;
  final VoidCallback onTap;

  const DebtFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColor.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingLG,
          vertical: AppConstants.paddingSM,
        ),
        decoration: BoxDecoration(
          color: isSelected ? effectiveColor : AppColor.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          border: Border.all(
            color: isSelected ? effectiveColor : AppColor.border,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColor.white : AppColor.textSecondary,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}