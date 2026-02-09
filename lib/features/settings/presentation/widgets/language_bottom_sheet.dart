import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/services/language_service.dart';
import '../../../../core/widgets/d2y_toast.dart';

class LanguageBottomSheet extends StatelessWidget {
  final LanguageService languageService;

  const LanguageBottomSheet({
    super.key,
    required this.languageService,
  });

  @override
  Widget build(BuildContext context) {
    final currentLocale = languageService.getCurrentLocale(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppConstants.paddingLG),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'settings.language.select'.tr(),
                  style: AppTextStyles.h5.copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: LanguageService.supportedLocales.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final locale = LanguageService.supportedLocales[index];
            final isSelected = currentLocale.languageCode == locale.languageCode;
    
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  await languageService.changeLanguage(context, locale);
                  if (context.mounted) {
                    Navigator.pop(context);
                    D2YToast.success(context, 'settings.language.changed'.tr());
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingXL,
                    vertical: AppConstants.paddingLG,
                  ),
                  child: Row(
                    children: [
                      // Flag
                      Text(
                        languageService.getLanguageFlag(locale),
                        style: const TextStyle(fontSize: 32),
                      ),
                      const SizedBox(width: AppConstants.spaceLG),
    
                      // Language Name
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              languageService.getLanguageName(locale),
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: AppColor.textPrimary,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: AppConstants.spaceXS),
                            Text(
                              locale.toString(),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColor.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
    
                      // Checkmark
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: AppColor.primary,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom + AppConstants.paddingXS),
      ],
    );
  }
}