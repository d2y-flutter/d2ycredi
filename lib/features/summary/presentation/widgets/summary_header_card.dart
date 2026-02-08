import 'package:flutter/material.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/monthly_summary.dart';

class SummaryHeaderCard extends StatelessWidget {
  final SummaryStats stats;

  const SummaryHeaderCard({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = stats.percentageChange >= 0;

    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingLG),
      padding: const EdgeInsets.all(AppConstants.paddingXXL),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.primary,
            Color(0xFF1E40AF),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColor.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Utang Aktif',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColor.white.withOpacity(0.9),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingMD,
                  vertical: AppConstants.paddingXS,
                ),
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppConstants.radiusSM),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.file_copy_outlined,
                      color: AppColor.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spaceLG),

          Text(
            Formatters.currency(
              stats.totalActiveDebt,
              symbol: 'Rp ',
              decimalDigits: 0,
            ),
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: AppColor.white,
              letterSpacing: -1.5,
            ),
          ),

          const SizedBox(height: AppConstants.spaceSM),

          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingSM,
                  vertical: AppConstants.paddingXS,
                ),
                decoration: BoxDecoration(
                  color: isPositive
                      ? AppColor.success.withOpacity(0.2)
                      : AppColor.error.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppConstants.radiusSM),
                ),
                child: Row(
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: AppColor.white,
                      size: 16,
                    ),
                    const SizedBox(width: AppConstants.spaceXS),
                    Text(
                      '${isPositive ? '+' : ''}${stats.percentageChange.toStringAsFixed(2)}%',
                      style: const TextStyle(
                        color: AppColor.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppConstants.spaceSM),
              Text(
                'dari bulan lalu',
                style: TextStyle(
                  color: AppColor.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}