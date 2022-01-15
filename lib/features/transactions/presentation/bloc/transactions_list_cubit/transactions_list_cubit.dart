import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_test_task/core/error/failure.dart';
import 'package:transactions_test_task/features/transactions/domain/usecases/get_all_transactions.dart';
import 'package:transactions_test_task/features/transactions/presentation/bloc/transactions_list_cubit/transactions_list_state.dart';

class TransactionsListCubit extends Cubit<TransactionState> {
  final GetAllTransactions getAllTransactions;

  TransactionsListCubit({required this.getAllTransactions}) : super(TransactionEmptyState());

  void loadTransactions() async {
    if (state is TransactionLoadingState) return;

    emit(TransactionLoadingState());

    final failureOrTransactions = await getAllTransactions(null);

    emit(failureOrTransactions.fold(
        (failure) => TransactionErrorState(message: _mapFailureMessage(failure)),
        (transactions) => TransactionLoadedState(transactions)));
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
