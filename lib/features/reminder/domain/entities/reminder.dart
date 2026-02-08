import 'package:equatable/equatable.dart';

enum ReminderFrequency {
  once,
  daily,
  weekly,
  monthly,
}

extension ReminderFrequencyExtension on ReminderFrequency {
  String get displayName {
    switch (this) {
      case ReminderFrequency.once:
        return 'Sekali';
      case ReminderFrequency.daily:
        return 'Setiap Hari';
      case ReminderFrequency.weekly:
        return 'Setiap Minggu';
      case ReminderFrequency.monthly:
        return 'Setiap Bulan';
    }
  }
}

class ReminderSettings extends Equatable {
  final bool enabled;
  final DateTime? reminderDate;
  final String? reminderTime;
  final ReminderFrequency frequency;

  const ReminderSettings({
    required this.enabled,
    this.reminderDate,
    this.reminderTime,
    this.frequency = ReminderFrequency.once,
  });

  @override
  List<Object?> get props => [enabled, reminderDate, reminderTime, frequency];

  ReminderSettings copyWith({
    bool? enabled,
    DateTime? reminderDate,
    String? reminderTime,
    ReminderFrequency? frequency,
  }) {
    return ReminderSettings(
      enabled: enabled ?? this.enabled,
      reminderDate: reminderDate ?? this.reminderDate,
      reminderTime: reminderTime ?? this.reminderTime,
      frequency: frequency ?? this.frequency,
    );
  }
}