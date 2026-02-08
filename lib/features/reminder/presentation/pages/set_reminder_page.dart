import 'package:d2ycredi/features/debt/presentation/bloc/debt/debt_bloc.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/debt/debt_event.dart';
import 'package:d2ycredi/features/reminder/presentation/widgets/reminder_option_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/widgets/d2y_button.dart';
import '../../../../core/widgets/d2y_loading.dart';
import '../../../../core/widgets/d2y_switch.dart';
import '../../../../core/widgets/d2y_toast.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/reminder.dart';
import '../bloc/reminder/reminder_bloc.dart';
import '../bloc/reminder/reminder_event.dart';
import '../bloc/reminder/reminder_state.dart';

class SetReminderPage extends StatelessWidget {
  final String debtId;

  const SetReminderPage({
    super.key,
    required this.debtId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReminderBloc(
        getDebtDetailUseCase: getIt(),
        updateReminderUseCase: getIt(),
      )..add(LoadReminderSettings(debtId)),
      child: const SetReminderView(),
    );
  }
}

class SetReminderView extends StatelessWidget {
  const SetReminderView({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Reminder',
          style: AppTextStyles.h5.copyWith(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ReminderBloc, ReminderState>(
        listener: (context, state) {
          if (state.saveSuccess) {
            D2YToast.success(context, 'Reminder berhasil disimpan');
            context.read<DebtBloc>().add(LoadDebts());
            context.pop();
          } else if (state.errorMessage != null && !state.isLoading) {
            D2YToast.error(context, state.errorMessage!);
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return D2YLoading.center(message: 'Memuat data...');
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingXL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Toggle Reminder Card
                  Container(
                    padding: const EdgeInsets.all(AppConstants.paddingLG),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(AppConstants.radiusLG),
                      border: Border.all(color: AppColor.border, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aktifkan Reminder',
                          style: AppTextStyles.h6.copyWith(
                            color: AppColor.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spaceXS),
                        Text(
                          'Dapatkan notifikasi saat jatuh tempo',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spaceMD),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            D2YCustomSwitch(
                              value: state.settings.enabled,
                              onChanged: (value) {
                                context
                                    .read<ReminderBloc>()
                                    .add(ToggleReminderEnabled(value));
                              },
                              activeColor: AppColor.primary,
                              width: 56,
                              height: 32,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppConstants.spaceXL),

                  // Jadwal Reminder Section
                  Text(
                    'Jadwal Reminder',
                    style: AppTextStyles.h6.copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: AppConstants.spaceMD),

                  // Date Picker
                  ReminderOptionItem(
                    icon: Icons.calendar_today,
                    title: 'Tanggal',
                    subtitle: 'Kapan Anda ingin diingatkan?',
                    value: state.settings.reminderDate != null
                        ? DateFormat('dd MMM yyyy', 'id')
                            .format(state.settings.reminderDate!)
                        : '24 Okt 2023',
                    enabled: state.settings.enabled,
                    onTap: () => _selectDate(context, state),
                  ),

                  const SizedBox(height: AppConstants.spaceMD),

                  // Time Picker
                  ReminderOptionItem(
                    icon: Icons.access_time,
                    title: 'Waktu',
                    subtitle: 'Jam pengiriman notifikasi',
                    value: state.settings.reminderTime ?? '09:00 AM',
                    enabled: state.settings.enabled,
                    onTap: () => _selectTime(context, state),
                  ),

                  const SizedBox(height: AppConstants.spaceMD),

                  // Frequency Picker
                  ReminderOptionItem(
                    icon: Icons.repeat,
                    title: 'Pengulangan',
                    subtitle: 'Atur frekuensi pengingat',
                    value: state.settings.frequency.displayName,
                    enabled: state.settings.enabled,
                    onTap: () => _selectFrequency(context, state),
                  ),

                  const SizedBox(height: AppConstants.spaceXXXL),

                  // Save Button
                  D2YButton(
                    label: 'Simpan Reminder',
                    icon: Icons.save_outlined,
                    onPressed: state.settings.enabled
                        ? () {
                            context
                                .read<ReminderBloc>()
                                .add(SaveReminderSettings());
                          }
                        : null,
                    fullWidth: true,
                    loading: state.isSaving,
                    disabled: !state.settings.enabled,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, ReminderState state) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: state.settings.reminderDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.primary,
              onPrimary: AppColor.white,
              surface: AppColor.white,
              onSurface: AppColor.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && context.mounted) {
      context.read<ReminderBloc>().add(UpdateReminderDate(picked));
    }
  }

  Future<void> _selectTime(BuildContext context, ReminderState state) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _parseTime(state.settings.reminderTime),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.primary,
              onPrimary: AppColor.white,
              surface: AppColor.white,
              onSurface: AppColor.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && context.mounted) {
      final formattedTime = picked.format(context);
      context.read<ReminderBloc>().add(UpdateReminderTime(formattedTime));
    }
  }

  TimeOfDay _parseTime(String? time) {
    if (time == null) return const TimeOfDay(hour: 9, minute: 0);

    try {
      final parts = time.split(':');
      var hour = int.parse(parts[0]);
      final minutePart = parts[1].split(' ');
      final minute = int.parse(minutePart[0]);
      final period = minutePart.length > 1 ? minutePart[1] : '';

      if (period.toUpperCase() == 'PM' && hour != 12) {
        hour += 12;
      } else if (period.toUpperCase() == 'AM' && hour == 12) {
        hour = 0;
      }

      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return const TimeOfDay(hour: 9, minute: 0);
    }
  }

  void _selectFrequency(BuildContext context, ReminderState state) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusXL),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppConstants.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Frekuensi',
              style: AppTextStyles.h6.copyWith(
                color: AppColor.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.spaceLG),
            ...ReminderFrequency.values.map((frequency) {
              final isSelected = state.settings.frequency == frequency;
              return ListTile(
                title: Text(
                  frequency.displayName,
                  style: TextStyle(
                    color: isSelected ? AppColor.primary : AppColor.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check, color: AppColor.primary)
                    : null,
                onTap: () {
                  context
                      .read<ReminderBloc>()
                      .add(UpdateReminderFrequency(frequency));
                  Navigator.pop(context);
                },
              );
            // ignore: unnecessary_to_list_in_spreads
            }).toList(),
            const SizedBox(height: AppConstants.spaceLG),
          ],
        ),
      ),
    );
  }
}