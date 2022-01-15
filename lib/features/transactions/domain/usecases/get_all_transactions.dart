import 'package:dartz/dartz.dart';
import 'package:transactions_test_task/core/error/failure.dart';
import 'package:transactions_test_task/core/usecases/usecase.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';
import 'package:transactions_test_task/features/transactions/domain/repositories/transaction_repository.dart';

class GetAllTransactions extends UseCase<List<TransactionEntity>, void> {
  final ITransactionRepository transactionRepository;

  GetAllTransactions(this.transactionRepository);

  @override
  Future<Either<Failure, List<TransactionEntity>>> call(params) async {
    return await transactionRepository.getAllTransactions();
  }
}
