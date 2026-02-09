import 'package:equatable/equatable.dart';

abstract class SummaryEvent extends Equatable {
  const SummaryEvent();

  @override
  List<Object?> get props => [];
}

class LoadSummaryStats extends SummaryEvent {}

class ChangeSelectedYear extends SummaryEvent {
  final int year;

  const ChangeSelectedYear(this.year);

  @override
  List<Object?> get props => [year];
}

class FilterByYear extends SummaryEvent {
  final int year;

  const FilterByYear(this.year);

  @override
  List<Object?> get props => [year];
}