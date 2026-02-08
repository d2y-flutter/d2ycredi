import 'package:d2ycredi/features/debt/domain/usecases/get_debt_detail_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/reminder.dart';
import '../../../domain/usecases/update_reminder_usecase.dart';
import 'reminder_event.dart';
import 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final GetDebtDetailUseCase getDebtDetailUseCase;
  final UpdateReminderUseCase updateReminderUseCase;

  ReminderBloc({
    required this.getDebtDetailUseCase,
    required this.updateReminderUseCase,
  }) : super(const ReminderState()) {
    on<LoadReminderSettings>(_onLoadReminderSettings);
    on<ToggleReminderEnabled>(_onToggleReminderEnabled);
    on<UpdateReminderDate>(_onUpdateReminderDate);
    on<UpdateReminderTime>(_onUpdateReminderTime);
    on<UpdateReminderFrequency>(_onUpdateReminderFrequency);
    on<SaveReminderSettings>(_onSaveReminderSettings);
  }

  Future<void> _onLoadReminderSettings(
    LoadReminderSettings event,
    Emitter<ReminderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await getDebtDetailUseCase(
      GetDebtDetailParams(id: event.debtId),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (debt) {
        final settings = ReminderSettings(
          enabled: debt.reminderEnabled,
          reminderDate: debt.reminderDate,
          reminderTime: debt.reminderTime,
          frequency: _parseFrequency(debt.reminderFrequency),
        );

        emit(state.copyWith(
          isLoading: false,
          debt: debt,
          settings: settings,
        ));
      },
    );
  }

  void _onToggleReminderEnabled(
    ToggleReminderEnabled event,
    Emitter<ReminderState> emit,
  ) {
    emit(state.copyWith(
      settings: state.settings.copyWith(enabled: event.enabled),
    ));
  }

  void _onUpdateReminderDate(
    UpdateReminderDate event,
    Emitter<ReminderState> emit,
  ) {
    emit(state.copyWith(
      settings: state.settings.copyWith(reminderDate: event.date),
    ));
  }

  void _onUpdateReminderTime(
    UpdateReminderTime event,
    Emitter<ReminderState> emit,
  ) {
    emit(state.copyWith(
      settings: state.settings.copyWith(reminderTime: event.time),
    ));
  }

  void _onUpdateReminderFrequency(
    UpdateReminderFrequency event,
    Emitter<ReminderState> emit,
  ) {
    emit(state.copyWith(
      settings: state.settings.copyWith(frequency: event.frequency),
    ));
  }

  Future<void> _onSaveReminderSettings(
    SaveReminderSettings event,
    Emitter<ReminderState> emit,
  ) async {
    if (state.debt == null) return;

    emit(state.copyWith(isSaving: true));

    final result = await updateReminderUseCase(
      UpdateReminderParams(
        debtId: state.debt!.id,
        settings: state.settings,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSaving: false,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        isSaving: false,
        saveSuccess: true,
      )),
    );
  }

  ReminderFrequency _parseFrequency(String? frequency) {
    if (frequency == null) return ReminderFrequency.once;
    
    switch (frequency) {
      case 'Setiap Hari':
        return ReminderFrequency.daily;
      case 'Setiap Minggu':
        return ReminderFrequency.weekly;
      case 'Setiap Bulan':
        return ReminderFrequency.monthly;
      default:
        return ReminderFrequency.once;
    }
  }
}