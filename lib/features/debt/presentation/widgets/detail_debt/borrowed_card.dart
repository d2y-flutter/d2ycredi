import 'package:d2ycredi/core/config/app_color.dart';
import 'package:d2ycredi/core/config/app_constants.dart';
import 'package:d2ycredi/core/config/app_text_styles.dart';
import 'package:d2ycredi/features/debt/domain/entities/debt.dart';
import 'package:flutter/material.dart';

class BorrowerCard extends StatelessWidget {
  final Debt debt;

  const BorrowerCard({super.key, required this.debt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLG,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColor.primary.withOpacity(0.1),
            child: Text(
              debt.borrowerName.substring(0, 2).toUpperCase(),
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColor.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(debt.borrowerName,
                  style: AppTextStyles.bodyLarge),
              Text(
                'Peminjam',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}