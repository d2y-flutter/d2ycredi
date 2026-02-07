import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../../domain/entities/debt.dart';
import '../add_debt/add_debt_state.dart';

class EditDebtState extends Equatable {
  final Debt? originalDebt;
  final BorrowerNameInput borrowerName;
  final AmountInput amount;
  final DateTime? dueDate;
  final String note;
  final DebtStatus status;
  final FormzSubmissionStatus submitStatus;
  final String? errorMessage;
  final bool isLoading;

  const EditDebtState({
    this.originalDebt,
    this.borrowerName = const BorrowerNameInput.pure(),
    this.amount = const AmountInput.pure(),
    this.dueDate,
    this.note = '',
    this.status = DebtStatus.belum,
    this.submitStatus = FormzSubmissionStatus.initial,
    this.errorMessage,
    this.isLoading = false,
  });

  EditDebtState copyWith({
    Debt? originalDebt,
    BorrowerNameInput? borrowerName,
    AmountInput? amount,
    DateTime? dueDate,
    String? note,
    DebtStatus? status,
    FormzSubmissionStatus? submitStatus,
    String? errorMessage,
    bool? isLoading,
  }) {
    return EditDebtState(
      originalDebt: originalDebt ?? this.originalDebt,
      borrowerName: borrowerName ?? this.borrowerName,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      note: note ?? this.note,
      status: status ?? this.status,
      submitStatus: submitStatus ?? this.submitStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool get isValid =>
      Formz.validate([borrowerName, amount]) && dueDate != null;

  @override
  List<Object?> get props => [
        originalDebt,
        borrowerName,
        amount,
        dueDate,
        note,
        status,
        submitStatus,
        errorMessage,
        isLoading,
      ];
}