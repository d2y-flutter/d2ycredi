import 'package:equatable/equatable.dart';

enum DebtStatus { belum, lunas }

class Debt extends Equatable {
  final String id;
  final String borrowerName;
  final String borrowerAvatar;
  final double amount;
  final DateTime dueDate;
  final DateTime? loanDate;
  final DebtStatus status;
  final String? note;
  final DateTime? paidDate;
  final bool reminderEnabled;
  final DateTime? reminderDate;
  final String? reminderTime;
  final String? reminderFrequency;

  const Debt({
    required this.id,
    required this.borrowerName,
    required this.borrowerAvatar,
    required this.amount,
    required this.dueDate,
    this.loanDate,
    required this.status,
    this.note,
    this.paidDate,
    this.reminderEnabled = false,
    this.reminderDate,
    this.reminderTime,
    this.reminderFrequency,
  });

  @override
  List<Object?> get props => [
        id,
        borrowerName,
        borrowerAvatar,
        amount,
        dueDate,
        loanDate,
        status,
        note,
        paidDate,
        reminderEnabled,
        reminderDate,
        reminderTime,
        reminderFrequency,
      ];

  Debt copyWith({
    String? id,
    String? borrowerName,
    String? borrowerAvatar,
    double? amount,
    DateTime? dueDate,
    DateTime? loanDate,
    DebtStatus? status,
    String? note,
    DateTime? paidDate,
    bool? reminderEnabled,
    DateTime? reminderDate,
    String? reminderTime,
    String? reminderFrequency,
  }) {
    return Debt(
      id: id ?? this.id,
      borrowerName: borrowerName ?? this.borrowerName,
      borrowerAvatar: borrowerAvatar ?? this.borrowerAvatar,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      loanDate: loanDate ?? this.loanDate,
      status: status ?? this.status,
      note: note ?? this.note,
      paidDate: paidDate ?? this.paidDate,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderDate: reminderDate ?? this.reminderDate,
      reminderTime: reminderTime ?? this.reminderTime,
      reminderFrequency: reminderFrequency ?? this.reminderFrequency,
    );
  }

  String get statusText {
    return status == DebtStatus.lunas ? 'Belum Lunas' : 'Menunggu Pembayaran';
  }
}

class DebtSummary {
  final double totalActive;
  final double totalPaid;

  const DebtSummary({
    required this.totalActive,
    required this.totalPaid,
  });
}