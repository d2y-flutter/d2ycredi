import 'package:equatable/equatable.dart';
import '../../../domain/entities/debt.dart';

abstract class DetailDebtState extends Equatable {
  const DetailDebtState();

  @override
  List<Object?> get props => [];
}

class DetailDebtInitial extends DetailDebtState {}

class DetailDebtLoading extends DetailDebtState {}

class DetailDebtLoaded extends DetailDebtState {
  final Debt debt;

  const DetailDebtLoaded(this.debt);

  @override
  List<Object?> get props => [debt];
}

class DetailDebtError extends DetailDebtState {
  final String message;

  const DetailDebtError(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailDebtActionSuccess extends DetailDebtState {
  final String message;

  const DetailDebtActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}