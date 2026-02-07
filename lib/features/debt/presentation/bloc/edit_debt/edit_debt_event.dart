import 'package:equatable/equatable.dart';
import '../../../domain/entities/debt.dart';

abstract class EditDebtEvent extends Equatable {
  const EditDebtEvent();

  @override
  List<Object?> get props => [];
}

class LoadDebtDetail extends EditDebtEvent {
  final String id;

  const LoadDebtDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class EditBorrowerNameChanged extends EditDebtEvent {
  final String name;

  const EditBorrowerNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class EditAmountChanged extends EditDebtEvent {
  final String amount;

  const EditAmountChanged(this.amount);

  @override
  List<Object?> get props => [amount];
}

class EditDueDateChanged extends EditDebtEvent {
  final DateTime date;

  const EditDueDateChanged(this.date);

  @override
  List<Object?> get props => [date];
}

class EditNoteChanged extends EditDebtEvent {
  final String note;

  const EditNoteChanged(this.note);

  @override
  List<Object?> get props => [note];
}

class EditStatusChanged extends EditDebtEvent {
  final DebtStatus status;

  const EditStatusChanged(this.status);

  @override
  List<Object?> get props => [status];
}

class SubmitEditDebt extends EditDebtEvent {}

class DeleteCurrentDebt extends EditDebtEvent {}