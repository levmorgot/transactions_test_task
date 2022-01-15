import 'package:equatable/equatable.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';

class CancelTransactionParams extends Equatable {
  final TransactionEntity transaction;

  const CancelTransactionParams(
      {required this.transaction});

  @override
  List<Object?> get props => [transaction];
}
