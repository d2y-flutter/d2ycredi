import 'package:d2ycredi/features/onboarding/data/model/onboarding_item.dart';
import 'package:flutter/material.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingContent({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingLG),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: AppColor.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              size: 56,
              color: AppColor.primary,
            ),
          ),
          const SizedBox(height: AppConstants.spaceXL),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: AppColor.grey900,
            ),
          ),
          const SizedBox(height: AppConstants.spaceMD),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColor.grey600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}