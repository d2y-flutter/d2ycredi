import 'package:d2ycredi/features/debt/domain/entities/update_debt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../domain/usecases/get_debt_detail_usecase.dart';
import '../../../domain/usecases/update_debt_usecase.dart';
import '../../../domain/usecases/delete_debt_usecase.dart';
import '../add_debt/add_debt_state.dart';
import 'edit_debt_event.dart';
import 'edit_debt_state.dart';

class EditDebtBloc extends Bloc<EditDebtEvent, EditDebtState> {
  final GetDebtDetailUseCase getDebtDetailUseCase;
  final UpdateDebtUseCase updateDebtUseCase;
  final DeleteDebtUseCase deleteDebtUseCase;

  EditDebtBloc({
    required this.getDebtDetailUseCase,
    required this.updateDebtUseCase,
    required this.deleteDebtUseCase,
  }) : super(const EditDebtState()) {
    on<LoadDebtDetail>(_onLoadDebtDetail);
    on<EditBorrowerNameChanged>(_onBorrowerNameChanged);
    on<EditAmountChanged>(_onAmountChanged);
    on<EditDueDateChanged>(_onDueDateChanged);
    on<EditNoteChanged>(_onNoteChanged);
    on<EditStatusChanged>(_onStatusChanged);
    on<SubmitEditDebt>(_onSubmitEditDebt);
    on<DeleteCurrentDebt>(_onDeleteCurrentDebt);
  }

  Future<void> _onLoadDebtDetail(
    LoadDebtDetail event,
    Emitter<EditDebtState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await getDebtDetailUseCase(
      GetDebtDetailParams(id: event.id),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (debt) {
        final amountStr = debt.amount.toStringAsFixed(0);
        emit(state.copyWith(
          isLoading: false,
          originalDebt: debt,
          borrowerName: BorrowerNameInput.dirty(debt.borrowerName),
          amount: AmountInput.dirty(amountStr),
          dueDate: debt.dueDate,
          note: debt.note ?? '',
          status: debt.status,
        ));
      },
    );
  }

  void _onBorrowerNameChanged(
    EditBorrowerNameChanged event,
    Emitter<EditDebtState> emit,
  ) {
    final name = BorrowerNameInput.dirty(event.name);
    emit(state.copyWith(borrowerName: name));
  }

  void _onAmountChanged(
    EditAmountChanged event,
    Emitter<EditDebtState> emit,
  ) {
    final amount = AmountInput.dirty(event.amount);
    emit(state.copyWith(amount: amount));
  }

  void _onDueDateChanged(
    EditDueDateChanged event,
    Emitter<EditDebtState> emit,
  ) {
    emit(state.copyWith(dueDate: event.date));
  }

  void _onNoteChanged(
    EditNoteChanged event,
    Emitter<EditDebtState> emit,
  ) {
    emit(state.copyWith(note: event.note));
  }

  void _onStatusChanged(
    EditStatusChanged event,
    Emitter<EditDebtState> emit,
  ) {
    emit(state.copyWith(status: event.status));
  }

  Future<void> _onSubmitEditDebt(
    SubmitEditDebt event,
    Emitter<EditDebtState> emit,
  ) async {
    if (!state.isValid || state.originalDebt == null) return;

    emit(state.copyWith(submitStatus: FormzSubmissionStatus.inProgress));

    final amountValue = double.parse(
      state.amount.value.replaceAll('.', '').replaceAll(',', ''),
    );

    final result = await updateDebtUseCase(
      UpdateDebt(
        id: state.originalDebt!.id,
        borrowerName: state.borrowerName.value,
        borrowerAvatar: state.originalDebt!.borrowerAvatar,
        amount: amountValue,
        dueDate: state.dueDate!,
        status: state.status,
        note: state.note.isEmpty ? null : state.note,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        submitStatus: FormzSubmissionStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        submitStatus: FormzSubmissionStatus.success,
      )),
    );
  }

  Future<void> _onDeleteCurrentDebt(
    DeleteCurrentDebt event,
    Emitter<EditDebtState> emit,
  ) async {
    if (state.originalDebt == null) return;

    emit(state.copyWith(submitStatus: FormzSubmissionStatus.inProgress));

    final result = await deleteDebtUseCase(
      DeleteDebtParams(id: state.originalDebt!.id),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        submitStatus: FormzSubmissionStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        submitStatus: FormzSubmissionStatus.success,
      )),
    );
  }
}