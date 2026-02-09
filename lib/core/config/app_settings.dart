import 'package:d2ycredi/features/settings/domain/entities/app_settings.dart';
import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  final bool notificationsEnabled;
  final ThemeMode themeMode;
  final Language language;

  const AppSettings({
    required this.notificationsEnabled,
    required this.themeMode,
    required this.language,
  });

  AppSettings copyWith({
    bool? notificationsEnabled,
    ThemeMode? themeMode,
    Language? language,
  }) {
    return AppSettings(
      notificationsEnabled:
          notificationsEnabled ?? this.notificationsEnabled,
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props =>
      [notificationsEnabled, themeMode, language];
}