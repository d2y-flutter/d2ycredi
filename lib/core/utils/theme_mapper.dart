import 'package:flutter/material.dart';
import 'package:d2ycredi/features/settings/domain/entities/app_settings.dart' as domain;

class ThemeMapper {
  static ThemeMode toFlutter(domain.ThemeMode mode) {
    switch (mode) {
      case domain.ThemeMode.light:
        return ThemeMode.light;
      case domain.ThemeMode.dark:
        return ThemeMode.dark;
      case domain.ThemeMode.system:
        return ThemeMode.system;
    }
  }

  static domain.ThemeMode fromFlutter(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return domain.ThemeMode.light;
      case ThemeMode.dark:
        return domain.ThemeMode.dark;
      case ThemeMode.system:
      // ignore: unreachable_switch_default
      default:
        return domain.ThemeMode.system;
    }
  }
}