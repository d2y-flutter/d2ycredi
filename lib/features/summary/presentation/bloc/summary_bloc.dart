import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_summary_stats_usecase.dart';
import 'summary_event.dart';
import 'summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final GetSummaryStatsUseCase getSummaryStatsUseCase;

  SummaryBloc({
    required this.getSummaryStatsUseCase,
  }) : super(SummaryInitial()) {
    on<LoadSummaryStats>(_onLoadSummaryStats);
    on<ChangeSelectedYear>(_onChangeSelectedYear);
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
    }
  }
}