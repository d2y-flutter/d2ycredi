import 'package:d2ycredi/features/debt/domain/entities/debt.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/reminder.dart';

class ReminderState extends Equatable {
  final Debt? debt;
  final ReminderSettings settings;
  final bool isLoading;
  final bool isSaving;
  final String? errorMessage;
  final bool saveSuccess;

  const ReminderState({
    this.debt,
    this.settings = const ReminderSettings(enabled: false),
    this.isLoading = false,
    this.isSaving = false,
    this.errorMessage,
    this.saveSuccess = false,
  });

  ReminderState copyWith({
    Debt? debt,
    ReminderSettings? settings,
    bool? isLoading,
    bool? isSaving,
    String? errorMessage,
    bool? saveSuccess,
  }) {
    return ReminderState(
      debt: debt ?? this.debt,
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage,
      saveSuccess: saveSuccess ?? this.saveSuccess,
    );
  }

  @override
  List<Object?> get props => [
        debt,
        settings,
        isLoading,
        isSaving,
        errorMessage,
        saveSuccess,
      ];
}