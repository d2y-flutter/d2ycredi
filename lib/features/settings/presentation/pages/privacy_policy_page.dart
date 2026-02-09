import 'package:flutter/material.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        title: Text(
          'Terms of Service',
          style: AppTextStyles.h5.copyWith(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingXXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms of Service',
                style: AppTextStyles.h3.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppConstants.spaceMD),

              Text(
                'Last updated: October 2023. Please read these terms carefully before using the Peringat Utang application. By accessing or using the service, you agree to be bound by these terms.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColor.textSecondary,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: AppConstants.spaceXXL),

              _buildSection(
                number: '1',
                title: 'Local Data Usage',
                content:
                    'Peringat Utang is designed to store your debt records locally on your device. We prioritize your privacy by ensuring that your financial data remains under your control at all times. The app does not transmit your personal financial records to our servers unless you explicitly enable cloud backup or synchronization.',
              ),

              const SizedBox(height: AppConstants.spaceXL),

              _buildSection(
                number: '2',
                title: 'Optional Cloud Sync',
                content:
                    'If you choose to enable the optional Cloud Sync feature, your data will be encrypted and stored on our secure servers to allow cross-device access. You can disable this feature at any time, which will stop future synchronization, though previously synced data will remain until deleted from your account profile.',
              ),

              const SizedBox(height: AppConstants.spaceXL),

              _buildSection(
                number: '3',
                title: 'User Responsibilities',
                content:
                    'You are responsible for maintaining the confidentiality of your device and any passcodes used to access the application. You agree to notify us immediately of any unauthorized access to your account or any other breach of security.',
              ),

              const SizedBox(height: AppConstants.spaceXXL),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String number,
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(AppConstants.radiusMD),
              ),
              child: Center(
                child: Text(
                  number,
                  style: const TextStyle(
                    color: AppColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppConstants.spaceMD),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.h6.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spaceMD),
        Text(
          content,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColor.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}