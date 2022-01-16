import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_test_task/core/error/failure.dart';
import 'package:transactions_test_task/features/users/domain/usecases/get_active_user_id.dart';
import 'package:transactions_test_task/features/users/domain/usecases/login.dart';
import 'package:transactions_test_task/features/users/domain/usecases/logout.dart';
import 'package:transactions_test_task/features/users/domain/usecases/params/login_params.dart';
import 'package:transactions_test_task/features/users/presentation/bloc/user_cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetActiveUserId getActiveUserIdUC;
  final Login loginUC;
  final Logout logoutUC;

  UserCubit(
      {required this.getActiveUserIdUC,
      required this.loginUC,
      required this.logoutUC})
      : super(UserEmptyState());

  void toCheckActiveUser() async {
    if (state is UserLoadingState) return;

    emit(UserLoadingState());

    final failureOrUserId = await getActiveUserIdUC(null);

    emit(failureOrUserId
        .fold((failure) => UserErrorState(message: _mapFailureMessage(failure)),
            (userId) {
      if (userId > 0) {
        return UserLoggedInState(userId);
      }
      return UserNotLoggedInState();
    }));
  }

  void toLogin(String login, String password) async {
    if (state is UserLoadingState) return;

    emit(UserLoadingState());

    final failureOrUserId =
        await loginUC(LoginParams(login: login, password: password));

    emit(failureOrUserId
        .fold((failure) => UserErrorState(message: _mapFailureMessage(failure)),
            (userId) {
        return UserLoggedInState(userId);
    }));
  }

  void toLogout() async {
    if (state is UserLoadingState) return;

    emit(UserLoadingState());

    final failureOrUserId = await logoutUC(null);

    emit(failureOrUserId
        .fold((failure) => UserErrorState(message: _mapFailureMessage(failure)),
            (userId) {
          return UserNotLoggedInState();
        }));
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server failure';
      case CacheFailure:
        return 'Cache failure';
      default:
        return 'Unexpected Error';
    }
  }
}
