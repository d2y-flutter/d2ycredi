import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/debt.dart';

part 'debt_model.g.dart';

@JsonSerializable()
class DebtModel extends Debt {
  const DebtModel({
    required super.id,
    required super.borrowerName,
    required super.borrowerAvatar,
    required super.amount,
    required super.dueDate,
    required super.status,
    super.note,
  });

  factory DebtModel.fromJson(Map<String, dynamic> json) =>
      _$DebtModelFromJson(json);

  Map<String, dynamic> toJson() => _$DebtModelToJson(this);

  factory DebtModel.fromEntity(Debt debt) {
    return DebtModel(
      id: debt.id,
      borrowerName: debt.borrowerName,
      borrowerAvatar: debt.borrowerAvatar,
      amount: debt.amount,
      dueDate: debt.dueDate,
      status: debt.status,
      note: debt.note,
    );
  }

  factory DebtModel.fromMap(Map<String, dynamic> map) {
    return DebtModel(
      id: map['id'] as String,
      borrowerName: map['borrower_name'] as String,
      borrowerAvatar: map['borrower_avatar'] as String,
      amount: (map['amount'] as num).toDouble(),
      dueDate: DateTime.parse(map['due_date']),
      status: DebtStatus.values.byName(map['status']),
      note: map['note'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'borrower_name': borrowerName,
      'borrower_avatar': borrowerAvatar,
      'amount': amount,
      'due_date': dueDate.toIso8601String(),
      'status': status.name,
      'note': note,
    };
  }
}