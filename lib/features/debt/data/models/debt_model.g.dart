// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebtModel _$DebtModelFromJson(Map<String, dynamic> json) => DebtModel(
      id: json['id'] as String,
      borrowerName: json['borrowerName'] as String,
      borrowerAvatar: json['borrowerAvatar'] as String,
      amount: (json['amount'] as num).toDouble(),
      dueDate: DateTime.parse(json['dueDate'] as String),
      status: $enumDecode(_$DebtStatusEnumMap, json['status']),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$DebtModelToJson(DebtModel instance) => <String, dynamic>{
      'id': instance.id,
      'borrowerName': instance.borrowerName,
      'borrowerAvatar': instance.borrowerAvatar,
      'amount': instance.amount,
      'dueDate': instance.dueDate.toIso8601String(),
      'status': _$DebtStatusEnumMap[instance.status]!,
      'note': instance.note,
    };

const _$DebtStatusEnumMap = {
  DebtStatus.belum: 'belum',
  DebtStatus.lunas: 'lunas',
};
