import 'package:d2ycredi/features/debt/domain/entities/add_debt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../domain/usecases/add_debt_usecase.dart';
import 'add_debt_event.dart';
import 'add_debt_state.dart';

class AddDebtBloc extends Bloc<AddDebtEvent, AddDebtState> {
  final AddDebtUseCase addDebtUseCase;

  AddDebtBloc({required this.addDebtUseCase}) : super(const AddDebtState()) {
    on<BorrowerNameChanged>(_onBorrowerNameChanged);
    on<AmountChanged>(_onAmountChanged);
    on<DueDateChanged>(_onDueDateChanged);
    on<ReminderDateChanged>(_onReminderDateChanged);
    on<NoteChanged>(_onNoteChanged);
    on<SubmitDebt>(_onSubmitDebt);
  }

  void _onBorrowerNameChanged(
    BorrowerNameChanged event,
    Emitter<AddDebtState> emit,
  ) {
    final name = BorrowerNameInput.dirty(event.name);
    emit(state.copyWith(borrowerName: name));
  }

  void _onAmountChanged(
    AmountChanged event,
    Emitter<AddDebtState> emit,
  ) {
    final amount = AmountInput.dirty(event.amount);
    emit(state.copyWith(amount: amount));
  }

  void _onDueDateChanged(
    DueDateChanged event,
    Emitter<AddDebtState> emit,
  ) {
    emit(state.copyWith(dueDate: event.date));
  }

  void _onReminderDateChanged(
    ReminderDateChanged event,
    Emitter<AddDebtState> emit,
  ) {
    emit(state.copyWith(reminderDate: event.date));
  }

  void _onNoteChanged(
    NoteChanged event,
    Emitter<AddDebtState> emit,
  ) {
    emit(state.copyWith(note: event.note));
  }

  Future<void> _onSubmitDebt(
    SubmitDebt event,
    Emitter<AddDebtState> emit,
  ) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final amountValue = double.parse(
      state.amount.value.replaceAll('.', '').replaceAll(',', ''),
    );

    final borrowerName = state.borrowerName.value.trim();

    final result = await addDebtUseCase(
      AddDebt(
        borrowerName: borrowerName,
        borrowerAvatar: generateAvatarFromName(borrowerName),
        amount: amountValue,
        dueDate: state.dueDate!,
        reminderDate: state.reminderDate,
        note: state.note.isEmpty ? null : state.note,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        status: FormzSubmissionStatus.success,
      )),
    );
  }

  String generateAvatarFromName(String name) {
    final encodedName = Uri.encodeComponent(name.trim());
    return 'https://ui-avatars.com/api/?name=$encodedName&background=0D8ABC&color=fff';
  }
}