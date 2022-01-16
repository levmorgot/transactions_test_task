import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_test_task/common/widgets/error_message_widget.dart';
import 'package:transactions_test_task/common/widgets/loading_indicator_widget.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';
import 'package:transactions_test_task/features/transactions/presentation/bloc/transactions_list_cubit/transactions_list_cubit.dart';
import 'package:transactions_test_task/features/transactions/presentation/bloc/transactions_list_cubit/transactions_list_state.dart';
import 'package:transactions_test_task/features/transactions/presentation/widgets/transactions_chart_widget.dart';

class TransactionsChartPage extends StatelessWidget {
  const TransactionsChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsListCubit, TransactionState>(builder: (context, state) {
      List<TransactionEntity> transactions = [];
      if (state is TransactionLoadingState) {
        return const LoadingIndicator();
      } else if (state is TransactionErrorState) {
        return ErrorMessage(
          message: state.message,
        );
      } else if (state is TransactionLoadedState) {
        transactions = state.transactionsList;
      }
      return TransactionsChart(transactions: transactions);
    });
  }
}
