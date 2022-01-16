import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_test_task/core/error/failure.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';
import 'package:transactions_test_task/features/transactions/domain/usecases/add_transaction.dart';
import 'package:transactions_test_task/features/transactions/domain/usecases/cancel_transaction.dart';
import 'package:transactions_test_task/features/transactions/domain/usecases/get_all_transactions.dart';
import 'package:transactions_test_task/features/transactions/domain/usecases/params/add_transaction_params.dart';
import 'package:transactions_test_task/features/transactions/domain/usecases/params/cancel_transaction_params.dart';
import 'package:transactions_test_task/features/transactions/presentation/bloc/transactions_list_cubit/transactions_list_state.dart';

class TransactionsListCubit extends Cubit<TransactionState> {
  final GetAllTransactions getAllTransactions;
  final CancelTransaction cancelTransaction;
  final AddTransaction addTransaction;

  TransactionsListCubit(
      {required this.getAllTransactions, required this.cancelTransaction, required this.addTransaction})
      : super(TransactionEmptyState());

  void loadTransactions() async {
    if (state is TransactionLoadingState) return;

    emit(TransactionLoadingState());

    final failureOrTransactions = await getAllTransactions(null);

    emit(failureOrTransactions.fold(
        (failure) =>
            TransactionErrorState(message: _mapFailureMessage(failure)),
        (transactions) => TransactionLoadedState(transactions)));
  }

  void transactionCancel(TransactionEntity transaction) async {
    if (state is TransactionLoadingState) return;

    var currentState = state;

    emit(TransactionLoadingState());

    final failureOrTransactions = await cancelTransaction(
        CancelTransactionParams(transaction: transaction));

    emit(failureOrTransactions.fold(
        (failure) =>
            TransactionErrorState(message: _mapFailureMessage(failure)),
        (canceledTransaction) {
          var oldTransactions = (currentState as TransactionLoadedState).transactionsList;
          oldTransactions.remove(transaction);
          oldTransactions.add(canceledTransaction);
          return TransactionLoadedState(oldTransactions);
        } ));
  }

  void transactionAdd(double amount, double fee, String type) async {
    if (state is TransactionLoadingState) return;

    var currentState = state;

    emit(TransactionLoadingState());

    final failureOrTransactions = await addTransaction(
        AddTransactionParams(amount: amount, type: type, fee: fee));

    emit(failureOrTransactions.fold(
            (failure) =>
            TransactionErrorState(message: _mapFailureMessage(failure)),
            (newTransaction) {
          var oldTransactions = (currentState as TransactionLoadedState).transactionsList;
          oldTransactions.add(newTransaction);
          return TransactionLoadedState(oldTransactions);
        } ));
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server failure';
      case CacheFailure:
        return 'Cache failure';
      default:
        return 'Unexpected Error';
    }
  }
}
