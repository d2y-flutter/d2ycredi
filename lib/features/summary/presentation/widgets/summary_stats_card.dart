import 'package:flutter/material.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/monthly_summary.dart';

class SummaryStatsCard extends StatelessWidget {
  final SummaryStats stats;

  const SummaryStatsCard({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLG),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              label: 'TOTAL DIBAYAR',
              value: Formatters.currency(
                stats.totalPaidDebt,
                symbol: 'Rp ',
                decimalDigits: 0,
              ),
              subtitle: '-2%',
              subtitleColor: AppColor.error,
              icon: Icons.trending_down,
            ),
          ),
          const SizedBox(width: AppConstants.spaceMD),
          Expanded(
            child: _buildStatItem(
              label: 'DEBITUR AKTIF',
              value: '${stats.totalDebtors} Orang',
              subtitle: 'Stabil',
              subtitleColor: AppColor.textSecondary,
              icon: Icons.people_outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required String subtitle,
    required Color subtitleColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLG),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        border: Border.all(color: AppColor.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColor.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppConstants.spaceMD),
          Text(
            value,
            style: AppTextStyles.h5.copyWith(
              color: AppColor.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppConstants.spaceSM),
          Row(
            children: [
              Icon(
                icon,
                size: 14,
                color: subtitleColor,
              ),
              const SizedBox(width: AppConstants.spaceXS),
              Text(
                subtitle,
                style: TextStyle(
                  color: subtitleColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}