import '../services/storage_service.dart';
import '../config/app_config.dart';
import '../../injection_container.dart';

class RouteGuard {
  static Future<bool> isAuthenticated() async {
    final storage = getIt<StorageService>();
    final token = await storage.readString(AppConfig.keyAccessToken);
    return token != null && token.isNotEmpty;
  }

  static Future<bool> isFirstLaunch() async {
    final storage = getIt<StorageService>();
    final firstLaunch = await storage.readBool(AppConfig.keyFirstLaunch);
    return firstLaunch ?? true;
  }

  static Future<void> setFirstLaunchCompleted() async {
    final storage = getIt<StorageService>();
    await storage.writeBool(AppConfig.keyFirstLaunch, false);
  }

  static Future<void> clearAuthentication() async {
    final storage = getIt<StorageService>();
    await storage.delete(AppConfig.keyAccessToken);
    await storage.delete(AppConfig.keyRefreshToken);
    await storage.delete(AppConfig.keyUserId);
    await storage.delete(AppConfig.keyUserData);
  }
}