import 'package:d2ycredi/core/services/language_service.dart';
import 'package:d2ycredi/core/widgets/d2y_bottom_sheet.dart';
import 'package:d2ycredi/core/widgets/d2y_modal.dart';
import 'package:d2ycredi/features/settings/presentation/widgets/language_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/widgets/d2y_loading.dart';
import '../../../../core/widgets/d2y_switch.dart';
import '../../../../core/widgets/d2y_toast.dart';
import '../../../../injection_container.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../widgets/settings_item.dart';
import '../widgets/settings_section.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(
        getSettingsUseCase: getIt(),
        updateSettingsUseCase: getIt(),
        settingsRepository: getIt(),
      )..add(LoadSettings()),
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = LanguageService();

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'settings.title'.tr(),
          style: AppTextStyles.h5.copyWith(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsUpdateSuccess) {
            D2YToast.success(context, state.message);
          } else if (state is SettingsError) {
            D2YToast.error(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is SettingsLoading) {
            return D2YLoading.center(message: 'settings.loading'.tr());
          }

          if (state is SettingsError && state is! SettingsUpdateSuccess) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColor.error,
                  ),
                  const SizedBox(height: AppConstants.spaceLG),
                  Text(
                    state.message,
                    style: AppTextStyles.bodyLarge,
                  ),
                ],
              ),
            );
          }

          if (state is SettingsLoaded) {
            return _buildContent(context, state, languageService);
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    SettingsLoaded state,
    LanguageService languageService,
  ) {
    final currentLocale = languageService.getCurrentLocale(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppConstants.spaceLG),

          // PREFERENSI Section
          SettingsSection(
            title: 'settings.preferences'.tr(),
            children: [
              // Notifikasi
              SettingsItem(
                icon: Icons.notifications_outlined,
                iconColor: AppColor.primary,
                iconBackgroundColor: AppColor.primarySurface,
                title: 'settings.notifications.title'.tr(),
                subtitle: 'settings.notifications.subtitle'.tr(),
                trailing: D2YCustomSwitch(
                  value: state.settings.notificationsEnabled,
                  onChanged: (value) {
                    context
                        .read<SettingsBloc>()
                        .add(UpdateNotificationSettings(value));
                  },
                  activeColor: AppColor.primary,
                ),
              ),

              // Bahasa
              SettingsItem(
                icon: Icons.language,
                iconColor: AppColor.warning,
                iconBackgroundColor: AppColor.warningSurface,
                title: 'settings.language.title'.tr(),
                subtitle: languageService.getLanguageName(currentLocale),
                onTap: () {
                  _showLanguageBottomSheet(context, languageService);
                },
              ),

              // Mode Tema
              // SettingsItem(
              //   icon: Icons.palette_outlined,
              //   iconColor: AppColor.secondary,
              //   iconBackgroundColor: AppColor.secondarySurface,
              //   title: 'settings.theme.title'.tr(),
              //   subtitle: state.settings.themeMode.displayName,
              //   onTap: () {
              //     _showThemeDialog(context, state.settings.themeMode);
              //   },
              // ),
            ],
          ),

          const SizedBox(height: AppConstants.spaceLG),

          // DATA & KEAMANAN Section
          SettingsSection(
            title: 'settings.data_security'.tr(),
            children: [
              // Backup & Restore
              SettingsItem(
                icon: Icons.cloud_upload_outlined,
                iconColor: AppColor.info,
                iconBackgroundColor: AppColor.infoSurface,
                title: 'settings.backup.title'.tr(),
                subtitle: 'settings.backup.subtitle'.tr(),
                onTap: () {
                  // Navigate to backup page
                },
              ),

              // Reset Semua Data
              SettingsItem(
                icon: Icons.delete_outline,
                iconColor: AppColor.error,
                iconBackgroundColor: AppColor.errorSurface,
                title: 'settings.reset.title'.tr(),
                subtitle: 'settings.reset.subtitle'.tr(),
                onTap: () {
                  _showClearDataConfirmation(context);
                },
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spaceLG),

          // LAINNYA Section
          SettingsSection(
            title: 'settings.others'.tr(),
            children: [
              // Tentang Aplikasi
              SettingsItem(
                icon: Icons.info_outline,
                iconColor: AppColor.textSecondary,
                iconBackgroundColor: AppColor.grey200,
                title: 'settings.about.title'.tr(),
                subtitle: 'settings.about.subtitle'.tr(),
                onTap: () {
                  context.push('/settings/about');
                },
              ),

              // Kebijakan Privasi
              SettingsItem(
                icon: Icons.privacy_tip_outlined,
                iconColor: AppColor.textSecondary,
                iconBackgroundColor: AppColor.grey200,
                title: 'settings.privacy.title'.tr(),
                subtitle: 'settings.privacy.subtitle'.tr(),
                onTap: () {
                  context.push('/settings/privacy');
                },
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spaceXL),

          // Version Info
          Center(
            child: Column(
              children: [
                Text(
                  'app_name'.tr().toUpperCase(),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColor.textSecondary,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: AppConstants.spaceXS),
                Text(
                  'settings.version'.tr(args: ['2.0.0']),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColor.textHint,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppConstants.spaceXXL),
        ],
      ),
    );
  }

  void _showLanguageBottomSheet(
    BuildContext context,
    LanguageService languageService,
  ) {
    D2YBottomSheet.show(
      context: context,
      child: LanguageBottomSheet(
        languageService: languageService,
      ),
    );
  }

  // void _showThemeDialog(BuildContext context, setting.ThemeMode currentTheme) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (modalContext) => ThemeSelectionDialog(
  //       currentTheme: currentTheme,
  //       onThemeSelected: (theme) {
  //         context.read<SettingsBloc>().add(UpdateThemeMode(theme));
  //         Navigator.pop(modalContext);
  //       },
  //     ),
  //   );
  // }

  Future<void> _showClearDataConfirmation(BuildContext context) async {
    final result = await D2YModal.confirm(
      context: context,
      title: 'Reset Semua Data',
      message:
          'Apakah Anda yakin ingin menghapus semua data? '
          'Tindakan ini tidak dapat dibatalkan.',
      confirmText: 'Hapus',
      cancelText: 'Batal',
    );

    if (result == true && context.mounted) {
      context.read<SettingsBloc>().add(ClearAllData());
    }
  }
}