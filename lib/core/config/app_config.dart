enum AppEnvironment {
  development,
  staging,
  production,
}

class AppConfig {
  AppConfig._();

  /// ======================
  /// Environment
  /// ======================
  static const AppEnvironment environment = AppEnvironment.development;

  static bool get isProduction => environment == AppEnvironment.production;
  static bool get isStaging => environment == AppEnvironment.staging;
  static bool get isDevelopment => environment == AppEnvironment.development;

  /// ======================
  /// App Info
  /// ======================
  static const String appName = 'D2YCredi App';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  /// ======================
  /// API Configuration
  /// ======================
  static const String baseUrl = 'https://api.example.com';
  static const String apiKey = 'your_api_key_here';

  static const int apiTimeout = 30000;
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  /// ======================
  /// Firebase Configuration
  /// ======================
  static const String firebaseApiKey = 'your_firebase_api_key';
  static const String firebaseAppId = 'your_firebase_app_id';
  static const String firebaseMessagingSenderId = 'your_sender_id';
  static const String firebaseProjectId = 'your_project_id';

  /// ======================
  /// OAuth Configuration
  /// ======================
  static const String googleClientId = 'your_google_client_id';
  static const String googleClientSecret = 'your_google_client_secret';

  /// ======================
  /// Feature Flags
  /// ======================
  static const bool enableAnalytics = true;
  static const bool enableCrashlytics = true;
  static const bool enableDebugMode = false;
  static const bool enableChucker = true;

  /// ======================
  /// Storage Keys
  /// ======================
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserData = 'user_data';
  static const String keyLanguage = 'language';
  static const String keyThemeMode = 'theme_mode';
  static const String keyFirstLaunch = 'first_launch';
  static const String keyNotificationEnabled = 'notification_enabled';
  static const String keyBiometricEnabled = 'biometric_enabled';

  /// ======================
  /// Database Configuration
  /// ======================
  static const String databaseName = 'd2y_database.db';
  static const int databaseVersion = 1;

  /// ======================
  /// Pagination
  /// ======================
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  /// ======================
  /// Image Configuration
  /// ======================
  static const int maxImageQuality = 85;
  static const int maxImageWidth = 1920;
  static const int maxImageHeight = 1920;
  static const double maxImageSizeInMB = 5;

  /// ======================
  /// Cache Configuration
  /// ======================
  static const Duration cacheMaxAge = Duration(days: 7);
  static const int maxCacheObjects = 200;

  /// ======================
  /// Notification Configuration
  /// ======================
  static const String notificationChannelId = 'd2y_notifications';
  static const String notificationChannelName = 'D2Y Notifications';
  static const String notificationChannelDescription =
      'Notifications from D2Y App';

  /// ======================
  /// Deep Link Configuration
  /// ======================
  static const String deepLinkScheme = 'd2yapp';
  static const String deepLinkHost = 'app.d2y.com';

  /// ======================
  /// Social Share
  /// ======================
  static const String shareHashtag = '#D2YApp';
  static const String shareUrlScheme = 'https://d2y.com/share';

  /// ======================
  /// Rate Limiting
  /// ======================
  static const int maxRequestsPerMinute = 60;
  static const Duration rateLimitWindow = Duration(minutes: 1);

  /// ======================
  /// Session Configuration
  /// ======================
  static const Duration sessionTimeout = Duration(hours: 24);
  static const Duration refreshTokenBeforeExpiry = Duration(minutes: 5);
}