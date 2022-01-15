// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: json['id'],
      amount: json['amount'],
      type: json['type'],
      status: json['status'],
      fee: json['fee'],
      date: json['date'],
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'type': _$TypeOperationEnumMap[instance.type],
      'status': _$StatusEnumMap[instance.status],
      'fee': instance.fee,
      'date': instance.date.toIso8601String(),
    };

const _$TypeOperationEnumMap = {
  TypeOperation.add: 'add',
  TypeOperation.transaction: 'transaction',
  TypeOperation.withdrawal: 'withdrawal',
};

const _$StatusEnumMap = {
  Status.done: 'done',
  Status.canceled: 'canceled',
};
