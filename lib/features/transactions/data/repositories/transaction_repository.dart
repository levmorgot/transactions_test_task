import 'package:dartz/dartz.dart';
import 'package:transactions_test_task/core/error/exception.dart';
import 'package:transactions_test_task/core/error/failure.dart';
import 'package:transactions_test_task/features/transactions/data/datasources/transaction_local_data_sources.dart';
import 'package:transactions_test_task/features/transactions/data/datasources/transaction_remote_data_sources.dart';
import 'package:transactions_test_task/features/transactions/data/models/transaction_model.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';
import 'package:transactions_test_task/features/transactions/domain/repositories/transaction_repository.dart';

class TransactionRepository implements ITransactionRepository {
  final ITransactionRemoteDataSource remoteDataSource;
  final ITransactionLocalDataSource localDataSource;

  TransactionRepository(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions() async {
    final allTransactions = await _getTransactions(() {
      return remoteDataSource.getAllTransactions();
    });
    return allTransactions.fold((failure) => Left(failure), (transactions) => Right(transactions));
  }

  Future<Either<Failure, String>> _getLastEdit() async {
    try {
      final lastEdit = await localDataSource.getLastEdit();
      return Right(lastEdit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, List<TransactionModel>>> _getTransactions(
      Future<List<TransactionModel>> Function() getTransactions) async {
    final lastEdit = await _getLastEdit();
    return lastEdit.fold((failure) => Left(failure), (date) async {
      if (date != DateTime.now().toString().substring(0, 10)) {
        try {
          final remoteTransactions = await getTransactions();
          localDataSource
              .lastEditToCache(DateTime.now().toString().substring(0, 10));
          localDataSource.transactionToCache(remoteTransactions);
          return Right(remoteTransactions);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        try {
          final localTransactions = await localDataSource.getLastTransactionsFromCache();
          return Right(localTransactions);
        } on CacheException {
          return Left(CacheFailure());
        }
      }
    });
  }

  @override
  Future<Either<Failure, TransactionEntity>> addTransaction(double amount, double fee, TypeOperation type) async {
    TransactionEntity newTransaction = await remoteDataSource.addTransactions(amount, fee, type);
    var allTransactions = await getAllTransactions();
    return allTransactions.fold((failure) => Left(failure), (transactions) {
      transactions.add(newTransaction);
      localDataSource.transactionToCache(transactions as List<TransactionModel>);
      return Right(newTransaction);
    });
  }

  @override
  Future<Either<Failure, TransactionEntity>> cancelTransaction(TransactionEntity transaction) async {
    TransactionModel oldTransaction = transaction as TransactionModel;
    TransactionEntity canceledTransaction = await remoteDataSource.cancelTransaction(oldTransaction);
    var allTransactions = await getAllTransactions();
    return allTransactions.fold((failure) => Left(failure), (transactions) {
      transactions.remove(oldTransaction);
      transactions.add(canceledTransaction);
      localDataSource.transactionToCache(transactions as List<TransactionModel>);
      return Right(canceledTransaction);
    });
  }
}
