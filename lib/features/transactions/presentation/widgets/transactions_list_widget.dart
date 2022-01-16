import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_test_task/common/widgets/error_message_widget.dart';
import 'package:transactions_test_task/common/widgets/loading_indicator_widget.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';
import 'package:transactions_test_task/features/transactions/presentation/bloc/transactions_list_cubit/transactions_list_cubit.dart';
import 'package:transactions_test_task/features/transactions/presentation/bloc/transactions_list_cubit/transactions_list_state.dart';
import 'package:transactions_test_task/features/transactions/presentation/widgets/transactions_card_widget.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TransactionsListCubit>().loadTransactions();
    return BlocBuilder<TransactionsListCubit, TransactionState>(
        builder: (context, state) {
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
      return SizedBox(
        child: ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Общее количесво транзакций ${transactions.length}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      )),
                  TransactionCard(transaction: transactions[index]),
                ],
              );
            } else {
              return TransactionCard(transaction: transactions[index]);
            }
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[400],
            );
          },
          itemCount: transactions.length,
        ),
      );
    });
  }
}
