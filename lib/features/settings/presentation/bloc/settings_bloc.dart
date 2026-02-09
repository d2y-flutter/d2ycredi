import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/update_settings_usecase.dart';
import '../../domain/repositories/settings_repository.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUseCase getSettingsUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;
  final SettingsRepository settingsRepository;

  SettingsBloc({
    required this.getSettingsUseCase,
    required this.updateSettingsUseCase,
    required this.settingsRepository,
  }) : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateNotificationSettings>(_onUpdateNotificationSettings);
    on<UpdateLanguage>(_onUpdateLanguage);
    on<UpdateThemeMode>(_onUpdateThemeMode);
    on<ClearAllData>(_onClearAllData);
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());

    final result = await getSettingsUseCase(NoParams());

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (settings) => emit(SettingsLoaded(settings)),
    );
  }

  Future<void> _onUpdateNotificationSettings(
    UpdateNotificationSettings event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is! SettingsLoaded) return;

    final currentSettings = (state as SettingsLoaded).settings;
    final updatedSettings = currentSettings.copyWith(
      notificationsEnabled: event.enabled,
    );

    final result = await updateSettingsUseCase(
      UpdateSettingsParams(settings: updatedSettings),
    );

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) {
        emit(SettingsLoaded(updatedSettings));
        emit(const SettingsUpdateSuccess('Notifikasi berhasil diperbarui'));
        emit(SettingsLoaded(updatedSettings));
      },
    );
  }

  Future<void> _onUpdateLanguage(
    UpdateLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is! SettingsLoaded) return;

    final currentSettings = (state as SettingsLoaded).settings;
    final updatedSettings = currentSettings.copyWith(
      language: event.language,
    );

    final result = await updateSettingsUseCase(
      UpdateSettingsParams(settings: updatedSettings),
    );

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) {
        emit(SettingsLoaded(updatedSettings));
        emit(const SettingsUpdateSuccess('Bahasa berhasil diubah'));
        emit(SettingsLoaded(updatedSettings));
      },
    );
  }

  Future<void> _onUpdateThemeMode(
    UpdateThemeMode event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is! SettingsLoaded) return;

    final currentSettings = (state as SettingsLoaded).settings;
    final updatedSettings = currentSettings.copyWith(
      themeMode: event.themeMode,
    );

    final result = await updateSettingsUseCase(
      UpdateSettingsParams(settings: updatedSettings),
    );

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) {
        emit(SettingsLoaded(updatedSettings));
        emit(const SettingsUpdateSuccess('Tema berhasil diubah'));
        emit(SettingsLoaded(updatedSettings));
      },
    );
  }

  Future<void> _onClearAllData(
    ClearAllData event,
    Emitter<SettingsState> emit,
  ) async {
    final result = await settingsRepository.clearAllData();

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) {
        emit(const SettingsUpdateSuccess('Semua data berhasil dihapus'));
        add(LoadSettings());
      },
    );
  }
}