import 'package:transactions_test_task/features/users/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required id,
    required login,
    required password,
  }) : super(
          id: id,
          login: login,
          password: password,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      login: json['login'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'password': password,
    };
  }
}
