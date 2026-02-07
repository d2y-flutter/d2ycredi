import 'package:equatable/equatable.dart';

abstract class AddDebtEvent extends Equatable {
  const AddDebtEvent();

  @override
  List<Object?> get props => [];
}

class BorrowerNameChanged extends AddDebtEvent {
  final String name;

  const BorrowerNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class AmountChanged extends AddDebtEvent {
  final String amount;

  const AmountChanged(this.amount);

  @override
  List<Object?> get props => [amount];
}

class DueDateChanged extends AddDebtEvent {
  final DateTime date;

  const DueDateChanged(this.date);

  @override
  List<Object?> get props => [date];
}

class ReminderDateChanged extends AddDebtEvent {
  final DateTime? date;

  const ReminderDateChanged(this.date);

  @override
  List<Object?> get props => [date];
}

class NoteChanged extends AddDebtEvent {
  final String note;

  const NoteChanged(this.note);

  @override
  List<Object?> get props => [note];
}

class SubmitDebt extends AddDebtEvent {}