import 'package:d2ycredi/core/usecases/usecase.dart';
import 'package:d2ycredi/features/debt/domain/repositories/debt_repository.dart';
import 'package:d2ycredi/features/debt/domain/usecases/delete_debt_usecase.dart';
import 'package:d2ycredi/features/debt/domain/usecases/get_debt_summary_usecase.dart';
import 'package:d2ycredi/features/debt/domain/usecases/get_debts_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'debt_event.dart';
import 'debt_state.dart';

class DebtBloc extends Bloc<DebtEvent, DebtState> {
  final GetDebtsUseCase getDebtsUseCase;
  final GetDebtSummaryUseCase getDebtSummaryUseCase;
  final DeleteDebtUseCase deleteDebtUseCase;
  final DebtRepository debtRepository;

  DebtBloc({
    required this.getDebtsUseCase,
    required this.getDebtSummaryUseCase,
    required this.deleteDebtUseCase,
    required this.debtRepository,
  }) : super(DebtInitial()) {
    on<LoadDebts>(_onLoadDebts);
    on<AddDebt>(_onAddDebt);
    on<UpdateDebt>(_onUpdateDebt);
    on<DeleteDebt>(_onDeleteDebt);
    on<MarkAsPaid>(_onMarkAsPaid);
    on<FilterDebts>(_onFilterDebts);
  }

  Future<void> _onLoadDebts(LoadDebts event, Emitter<DebtState> emit) async {
    emit(DebtLoading());

    final debtsResult = await getDebtsUseCase(NoParams());
    final summaryResult = await getDebtSummaryUseCase(NoParams());

    debtsResult.fold(
      (failure) => emit(DebtError(failure.message)),
      (debts) {
        summaryResult.fold(
          (failure) => emit(DebtError(failure.message)),
          (summary) => emit(DebtLoaded(debts: debts, summary: summary)),
        );
      },
    );
  }

  Future<void> _onAddDebt(AddDebt event, Emitter<DebtState> emit) async {
    final result = await debtRepository.addDebt(event.debt);

    result.fold(
      (failure) => emit(DebtError(failure.message)),
      (_) {
        add(LoadDebts());
        emit(const DebtActionSuccess('Utang berhasil ditambahkan'));
      },
    );
  }

  Future<void> _onUpdateDebt(UpdateDebt event, Emitter<DebtState> emit) async {
    final result = await debtRepository.updateDebt(event.debt);

    result.fold(
      (failure) => emit(DebtError(failure.message)),
      (_) {
        add(LoadDebts());
        emit(const DebtActionSuccess('Utang berhasil diperbarui'));
      },
    );
  }

  Future<void> _onDeleteDebt(DeleteDebt event, Emitter<DebtState> emit) async {
    final result = await deleteDebtUseCase(DeleteDebtParams(id: event.id));

    result.fold(
      (failure) => emit(DebtError(failure.message)),
      (_) {
        add(LoadDebts());
        emit(const DebtActionSuccess('Utang berhasil dihapus'));
      },
    );
  }

  Future<void> _onMarkAsPaid(MarkAsPaid event, Emitter<DebtState> emit) async {
    final result = await debtRepository.markAsPaid(event.id);

    result.fold(
      (failure) => emit(DebtError(failure.message)),
      (_) {
        add(LoadDebts());
        emit(const DebtActionSuccess('Utang berhasil dilunasi'));
      },
    );
  }

  Future<void> _onFilterDebts(
      FilterDebts event, Emitter<DebtState> emit) async {
    if (state is DebtLoaded) {
      final currentState = state as DebtLoaded;
      emit(currentState.copyWith(
        filterStatus: event.status,
        clearFilter: event.status == null,
      ));
    }
  }
}