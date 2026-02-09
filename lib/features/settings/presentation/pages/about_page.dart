import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/widgets/d2y_button.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        title: Text(
          'Tentang Aplikasi',
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
            children: [
              const SizedBox(height: AppConstants.spaceXL),

              // App Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: AppColor.primaryGradient,
                  borderRadius: BorderRadius.circular(AppConstants.radiusXXL),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  size: 60,
                  color: AppColor.white,
                ),
              ),

              const SizedBox(height: AppConstants.spaceXL),

              Text(
                'D2YCREDI',
                style: AppTextStyles.h3.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppConstants.spaceSM),

              Text(
                'Versi 1.2.0',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColor.textSecondary,
                ),
              ),

              const SizedBox(height: AppConstants.spaceXXL),

              Container(
                padding: const EdgeInsets.all(AppConstants.paddingXL),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(AppConstants.radiusLG),
                  border: Border.all(color: AppColor.border, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aplikasi manajemen utang yang membantu Anda mencatat dan mengelola pinjaman dengan mudah, aman, dan transparan untuk keuangan yang lebih baik.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColor.textSecondary,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppConstants.spaceXL),

              // Links
              _buildLinkItem(
                icon: Icons.language,
                title: 'Situs Web',
                subtitle: 'Kunjungi d2ycredi.com',
                onTap: () async {
                  final uri = Uri.parse('https://d2ycredi.com');
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                },
              ),

              const SizedBox(height: AppConstants.spaceMD),

              _buildLinkItem(
                icon: Icons.photo_camera,
                title: 'Instagram',
                subtitle: '@d2ycredi_app',
                onTap: () async {
                  final uri = Uri.parse('https://instagram.com/d2ycredi_app');
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                },
              ),

              const SizedBox(height: AppConstants.spaceXXL),

              // Rate Button
              D2YButton(
                label: 'Beri Rating di App Store',
                icon: Icons.star_outline,
                onPressed: () {
                  // Open app store
                },
                fullWidth: true,
              ),

              const SizedBox(height: AppConstants.spaceXL),

              Text(
                '© 2026 D2YCREDI App Team',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColor.textSecondary,
                ),
              ),

              const SizedBox(height: AppConstants.spaceXS),

              Text(
                'Dibuat dengan ❤️ untuk Anda',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColor.textHint,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLinkItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        border: Border.all(color: AppColor.border, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingLG),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColor.primarySurface,
                    borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                  ),
                  child: Icon(
                    icon,
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
                        title,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spaceXS),
                      Text(
                        subtitle,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColor.textSecondary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}