import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_test_task/common/styles/app_colors.dart';
import 'package:transactions_test_task/features/transactions/presentation/bloc/transactions_list_cubit/transactions_list_cubit.dart';
import 'package:transactions_test_task/features/transactions/presentation/pages/transactions_screen.dart';
import 'package:transactions_test_task/locator_service.dart' as di;
import 'package:transactions_test_task/locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TransactionsListCubit>(
              create: (context) => sl<TransactionsListCubit>()..loadTransactions()),

        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
            backgroundColor: AppColors.mainBackground,
            scaffoldBackgroundColor: AppColors.mainBackground,
          ),
          home: const HomePage(),
        ));
  }
}
