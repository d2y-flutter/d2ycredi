import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_summary_stats_usecase.dart';
import '../../domain/repositories/summary_repository.dart';
import 'summary_event.dart';
import 'summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final GetSummaryStatsUseCase getSummaryStatsUseCase;
  final SummaryRepository summaryRepository;

  SummaryBloc({
    required this.getSummaryStatsUseCase,
    required this.summaryRepository,
  }) : super(SummaryInitial()) {
    on<LoadSummaryStats>(_onLoadSummaryStats);
    on<ChangeSelectedYear>(_onChangeSelectedYear);
    on<FilterByYear>(_onFilterByYear);
  }

  Future<void> _onLoadSummaryStats(
    LoadSummaryStats event,
    Emitter<SummaryState> emit,
  ) async {
    emit(SummaryLoading());

    final result = await getSummaryStatsUseCase(NoParams());

    result.fold(
      (failure) => emit(SummaryError(failure.message)),
      (stats) => emit(SummaryLoaded(
        stats: stats,
        selectedYear: DateTime.now().year,
      )),
    );
  }

  void _onChangeSelectedYear(
    ChangeSelectedYear event,
    Emitter<SummaryState> emit,
  ) {
    if (state is SummaryLoaded) {
      final currentState = state as SummaryLoaded;
      emit(currentState.copyWith(selectedYear: event.year));
      add(FilterByYear(event.year));
    }
  }

  Future<void> _onFilterByYear(
    FilterByYear event,
    Emitter<SummaryState> emit,
  ) async {
    if (state is! SummaryLoaded) return;

    final currentState = state as SummaryLoaded;
    emit(currentState.copyWith(selectedYear: event.year));

    // Reload monthly history for selected year
    final result = await summaryRepository.getMonthlyHistory(year: event.year);

    result.fold(
      (failure) => emit(SummaryError(failure.message)),
      (monthlyData) {
        final updatedStats = currentState.stats.copyWith(
          monthlyData: monthlyData,
        );
        emit(currentState.copyWith(
          stats: updatedStats,
          selectedYear: event.year,
        ));
      },
    );
  }
}