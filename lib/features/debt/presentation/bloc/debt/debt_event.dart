import 'package:d2ycredi/features/debt/domain/entities/debt.dart';
import 'package:equatable/equatable.dart';

abstract class DebtEvent extends Equatable {
  const DebtEvent();

  @override
  List<Object?> get props => [];
}

class LoadDebts extends DebtEvent {}

class AddDebt extends DebtEvent {
  final Debt debt;

  const AddDebt(this.debt);

  @override
  List<Object?> get props => [debt];
}

class UpdateDebt extends DebtEvent {
  final Debt debt;

  const UpdateDebt(this.debt);

  @override
  List<Object?> get props => [debt];
}

class DeleteDebt extends DebtEvent {
  final String id;

  const DeleteDebt(this.id);

  @override
  List<Object?> get props => [id];
}

class MarkAsPaid extends DebtEvent {
  final String id;

  const MarkAsPaid(this.id);

  @override
  List<Object?> get props => [id];
}

class FilterDebts extends DebtEvent {
  final DebtStatus? status;

  const FilterDebts(this.status);

  @override
  List<Object?> get props => [status];
}