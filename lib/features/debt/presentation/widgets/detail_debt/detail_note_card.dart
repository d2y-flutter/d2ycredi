import 'package:d2ycredi/core/config/app_color.dart';
import 'package:d2ycredi/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';

class DetailNoteCard extends StatelessWidget {
  final String? note;

  const DetailNoteCard({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    if (note == null || note!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Tidak ada catatan',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColor.textSecondary,
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
          ),
        ],
      ),
      child: Text(
        note!,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColor.textSecondary,
        ),
      ),
    );
  }
}