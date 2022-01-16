import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String login;
  final String password;

  const LoginParams(
      {required this.login, required this.password});

  @override
  List<Object?> get props => [login, password];
}
