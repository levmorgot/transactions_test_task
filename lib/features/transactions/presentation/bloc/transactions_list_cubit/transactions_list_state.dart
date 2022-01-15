import 'package:equatable/equatable.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionEmptyState extends TransactionState {
  @override
  List<Object> get props => [];
}

class TransactionLoadingState extends TransactionState {
  @override
  List<Object> get props => [];
}

class TransactionLoadedState extends TransactionState {
  final List<TransactionEntity> transactionsList;

  const TransactionLoadedState(this.transactionsList);

  @override
  List<Object> get props => [transactionsList];
}

class TransactionErrorState extends TransactionState {
  final String message;

  const TransactionErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
