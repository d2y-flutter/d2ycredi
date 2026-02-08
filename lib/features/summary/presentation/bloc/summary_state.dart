import 'package:equatable/equatable.dart';
import '../../domain/entities/monthly_summary.dart';

abstract class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object?> get props => [];
}

class SummaryInitial extends SummaryState {}

class SummaryLoading extends SummaryState {}

class SummaryLoaded extends SummaryState {
  final SummaryStats stats;
  final int selectedYear;

  const SummaryLoaded({
    required this.stats,
    required this.selectedYear,
  });

  @override
  List<Object?> get props => [stats, selectedYear];

  SummaryLoaded copyWith({
    SummaryStats? stats,
    int? selectedYear,
  }) {
    return SummaryLoaded(
      stats: stats ?? this.stats,
      selectedYear: selectedYear ?? this.selectedYear,
    );
  }
}

class SummaryError extends SummaryState {
  final String message;

  const SummaryError(this.message);

  @override
  List<Object?> get props => [message];
}