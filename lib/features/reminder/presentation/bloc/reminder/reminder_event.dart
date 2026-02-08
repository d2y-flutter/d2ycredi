import 'package:equatable/equatable.dart';
import '../../../domain/entities/reminder.dart';

abstract class ReminderEvent extends Equatable {
  const ReminderEvent();

  @override
  List<Object?> get props => [];
}

class LoadReminderSettings extends ReminderEvent {
  final String debtId;

  const LoadReminderSettings(this.debtId);

  @override
  List<Object?> get props => [debtId];
}

class ToggleReminderEnabled extends ReminderEvent {
  final bool enabled;

  const ToggleReminderEnabled(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class UpdateReminderDate extends ReminderEvent {
  final DateTime date;

  const UpdateReminderDate(this.date);

  @override
  List<Object?> get props => [date];
}

class UpdateReminderTime extends ReminderEvent {
  final String time;

  const UpdateReminderTime(this.time);

  @override
  List<Object?> get props => [time];
}

class UpdateReminderFrequency extends ReminderEvent {
  final ReminderFrequency frequency;

  const UpdateReminderFrequency(this.frequency);

  @override
  List<Object?> get props => [frequency];
}

class SaveReminderSettings extends ReminderEvent {}