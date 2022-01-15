import 'package:equatable/equatable.dart';

enum TypeOperation {
  add,
  transaction,
  withdrawal
}

const Map<String, String> typeOperationDict = {
  'add': 'Пополнение',
  'transaction': 'Перевод',
  'withdrawal': 'Снятие',
};

enum Status {
  done,
  canceled,
}

const Map<String, String> statusDict = {
  'done': 'Завершена',
  'canceled': 'Отменена',
};

class TransactionEntity extends Equatable {
  final int id;
  final double amount;
  final String type;
  final String status;
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
  List<Object?> get props => [id, amount, type, status, fee, date];
}
