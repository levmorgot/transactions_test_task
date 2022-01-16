import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String login;
  final String password;

  const UserEntity({
    required this.id,
    required this.login,
    required this.password,
  });

  @override
  List<Object?> get props => [id, login, password];
}
