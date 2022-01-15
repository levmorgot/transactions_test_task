import 'package:json_annotation/json_annotation.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
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

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
