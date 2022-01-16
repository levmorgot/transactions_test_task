import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserEmptyState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoggedInState extends UserState {
  final int userId;

  const UserLoggedInState(this.userId);

  @override
  List<Object> get props => [userId];
}

class UserNotLoggedInState extends UserState {

  @override
  List<Object> get props => [];
}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
