import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future<void> writeString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> writeBool(String key, bool value) async {
    await _storage.write(key: key, value: value.toString());
  }

  Future<String?> readString(String key) async {
    return await _storage.read(key: key);
  }

  Future<bool?> readBool(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;
    return value.toLowerCase() == 'true';
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}