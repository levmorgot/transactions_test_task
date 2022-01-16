import 'package:dartz/dartz.dart';
import 'package:transactions_test_task/core/error/failure.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';

abstract class ITransactionRepository {
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions();

  Future<Either<Failure, TransactionEntity>> addTransaction(double amount, double fee, String type);

  Future<Either<Failure, TransactionEntity>> cancelTransaction(TransactionEntity transaction);
}
