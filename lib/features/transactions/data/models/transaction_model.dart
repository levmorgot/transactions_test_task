

import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required id,
    required amount,
    required type,
    required status,
    required fee,
    required date,
  }) : super(
          id: id,
          amount: amount,
          type: type,
          status: status,
          fee: fee,
          date: date,
        );

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: json['amount'],
      type: json['type'],
      status: json['status'],
      fee: json['fee'],
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'type': type,
      'status': status,
      'fee': fee,
      'date': date.toIso8601String(),
    };
  }
}
