import 'package:flutter/material.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';
import 'package:transactions_test_task/features/transactions/presentation/bloc/transactions_list_cubit/transactions_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionCancelButton extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionCancelButton({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {
      context
          .read<TransactionsListCubit>().transactionCancel(transaction);
      Navigator.of(context).pop();
    }, child: const Text('Отменить'));
  }

}
