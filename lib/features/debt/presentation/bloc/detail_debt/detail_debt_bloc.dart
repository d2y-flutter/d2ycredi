import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_debt_detail_usecase.dart';
import '../../../domain/usecases/mark_as_paid_usecase.dart';
import 'detail_debt_event.dart';
import 'detail_debt_state.dart';

class DetailDebtBloc extends Bloc<DetailDebtEvent, DetailDebtState> {
  final GetDebtDetailUseCase getDebtDetailUseCase;
  final MarkAsPaidUseCase markAsPaidUseCase;

  DetailDebtBloc({
    required this.getDebtDetailUseCase,
    required this.markAsPaidUseCase,
  }) : super(DetailDebtInitial()) {
    on<LoadDebtDetailEvent>(_onLoadDebtDetail);
    on<MarkDebtAsPaid>(_onMarkAsPaid);
  }

  Future<void> _onLoadDebtDetail(
    LoadDebtDetailEvent event,
    Emitter<DetailDebtState> emit,
  ) async {
    emit(DetailDebtLoading());

    final result = await getDebtDetailUseCase(
      GetDebtDetailParams(id: event.id),
    );

    result.fold(
      (failure) => emit(DetailDebtError(failure.message)),
      (debt) => emit(DetailDebtLoaded(debt)),
    );
  }

  Future<void> _onMarkAsPaid(
    MarkDebtAsPaid event,
    Emitter<DetailDebtState> emit,
  ) async {
    final result = await markAsPaidUseCase(
      MarkAsPaidParams(id: event.id),
    );

    result.fold(
      (failure) => emit(DetailDebtError(failure.message)),
      (debt) {
        emit(const DetailDebtActionSuccess('Utang berhasil ditandai lunas'));
        emit(DetailDebtLoaded(debt));
      },
    );
  }
}