import 'dart:convert';
import 'package:d2ycredi/features/debt/data/datasources/debt_local_datasource.dart';

import '../../../../core/services/storage_service.dart';
import '../../domain/entities/app_settings.dart';

abstract class SettingsLocalDataSource {
  Future<AppSettings> getSettings();
  Future<void> saveSettings(AppSettings settings);
  Future<void> clearAllData();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final StorageService storageService;
  final DebtLocalDataSource debtLocalDataSource;
  static const String _settingsKey = 'app_settings';

  SettingsLocalDataSourceImpl({required this.storageService, required this.debtLocalDataSource});

  @override
  Future<AppSettings> getSettings() async {
    try {
      final settingsJson = await storageService.readString(_settingsKey);
      
      if (settingsJson == null) {
        return AppSettings.defaultSettings();
      }

      final Map<String, dynamic> settingsMap = json.decode(settingsJson);
      return AppSettings.fromMap(settingsMap);
    } catch (e) {
      return AppSettings.defaultSettings();
    }
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    final settingsJson = json.encode(settings.toMap());
    await storageService.writeString(_settingsKey, settingsJson);
  }

  @override
  Future<void> clearAllData() async {
    await debtLocalDataSource.clearAllDebts();
  }
}