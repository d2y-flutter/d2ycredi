import 'package:d2ycredi/core/config/app_color.dart';
import 'package:d2ycredi/core/config/app_constants.dart';
import 'package:d2ycredi/core/config/app_text_styles.dart';
import 'package:d2ycredi/features/debt/domain/entities/debt.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DebtInfoCard extends StatelessWidget {
  final Debt debt;

  const DebtInfoCard({super.key, required this.debt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLG),
      padding: const EdgeInsets.all(AppConstants.paddingLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Tanggal Pinjam',
            value: DateFormat('dd MMM yyyy').format(debt.dueDate),
          ),
          const SizedBox(height: AppConstants.paddingLG),
          _InfoRow(
            icon: Icons.event_busy_outlined,
            label: 'Jatuh Tempo',
            value: DateFormat('dd MMM yyyy').format(debt.dueDate),
            valueColor: AppColor.error,
          ),
          const SizedBox(height: AppConstants.paddingLG),
          _InfoRow(
            icon: Icons.info_outline,
            label: 'Status',
            value: 'Menunggu Pembayaran',
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingMD),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColor.textSecondary),
          const SizedBox(width: AppConstants.paddingMD),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColor.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppColor.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}