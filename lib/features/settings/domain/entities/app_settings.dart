import 'package:equatable/equatable.dart';

enum ThemeMode {
  light,
  dark,
  system,
}

enum Language {
  indonesian,
  english,
}

extension ThemeModeExtension on ThemeMode {
  String get displayName {
    switch (this) {
      case ThemeMode.light:
        return 'Light Mode';
      case ThemeMode.dark:
        return 'Dark Mode';
      case ThemeMode.system:
        return 'System Default';
    }
  }

  String get description {
    switch (this) {
      case ThemeMode.light:
        return 'Classic bright and clean interface';
      case ThemeMode.dark:
        return 'Easier on the eyes in low light';
      case ThemeMode.system:
        return 'Matches your device global settings';
    }
  }
}

extension LanguageExtension on Language {
  String get displayName {
    switch (this) {
      case Language.indonesian:
        return 'Bahasa Indonesia';
      case Language.english:
        return 'English';
    }
  }

  String get code {
    switch (this) {
      case Language.indonesian:
        return 'id';
      case Language.english:
        return 'en';
    }
  }
}

class AppSettings extends Equatable {
  final bool notificationsEnabled;
  final Language language;
  final ThemeMode themeMode;

  const AppSettings({
    required this.notificationsEnabled,
    required this.language,
    required this.themeMode,
  });

  @override
  List<Object?> get props => [notificationsEnabled, language, themeMode];

  AppSettings copyWith({
    bool? notificationsEnabled,
    Language? language,
    ThemeMode? themeMode,
  }) {
    return AppSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'notificationsEnabled': notificationsEnabled,
      'language': language.code,
      'themeMode': themeMode.index,
    };
  }

  // Create from Map
  factory AppSettings.fromMap(Map<String, dynamic> map) {
    return AppSettings(
      notificationsEnabled: map['notificationsEnabled'] ?? true,
      language: map['language'] == 'en' ? Language.english : Language.indonesian,
      themeMode: ThemeMode.values[map['themeMode'] ?? 0],
    );
  }

  // Default settings
  factory AppSettings.defaultSettings() {
    return const AppSettings(
      notificationsEnabled: true,
      language: Language.indonesian,
      themeMode: ThemeMode.light,
    );
  }
}