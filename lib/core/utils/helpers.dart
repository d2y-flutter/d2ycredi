// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class Helpers {
  // Launch URL
  static Future<bool> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return false;
  }

  // Launch email
  static Future<bool> launchEmail(
    String email, {
    String? subject,
    String? body,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );
    
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }

  // Launch phone
  static Future<bool> launchPhone(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }

  // Launch SMS
  static Future<bool> launchSMS(String phoneNumber, {String? body}) async {
    final uri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: {
        if (body != null) 'body': body,
      },
    );
    
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }

  // Launch WhatsApp
  static Future<bool> launchWhatsApp(
    String phoneNumber, {
    String? message,
  }) async {
    final url = 'https://wa.me/$phoneNumber${message != null ? '?text=${Uri.encodeComponent(message)}' : ''}';
    return await launchURL(url);
  }

  // Share text
  static Future<void> shareText(String text, {String? subject}) async {
    await Share.share(text, subject: subject);
  }

  // Share file
  static Future<void> shareFile(String filePath, {String? text}) async {
    await Share.shareXFiles([XFile(filePath)], text: text);
  }

  // Share files
  static Future<void> shareFiles(List<String> filePaths, {String? text}) async {
    await Share.shareXFiles(
      filePaths.map((path) => XFile(path)).toList(),
      text: text,
    );
  }

  // Copy to clipboard
  static Future<void> copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copied to clipboard')),
      );
    }
  }

  // Hide keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  // Show keyboard
  static void showKeyboard(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  // Get platform
  static String getPlatform() {
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isLinux) return 'Linux';
    return 'Unknown';
  }

  // Check if mobile
  static bool isMobile() {
    return Platform.isAndroid || Platform.isIOS;
  }

  // Check if desktop
  static bool isDesktop() {
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }

  // Debounce function
  static void debounce(
    VoidCallback action, {
    Duration delay = const Duration(milliseconds: 500),
  }) {
    Future.delayed(delay, action);
  }

  // Throttle function
  static Function throttle(
    Function func, {
    Duration delay = const Duration(milliseconds: 500),
  }) {
    bool isThrottled = false;
    
    return () {
      if (!isThrottled) {
        func();
        isThrottled = true;
        Future.delayed(delay, () {
          isThrottled = false;
        });
      }
    };
  }

  // Generate random string
  static String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  // Generate UUID
  static String generateUUID() {
    return const Uuid().v4();
  }

  // Retry async function
  static Future<T> retry<T>(
    Future<T> Function() function, {
    int maxAttempts = 3,
    Duration delay = const Duration(seconds: 1),
  }) async {
    int attempt = 0;
    
    while (attempt < maxAttempts) {
      try {
        return await function();
      } catch (e) {
        attempt++;
        if (attempt >= maxAttempts) {
          rethrow;
        }
        await Future.delayed(delay);
      }
    }
    
    throw Exception('Max retry attempts reached');
  }

  // Check internet connection
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  // Delay execution
  static Future<void> delay(Duration duration) async {
    await Future.delayed(duration);
  }

  // Execute after build
  static void afterBuild(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  // Get screen size
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  // Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Check if landscape
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // Check if portrait
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  // Get status bar height
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  // Get bottom padding (safe area)
  static double getBottomPadding(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }
  
  static String getInitials(String name) {
    if (name.trim().isEmpty) return '?';

    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
  ];

  /// Convert month number (1-12) → short name
  static String monthName(int month) {
    if (month < 1 || month > 12) return '-';
    return _months[month - 1];
  }

  /// Convert month name → index (1-12)
  /// contoh: "Jan" → 1, "Des" → 12
  static int monthIndex(String monthName) {
    final index = _months.indexOf(monthName);
    return index == -1 ? 0 : index + 1;
  }
}
