import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transactions_test_task/features/transactions/data/datasources/transaction_local_data_sources.dart';
import 'package:transactions_test_task/features/transactions/data/datasources/transaction_remote_data_sources.dart';
import 'package:transactions_test_task/features/transactions/data/repositories/transaction_repository.dart';
import 'package:transactions_test_task/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:transactions_test_task/features/transactions/domain/usecases/get_all_transactions.dart';
import 'package:transactions_test_task/features/transactions/presentation/bloc/transactions_list_cubit/transactions_list_cubit.dart';



final sl = GetIt.instance;

Future<void> init() async {
  // BloC / Cubit
  sl.registerFactory(
    () => TransactionsListCubit(getAllTransactions: sl()),
  );



  // UseCases
  sl.registerLazySingleton(() => GetAllTransactions(sl()));


  // Repository users
  sl.registerLazySingleton<ITransactionRepository>(
    () => TransactionRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<ITransactionRemoteDataSource>(
    () => TransactionRemoteDataSource(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<ITransactionLocalDataSource>(
    () => TransactionLocalDataSource(sharedPreferences: sl()),
  );


  // Core

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
