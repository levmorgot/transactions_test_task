import 'package:equatable/equatable.dart';

enum TypeOperation {
  add,
  transaction,
  withdrawal
}

const Map<TypeOperation, String> typeOperationDict = {
  TypeOperation.add: "Пополнение",
  TypeOperation.transaction: "Перевод",
  TypeOperation.withdrawal: "Снятие",
};


enum Status {
  done,
  canceled,
}

const Map<TypeOperation, String> statusDict = {
  TypeOperation.add: "Пополнение",
  TypeOperation.transaction: "Перевод",
  TypeOperation.withdrawal: "Снятие",
};


class TransactionEntity extends Equatable {
  final int id;
  final double amount;
  final TypeOperation type;
  final Status status;
  final double fee;
  final DateTime date;


  const TransactionEntity({
    required this.id,
    required this.amount,
    required this.type,
    required this.status,
    required this.fee,
    required this.date,
  });

  @override
  List<Object?> get props =>
      [id, amount, type, status, fee, date];
}
