import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import '../config/app_config.dart';

class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // =========================
  // INIT
  // =========================
  Future<void> init() async {
    tz.initializeTimeZones();

    const androidInit = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onTapNotification,
    );

    await _createAndroidChannel();
  }

  // =========================
  // ANDROID CHANNEL
  // =========================
  Future<void> _createAndroidChannel() async {
    const channel = AndroidNotificationChannel(
      AppConfig.notificationChannelId,
      AppConfig.notificationChannelName,
      description: AppConfig.notificationChannelDescription,
      importance: Importance.high,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // =========================
  // PERMISSION
  // =========================
  Future<bool> requestPermission() async {
    final androidGranted = await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // iOS permission sudah diminta di initialization
    return androidGranted ?? true;
  }

  // =========================
  // SHOW NOW
  // =========================
  Future<void> show({
    required int id,
    required String title,
    required String body,
    String? payload,
    NotificationPriority priority = NotificationPriority.high,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      AppConfig.notificationChannelId,
      AppConfig.notificationChannelName,
      channelDescription: AppConfig.notificationChannelDescription,
      importance: _mapImportance(priority),
      priority: _mapPriority(priority),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    await _plugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
      payload: payload,
    );
  }

  // =========================
  // SCHEDULE
  // =========================
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          AppConfig.notificationChannelId,
          AppConfig.notificationChannelName,
          channelDescription: AppConfig.notificationChannelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  // =========================
  // CANCEL
  // =========================
  Future<void> cancel(int id) async => _plugin.cancel(id);
  Future<void> cancelAll() async => _plugin.cancelAll();

  // =========================
  // INFO
  // =========================
  Future<List<PendingNotificationRequest>> pending() =>
      _plugin.pendingNotificationRequests();

  // =========================
  // TAP HANDLER
  // =========================
  void _onTapNotification(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null) {
      // navigate / handle payload
    }
  }

  // =========================
  // PRIORITY MAPPER
  // =========================
  Importance _mapImportance(NotificationPriority p) {
    switch (p) {
      case NotificationPriority.low:
        return Importance.low;
      case NotificationPriority.medium:
        return Importance.defaultImportance;
      case NotificationPriority.high:
        return Importance.high;
      case NotificationPriority.max:
        return Importance.max;
    }
  }

  Priority _mapPriority(NotificationPriority p) {
    switch (p) {
      case NotificationPriority.low:
        return Priority.low;
      case NotificationPriority.medium:
        return Priority.defaultPriority;
      case NotificationPriority.high:
        return Priority.high;
      case NotificationPriority.max:
        return Priority.max;
    }
  }
}

enum NotificationPriority {
  low,
  medium,
  high,
  max,
}