import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_test_task/features/users/presentation/bloc/user_cubit/user_cubit.dart';

class LoginForm extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();
  static final loginController = TextEditingController();
  static final passwordController = TextEditingController();

  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: loginController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Введите ваш логин',
                labelText: 'Login *',
              ),
              validator: (String? value) {
                return (value != null && value.isEmpty)
                    ? 'Обязательное поле'
                    : null;
              },
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Введите пароль',
                labelText: 'Password *',
              ),
              validator: (String? value) {
                return (value != null && value.length < 6)
                    ? 'Невалидный email'
                    : null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<UserCubit>()
                        .toLogin(loginController.text, passwordController.text);
                    loginController.clear();
                    passwordController.clear();

                    // Navigator.of(context).pop();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
