import 'package:flutter/material.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/widgets/d2y_button.dart';
import '../../domain/entities/app_settings.dart' as settings;

class ThemeSelectionDialog extends StatefulWidget {
  final settings.ThemeMode currentTheme;
  final ValueChanged<settings.ThemeMode> onThemeSelected;

  const ThemeSelectionDialog({
    super.key,
    required this.currentTheme,
    required this.onThemeSelected,
  });

  @override
  State<ThemeSelectionDialog> createState() => _ThemeSelectionDialogState();
}

class _ThemeSelectionDialogState extends State<ThemeSelectionDialog> {
  late settings.ThemeMode _selectedTheme;

  @override
  void initState() {
    super.initState();
    _selectedTheme = widget.currentTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusXXL),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingXXL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColor.grey300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.spaceXL),

              Text(
                'Appearance',
                style: AppTextStyles.h5.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppConstants.spaceSM),

              Text(
                'Personalize your Peringat Utang experience with your preferred theme.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColor.textSecondary,
                ),
              ),

              const SizedBox(height: AppConstants.spaceXXL),

              // Theme Options
              _buildThemeOption(
                theme: settings.ThemeMode.light,
                icon: Icons.light_mode,
                title: 'Light Mode',
                description: 'Classic bright and clean interface',
              ),

              const SizedBox(height: AppConstants.spaceMD),

              _buildThemeOption(
                theme: settings.ThemeMode.dark,
                icon: Icons.dark_mode,
                title: 'Dark Mode',
                description: 'Easier on the eyes in low light',
              ),

              const SizedBox(height: AppConstants.spaceMD),

              _buildThemeOption(
                theme: settings.ThemeMode.system,
                icon: Icons.settings_suggest,
                title: 'System Default',
                description: 'Matches your device global settings',
              ),

              const SizedBox(height: AppConstants.spaceXXL),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: D2YButton(
                      label: 'Dismiss',
                      onPressed: () => Navigator.pop(context),
                      type: D2YButtonType.outlined,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spaceMD),
                  Expanded(
                    child: D2YButton(
                      label: 'Apply Changes',
                      onPressed: () {
                        widget.onThemeSelected(_selectedTheme);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption({
    required settings.ThemeMode theme,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final isSelected = _selectedTheme == theme;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTheme = theme;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingLG),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primarySurface : AppColor.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          border: Border.all(
            color: isSelected ? AppColor.primary : AppColor.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.primary.withOpacity(0.1)
                    : AppColor.grey100,
                borderRadius: BorderRadius.circular(AppConstants.radiusMD),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColor.primary : AppColor.textSecondary,
                size: 24,
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
                    description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppConstants.spaceMD),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColor.primary : AppColor.grey400,
                  width: 2,
                ),
                color: isSelected ? AppColor.primary : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: AppColor.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}