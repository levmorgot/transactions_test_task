import 'package:dartz/dartz.dart';
import 'package:transactions_test_task/core/error/failure.dart';
import 'package:transactions_test_task/core/usecases/usecase.dart';
import 'package:transactions_test_task/features/users/domain/repositories/user_repository.dart';

class Logout extends UseCase<int, void> {
  final IUserRepository userRepository;

  Logout(this.userRepository);

  @override
  Future<Either<Failure, int>> call(params) async {
    return await userRepository.logout();
  }
}
