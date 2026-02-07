import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../config/app_config.dart';
import 'storage_service.dart';

class LanguageService {
  static final LanguageService _instance = LanguageService._internal();
  factory LanguageService() => _instance;
  LanguageService._internal();

  final StorageService _storageService = StorageService();

  // Supported locales
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('id', 'ID'),
  ];

  // Get current locale
  Locale getCurrentLocale(BuildContext context) {
    return context.locale;
  }

  // Change language
  Future<void> changeLanguage(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
    await _storageService.writeString(AppConfig.keyLanguage, locale.languageCode);
  }

  // Get saved language
  Future<Locale?> getSavedLanguage() async {
    final languageCode = _storageService.readString(AppConfig.keyLanguage);
    // ignore: unnecessary_null_comparison
    if (languageCode != null) {
      return supportedLocales.firstWhere(
        // ignore: unrelated_type_equality_checks
        (locale) => locale.languageCode == languageCode,
        orElse: () => supportedLocales.first,
      );
    }
    return null;
  }

  // Get language name
  String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'id':
        return 'Bahasa Indonesia';
      default:
        return locale.languageCode;
    }
  }

  // Get language flag
  String getLanguageFlag(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return '🇺🇸';
      case 'id':
        return '🇮🇩';
      default:
        return '🌐';
    }
  }
}