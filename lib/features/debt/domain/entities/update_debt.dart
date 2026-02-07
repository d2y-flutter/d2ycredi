
import 'package:d2ycredi/features/debt/domain/entities/debt.dart';
import 'package:equatable/equatable.dart';

class UpdateDebt extends Equatable {
  final String id;
  final String borrowerName;
  final String borrowerAvatar;
  final double amount;
  final DateTime dueDate;
  final DebtStatus status;
  final String? note;

  const UpdateDebt({
    required this.id,
    required this.borrowerName,
    required this.borrowerAvatar,
    required this.amount,
    required this.dueDate,
    required this.status,
    this.note,
  });

  @override
  List<Object?> get props => [
        id,
        borrowerName,
        borrowerAvatar,
        amount,
        dueDate,
        status,
        note,
      ];
}