
import 'package:equatable/equatable.dart';

class AddDebt extends Equatable {
  final String borrowerName;
  final String borrowerAvatar;
  final double amount;
  final DateTime dueDate;
  final DateTime? reminderDate;
  final String? note;

  const AddDebt({
    required this.borrowerName,
    required this.borrowerAvatar,
    required this.amount,
    required this.dueDate,
    this.reminderDate,
    this.note,
  });

  @override
  List<Object?> get props => [
        borrowerName,
        borrowerAvatar,
        amount,
        dueDate,
        reminderDate,
        note,
      ];
}