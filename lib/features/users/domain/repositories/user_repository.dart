import 'package:dartz/dartz.dart';
import 'package:transactions_test_task/core/error/failure.dart';

abstract class IUserRepository {
  Future<Either<Failure, int>> login(String login, String password);

  Future<Either<Failure, int>> logout();

  Future<Either<Failure, int>> getActiveUserId();
}
