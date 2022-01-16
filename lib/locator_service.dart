import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transactions_test_task/features/transactions/data/datasources/transaction_local_data_sources.dart';
import 'package:transactions_test_task/features/transactions/data/datasources/transaction_remote_data_sources.dart';
import 'package:transactions_test_task/features/transactions/data/repositories/transaction_repository.dart';
import 'package:transactions_test_task/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:transactions_test_task/features/transactions/domain/usecases/add_transaction.dart';
import 'package:transactions_test_task/features/transactions/domain/usecases/cancel_transaction.dart';
import 'package:transactions_test_task/features/transactions/domain/usecases/get_all_transactions.dart';
import 'package:transactions_test_task/features/transactions/presentation/bloc/transactions_list_cubit/transactions_list_cubit.dart';
import 'package:transactions_test_task/features/users/data/datasources/user_local_data_sources.dart';
import 'package:transactions_test_task/features/users/data/datasources/user_remote_data_sources.dart';
import 'package:transactions_test_task/features/users/data/repositories/user_repository.dart';
import 'package:transactions_test_task/features/users/domain/repositories/user_repository.dart';
import 'package:transactions_test_task/features/users/domain/usecases/get_active_user_id.dart';
import 'package:transactions_test_task/features/users/domain/usecases/login.dart';
import 'package:transactions_test_task/features/users/domain/usecases/logout.dart';
import 'package:transactions_test_task/features/users/presentation/bloc/user_cubit/user_cubit.dart';



final sl = GetIt.instance;

Future<void> init() async {
  // BloC / Cubit
  sl.registerFactory(
    () => TransactionsListCubit(getAllTransactions: sl(), cancelTransaction: sl(), addTransaction: sl()),
  );

  sl.registerFactory(
        () => UserCubit(getActiveUserIdUC: sl(), logoutUC: sl(), loginUC: sl()),
  );



  // UseCases
  sl.registerLazySingleton(() => GetAllTransactions(sl()));
  sl.registerLazySingleton(() => CancelTransaction(sl()));
  sl.registerLazySingleton(() => AddTransaction(sl()));

  sl.registerLazySingleton(() => GetActiveUserId(sl()));
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));


  // Repository transactions
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


  // Repository users
  sl.registerLazySingleton<IUserRepository>(
        () => UserRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<IUserRemoteDataSource>(
        () => UserRemoteDataSource(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<IUserLocalDataSource>(
        () => UserLocalDataSource(sharedPreferences: sl()),
  );


  // Core

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
