import 'package:dartz/dartz.dart';
import 'package:transactions_test_task/core/error/failure.dart';
import 'package:transactions_test_task/core/usecases/usecase.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';
import 'package:transactions_test_task/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:transactions_test_task/features/transactions/domain/usecases/params/cancel_transaction_params.dart';

class CancelTransaction extends UseCase<TransactionEntity, CancelTransactionParams> {
  final ITransactionRepository transactionRepository;

  CancelTransaction(this.transactionRepository);

  @override
  Future<Either<Failure, TransactionEntity>> call(params) async {
    return await transactionRepository.cancelTransaction(params.id);
  }
}
