import 'package:equatable/equatable.dart';

abstract class DetailDebtEvent extends Equatable {
  const DetailDebtEvent();

  @override
  List<Object?> get props => [];
}

class LoadDebtDetailEvent extends DetailDebtEvent {
  final String id;

  const LoadDebtDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class MarkDebtAsPaid extends DetailDebtEvent {
  final String id;

  const MarkDebtAsPaid(this.id);

  @override
  List<Object?> get props => [id];
}

class NavigateToSetReminder extends DetailDebtEvent {
  final String id;

  const NavigateToSetReminder(this.id);

  @override
  List<Object?> get props => [id];
}