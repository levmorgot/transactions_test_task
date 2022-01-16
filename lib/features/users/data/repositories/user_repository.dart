import 'package:dartz/dartz.dart';
import 'package:transactions_test_task/core/error/exception.dart';
import 'package:transactions_test_task/core/error/failure.dart';
import 'package:transactions_test_task/features/users/data/datasources/user_local_data_sources.dart';
import 'package:transactions_test_task/features/users/data/datasources/user_remote_data_sources.dart';
import 'package:transactions_test_task/features/users/domain/repositories/user_repository.dart';

class UserRepository implements IUserRepository {
  final IUserRemoteDataSource remoteDataSource;
  final IUserLocalDataSource localDataSource;

  UserRepository(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, int>> getActiveUserId() async {
    try {
      var activeUserId = await localDataSource.getActiveUserId();
      return Right(activeUserId);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> login(String login, String password) async {
    try {
      var user = await remoteDataSource.login(login, password);
      localDataSource.setActiveUserId(user.id);
      return Right(user.id);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> logout() async {
    try {
      var oldUserId = await localDataSource.logout();
      return Right(oldUserId);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
