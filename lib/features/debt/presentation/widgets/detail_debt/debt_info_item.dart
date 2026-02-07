import 'package:flutter/material.dart';
import '../../../../../core/config/app_color.dart';
import '../../../../../core/config/app_constants.dart';
import '../../../../../core/config/app_text_styles.dart';

class DebtInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final Color? iconColor;

  const DebtInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: (iconColor ?? AppColor.primary).withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          ),
          child: Icon(
            icon,
            color: iconColor ?? AppColor.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: AppConstants.spaceMD),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
              const SizedBox(height: AppConstants.spaceXS),
              Text(
                value,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: valueColor ?? AppColor.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}