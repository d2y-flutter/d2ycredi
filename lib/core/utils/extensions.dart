// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// String Extensions
extension StringExtension on String {
  // Capitalize first letter
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  // Capitalize each word
  String capitalizeWords() {
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  // Check if email is valid
  bool get isValidEmail {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(this);
  }

  // Check if phone is valid
  bool get isValidPhone {
    return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(replaceAll(RegExp(r'[\s-]'), ''));
  }

  // Check if URL is valid
  bool get isValidURL {
    return RegExp(r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b').hasMatch(this);
  }

  // Remove all whitespace
  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  // Reverse string
  String reverse() {
    return split('').reversed.join('');
  }

  // Check if string is numeric
  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  // Convert to int
  int? toIntOrNull() {
    return int.tryParse(this);
  }

  // Convert to double
  double? toDoubleOrNull() {
    return double.tryParse(this);
  }

  // Truncate with ellipsis
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  // Convert to DateTime
  DateTime? toDateTime() {
    return DateTime.tryParse(this);
  }

  // Check if palindrome
  bool get isPalindrome {
    final cleaned = toLowerCase().removeWhitespace();
    return cleaned == cleaned.reverse();
  }

  // Extract numbers from string
  String extractNumbers() {
    return replaceAll(RegExp(r'[^0-9]'), '');
  }

  // Extract letters from string
  String extractLetters() {
    return replaceAll(RegExp(r'[^a-zA-Z]'), '');
  }
}

// DateTime Extensions
extension DateTimeExtension on DateTime {
  // Format date
  String format([String pattern = 'yyyy-MM-dd']) {
    return DateFormat(pattern).format(this);
  }

  // Check if today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  // Check if yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  // Check if tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }

  // Check if same day
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  // Add days
  DateTime addDays(int days) {
    return add(Duration(days: days));
  }

  // Subtract days
  DateTime subtractDays(int days) {
    return subtract(Duration(days: days));
  }

  // Get start of day
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  // Get end of day
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  // Get start of week
  DateTime get startOfWeek {
    return subtract(Duration(days: weekday - 1)).startOfDay;
  }

  // Get end of week
  DateTime get endOfWeek {
    return add(Duration(days: 7 - weekday)).endOfDay;
  }

  // Get start of month
  DateTime get startOfMonth {
    return DateTime(year, month, 1);
  }

  // Get end of month
  DateTime get endOfMonth {
    return DateTime(year, month + 1, 0, 23, 59, 59, 999);
  }

  // Time ago string
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}y ago';
    }
  }
}

// Number Extensions
extension NumExtension on num {
  // Format as currency
  String toCurrency({String symbol = '\$', int decimalDigits = 2}) {
    return '$symbol${toStringAsFixed(decimalDigits)}';
  }

  // Format with thousand separator
  String toFormattedString({int decimalDigits = 0}) {
    final formatter = NumberFormat('#,##0${decimalDigits > 0 ? '.${'0' * decimalDigits}' : ''}');
    return formatter.format(this);
  }

  // Compact format (1K, 1M, etc)
  String toCompact() {
    if (this < 1000) return toString();
    if (this < 1000000) return '${(this / 1000).toStringAsFixed(1)}K';
    if (this < 1000000000) return '${(this / 1000000).toStringAsFixed(1)}M';
    return '${(this / 1000000000).toStringAsFixed(1)}B';
  }

  // Check if between range
  bool isBetween(num min, num max) {
    return this >= min && this <= max;
  }

  // Clamp value
  num clampValue(num min, num max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  // Convert bytes to readable format
  String toBytesString() {
    if (this < 1024) return '$this B';
    if (this < 1024 * 1024) return '${(this / 1024).toStringAsFixed(2)} KB';
    if (this < 1024 * 1024 * 1024) return '${(this / (1024 * 1024)).toStringAsFixed(2)} MB';
    return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
}

// List Extensions
extension ListExtension<T> on List<T> {
  // Check if list is empty or null
  bool get isNullOrEmpty => isEmpty;

  // Get first element or null
  T? get firstOrNull => isEmpty ? null : first;

  // Get last element or null
  T? get lastOrNull => isEmpty ? null : last;

  // Chunk list into smaller lists
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  // Remove duplicates
  List<T> removeDuplicates() {
    return toSet().toList();
  }

  // Shuffle list
  List<T> shuffled() {
    final list = List<T>.from(this);
    list.shuffle();
    return list;
  }
}

// BuildContext Extensions
extension BuildContextExtension on BuildContext {
  // Get theme
  ThemeData get theme => Theme.of(this);

  // Get text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  // Get color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // Get media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  // Get screen size
  Size get screenSize => mediaQuery.size;

  // Get screen width
  double get screenWidth => mediaQuery.size.width;

  // Get screen height
  double get screenHeight => mediaQuery.size.height;

  // Get orientation
  Orientation get orientation => mediaQuery.orientation;

  // Check if mobile
  bool get isMobile => screenWidth < 600;

  // Check if tablet
  bool get isTablet => screenWidth >= 600 && screenWidth < 900;

  // Check if desktop
  bool get isDesktop => screenWidth >= 900;

  // Show snackbar
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  // Pop navigation
  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  // Push navigation
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  // Push replacement
  Future<T?> pushReplacement<T>(Widget page) {
    return Navigator.of(this).pushReplacement<T, void>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  // Push and remove until
  Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }
}

// Color Extensions
extension ColorExtension on Color {
  // Darken color
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  // Lighten color
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  // Convert to hex string
  String toHex({bool includeAlpha = false}) {
    if (includeAlpha) {
      return '#${alpha.toRadixString(16).padLeft(2, '0')}'
          '${red.toRadixString(16).padLeft(2, '0')}'
          '${green.toRadixString(16).padLeft(2, '0')}'
          '${blue.toRadixString(16).padLeft(2, '0')}';
    }
    return '#${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';
  }
}