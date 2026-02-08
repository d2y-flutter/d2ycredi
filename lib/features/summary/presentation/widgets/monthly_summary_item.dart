import 'package:flutter/material.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/monthly_summary.dart';

class MonthlySummaryItem extends StatelessWidget {
  final MonthlySummary summary;

  const MonthlySummaryItem({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final isNewLoan = summary.newLoansCount > 0;
    final isPaid = summary.paymentsCount > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spaceMD),
      padding: const EdgeInsets.all(AppConstants.paddingLG),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        border: Border.all(color: AppColor.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${summary.month} ${summary.year}',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColor.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppConstants.spaceLG),

          // New Loans
          if (isNewLoan) ...[
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColor.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    color: AppColor.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppConstants.spaceMD),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pinjaman Baru',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spaceXS),
                      Text(
                        '${summary.newLoansCount} Transaksi',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Formatters.currency(
                        summary.totalNewLoans,
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ),
                      style: AppTextStyles.h6.copyWith(
                        color: AppColor.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spaceXS),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingSM,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: summary.status == 'Meningkat'
                            ? AppColor.success.withOpacity(0.1)
                            : AppColor.grey200,
                        borderRadius: BorderRadius.circular(AppConstants.radiusXS),
                      ),
                      child: Text(
                        summary.status,
                        style: TextStyle(
                          color: summary.status == 'Meningkat'
                              ? AppColor.success
                              : AppColor.textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],

          // Divider if both exist
          if (isNewLoan && isPaid) ...[
            const SizedBox(height: AppConstants.spaceLG),
            const Divider(),
            const SizedBox(height: AppConstants.spaceLG),
          ],

          // Payments
          if (isPaid) ...[
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColor.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: AppColor.success,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppConstants.spaceMD),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Pelunasan',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spaceXS),
                      Text(
                        '${summary.paymentsCount} Transaksi',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Formatters.currency(
                        summary.totalPayments,
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ),
                      style: AppTextStyles.h6.copyWith(
                        color: AppColor.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spaceXS),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingSM,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppConstants.radiusXS),
                      ),
                      child: const Text(
                        'Selesai',
                        style: TextStyle(
                          color: AppColor.success,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}