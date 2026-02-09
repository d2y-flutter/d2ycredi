import 'package:d2ycredi/core/utils/avatar_color_utils.dart';
import 'package:d2ycredi/core/utils/helpers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/config/app_color.dart';
import '../../../../../core/config/app_text_styles.dart';
import '../../../domain/entities/debt.dart';

class PaymentInfoCard extends StatelessWidget {
  final Debt debt;

  const PaymentInfoCard({super.key, required this.debt});

  @override
  Widget build(BuildContext context) {
    final bgColor =
        AvatarColorUtils.backgroundFromName(debt.borrowerName);
    final textColor =
        AvatarColorUtils.textColorFromBackground(bgColor);
        
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.primarySurface,
      ),
      child: Column(
        children: [
          // HEADER
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Informasi Pembayaran',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColor.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // BODY
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'TOTAL PINJAMAN',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    _StatusBadge(debt.status),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(debt.amount),
                  style: AppTextStyles.h1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),
                const Divider(),

                const SizedBox(height: 12),

                // Borrower
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: bgColor,
                      child: Text(
                        Helpers.getInitials(debt.borrowerName),
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          debt.borrowerName,
                          style: AppTextStyles.h6,
                        ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final DebtStatus status;

  const _StatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    final isPaid = status == DebtStatus.lunas;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: isPaid
            ? AppColor.success.withOpacity(0.15)
            : AppColor.warning.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isPaid ? 'Lunas' : 'Belum Lunas',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isPaid ? AppColor.success : AppColor.warning,
        ),
      ),
    );
  }
}