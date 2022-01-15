import 'package:equatable/equatable.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';

class AddTransactionParams extends Equatable {
  final double amount;
  final double fee;
  final TypeOperation type;

  const AddTransactionParams(
      {required this.amount, required this.fee, required this.type});

  @override
  List<Object?> get props => [amount, fee, type];
}
