import 'package:dartz/dartz.dart';
import 'package:transactions_test_task/core/error/failure.dart';
import 'package:transactions_test_task/core/usecases/usecase.dart';
import 'package:transactions_test_task/features/users/domain/repositories/user_repository.dart';
import 'package:transactions_test_task/features/users/domain/usecases/params/login_params.dart';

class Login extends UseCase<int, LoginParams> {
  final IUserRepository userRepository;

  Login(this.userRepository);

  @override
  Future<Either<Failure, int>> call(params) async {
    return await userRepository.login(params.login, params.password);
  }
}
