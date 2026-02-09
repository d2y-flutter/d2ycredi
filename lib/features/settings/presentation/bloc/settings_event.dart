import 'package:equatable/equatable.dart';
import '../../domain/entities/app_settings.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class UpdateNotificationSettings extends SettingsEvent {
  final bool enabled;

  const UpdateNotificationSettings(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class UpdateLanguage extends SettingsEvent {
  final Language language;

  const UpdateLanguage(this.language);

  @override
  List<Object?> get props => [language];
}

class UpdateThemeMode extends SettingsEvent {
  final ThemeMode themeMode;

  const UpdateThemeMode(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class ClearAllData extends SettingsEvent {}