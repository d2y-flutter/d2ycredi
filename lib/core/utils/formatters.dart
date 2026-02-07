import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class Formatters {
  // Currency formatter
  static String currency(
    double amount, {
    String symbol = '\$',
    int decimalDigits = 2,
    String locale = 'en_US',
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  // Number formatter
  static String number(
    num value, {
    int decimalDigits = 0,
    String locale = 'en_US',
  }) {
    final formatter = NumberFormat.decimalPattern(locale);
    if (decimalDigits > 0) {
      return value.toStringAsFixed(decimalDigits);
    }
    return formatter.format(value);
  }

  // Compact number formatter (1K, 1M, etc)
  static String compactNumber(num value, {String locale = 'en_US'}) {
    final formatter = NumberFormat.compact(locale: locale);
    return formatter.format(value);
  }

  // Percentage formatter
  static String percentage(
    double value, {
    int decimalDigits = 2,
    String locale = 'en_US',
  }) {
    final formatter = NumberFormat.percentPattern(locale);
    formatter.minimumFractionDigits = decimalDigits;
    formatter.maximumFractionDigits = decimalDigits;
    return formatter.format(value / 100);
  }

  // Date formatter
  static String date(
    DateTime date, {
    String format = 'yyyy-MM-dd',
    String locale = 'en_US',
  }) {
    final formatter = DateFormat(format, locale);
    return formatter.format(date);
  }

  // Time formatter
  static String time(
    DateTime date, {
    String format = 'HH:mm',
    String locale = 'en_US',
  }) {
    final formatter = DateFormat(format, locale);
    return formatter.format(date);
  }

  // Date time formatter
  static String dateTime(
    DateTime date, {
    String format = 'yyyy-MM-dd HH:mm',
    String locale = 'en_US',
  }) {
    final formatter = DateFormat(format, locale);
    return formatter.format(date);
  }

  // Relative time formatter (e.g., "2 hours ago")
  static String relativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

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

  // Phone number formatter
  static String phoneNumber(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\D'), '');
    
    if (cleaned.length == 10) {
      return '(${cleaned.substring(0, 3)}) ${cleaned.substring(3, 6)}-${cleaned.substring(6)}';
    } else if (cleaned.length == 11) {
      return '+${cleaned.substring(0, 1)} (${cleaned.substring(1, 4)}) ${cleaned.substring(4, 7)}-${cleaned.substring(7)}';
    }
    
    return phone;
  }

  // Credit card formatter
  static String creditCard(String cardNumber) {
    final cleaned = cardNumber.replaceAll(RegExp(r'\s'), '');
    final buffer = StringBuffer();
    
    for (int i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(cleaned[i]);
    }
    
    return buffer.toString();
  }

  // File size formatter
  static String fileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    }
  }

  // Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  // Capitalize each word
  static String capitalizeWords(String text) {
    return text.split(' ').map((word) => capitalize(word)).join(' ');
  }

  // Truncate text
  static String truncate(String text, int maxLength, {String suffix = '...'}) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + suffix;
  }

  // Mask email
  static String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    
    final username = parts[0];
    final domain = parts[1];
    
    if (username.length <= 2) {
      return '${username[0]}***@$domain';
    }
    
    return '${username.substring(0, 2)}***${username[username.length - 1]}@$domain';
  }

  // Mask phone number
  static String maskPhone(String phone) {
    if (phone.length < 4) return phone;
    return '*' * (phone.length - 4) + phone.substring(phone.length - 4);
  }

  // Mask credit card
  static String maskCreditCard(String cardNumber) {
    final cleaned = cardNumber.replaceAll(RegExp(r'\s'), '');
    if (cleaned.length < 4) return cardNumber;
    
    return '*' * (cleaned.length - 4) + cleaned.substring(cleaned.length - 4);
  }
}

// Input formatters for TextFields
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    
    for (int i = 0; i < text.length && i < 10; i++) {
      if (i == 0) {
        buffer.write('(');
      }
      buffer.write(text[i]);
      if (i == 2) {
        buffer.write(') ');
      } else if (i == 5) {
        buffer.write('-');
      }
    }
    
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class CreditCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\s'), '');
    final buffer = StringBuffer();
    
    for (int i = 0; i < text.length && i < 16; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }
    
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    
    for (int i = 0; i < text.length && i < 4; i++) {
      if (i == 2) {
        buffer.write('/');
      }
      buffer.write(text[i]);
    }
    
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}