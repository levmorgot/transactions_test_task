import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_test_task/common/widgets/error_message_widget.dart';
import 'package:transactions_test_task/common/widgets/loading_indicator_widget.dart';
import 'package:transactions_test_task/features/transactions/presentation/pages/transactions_screen.dart';
import 'package:transactions_test_task/features/users/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:transactions_test_task/features/users/presentation/bloc/user_cubit/user_state.dart';
import 'package:transactions_test_task/features/users/presentation/widgets/login_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        if (state is UserLoadingState) {
          return const LoadingIndicator();
        } else if (state is UserErrorState) {
          return ErrorMessage(
            message: state.message,
          );
        } else if (state is UserLoggedInState) {
          return const TransactionsPage();
        } else {
          return const LoginForm();
        }

      });
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
//       body: const UsersList(),
//     );
//   }
// }
