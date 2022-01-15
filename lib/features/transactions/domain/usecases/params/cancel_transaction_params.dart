import 'package:equatable/equatable.dart';

class CancelTransactionParams extends Equatable {
  final int id;

  const CancelTransactionParams(
      {required this.id});

  @override
  List<Object?> get props => [id];
}
