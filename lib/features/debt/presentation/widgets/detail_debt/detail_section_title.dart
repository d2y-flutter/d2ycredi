import 'package:d2ycredi/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';

class DetailSectionTitle extends StatelessWidget {
  final String title;

  const DetailSectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}