import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

enum AddDebtValidationError { empty, invalid }

class BorrowerNameInput extends FormzInput<String, AddDebtValidationError> {
  const BorrowerNameInput.pure() : super.pure('');
  const BorrowerNameInput.dirty([super.value = '']) : super.dirty();

  @override
  AddDebtValidationError? validator(String value) {
    if (value.isEmpty) return AddDebtValidationError.empty;
    if (value.length < 3) return AddDebtValidationError.invalid;
    return null;
  }
}

class AmountInput extends FormzInput<String, AddDebtValidationError> {
  const AmountInput.pure() : super.pure('');
  const AmountInput.dirty([super.value = '']) : super.dirty();

  @override
  AddDebtValidationError? validator(String value) {
    if (value.isEmpty) return AddDebtValidationError.empty;
    final amount = double.tryParse(value.replaceAll('.', '').replaceAll(',', ''));
    if (amount == null || amount <= 0) return AddDebtValidationError.invalid;
    return null;
  }
}

class AddDebtState extends Equatable {
  final BorrowerNameInput borrowerName;
  final AmountInput amount;
  final DateTime? dueDate;
  final DateTime? reminderDate;
  final String note;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  const AddDebtState({
    this.borrowerName = const BorrowerNameInput.pure(),
    this.amount = const AmountInput.pure(),
    this.dueDate,
    this.reminderDate,
    this.note = '',
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  AddDebtState copyWith({
    BorrowerNameInput? borrowerName,
    AmountInput? amount,
    DateTime? dueDate,
    DateTime? reminderDate,
    String? note,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return AddDebtState(
      borrowerName: borrowerName ?? this.borrowerName,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      reminderDate: reminderDate ?? this.reminderDate,
      note: note ?? this.note,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isValid =>
      Formz.validate([borrowerName, amount]) && dueDate != null;

  @override
  List<Object?> get props => [
        borrowerName,
        amount,
        dueDate,
        reminderDate,
        note,
        status,
        errorMessage,
      ];
}