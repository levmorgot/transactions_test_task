import 'package:dartz/dartz.dart';
import 'package:transactions_test_task/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
