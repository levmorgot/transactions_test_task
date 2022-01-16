import 'package:flutter/material.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';
import 'package:transactions_test_task/features/transactions/presentation/widgets/transaction_cancel_button_widget.dart';
import 'package:transactions_test_task/features/transactions/presentation/widgets/transaction_info_widget.dart';

class TransactionDetailPage extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionDetailPage({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(transaction.id.toString()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            children: [
              TransactionInfo(transaction: transaction),
              transaction.status == statusDict[Status.done.name.toString()]
                  ? TransactionCancelButton(transaction: transaction)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
