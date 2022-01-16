import 'package:flutter/material.dart';
import 'package:transactions_test_task/features/transactions/presentation/widgets/transactions_chart_widget.dart';
import 'package:transactions_test_task/features/transactions/presentation/widgets/transactions_list_widget.dart';
import 'package:transactions_test_task/features/users/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {
                context
                    .read<UserCubit>()
                    .toLogout();
              }, icon: Icon(Icons.logout))
            ],
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.money)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
            title: const Text('Транзакции'),
            centerTitle: true,
          ),
          body: const TabBarView(
            children: [
              TransactionsList(),
              TransactionsChart(),
            ],
          ),
        ),
    );
  }
}

//
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Список транзакций'),
//         centerTitle: true,
//         bo
//       ),
//       body: const TransactionsList(),
//     );
//   }
// }
