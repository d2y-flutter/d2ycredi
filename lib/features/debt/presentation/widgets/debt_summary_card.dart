import 'package:flutter/material.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/debt.dart';

class DebtSummaryCard extends StatelessWidget {
  final DebtSummary summary;

  const DebtSummaryCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLG),
      padding: const EdgeInsets.all(AppConstants.paddingXL),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowMedium,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryItem(
              label: 'TOTAL AKTIF',
              amount: summary.totalActive,
              color: AppColor.primary,
              icon: Icons.arrow_upward,
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: AppColor.border,
            margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLG),
          ),
          Expanded(
            child: _buildSummaryItem(
              label: 'SUDAH LUNAS',
              amount: summary.totalPaid,
              color: AppColor.statusLunas,
              icon: Icons.check_circle_outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required String label,
    required double amount,
    required Color color,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColor.textSecondary,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: AppConstants.spaceSM),
        Text(
          Formatters.currency(amount, symbol: 'Rp ', decimalDigits: 0),
          style: AppTextStyles.h4.copyWith(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.spaceXS),
        Container(
          height: 4,
          width: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}