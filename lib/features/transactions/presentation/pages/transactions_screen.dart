import 'package:flutter/material.dart';
import 'package:transactions_test_task/features/transactions/presentation/widgets/transactions_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список транзакций'),
        centerTitle: true,
      ),
      body: const TransactionsList(),
    );
  }
}
