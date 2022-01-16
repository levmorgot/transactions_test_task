import 'package:equatable/equatable.dart';

class AddTransactionParams extends Equatable {
  final double amount;
  final double fee;
  final String type;

  const AddTransactionParams(
      {required this.amount, required this.fee, required this.type});

  @override
  List<Object?> get props => [amount, fee, type];
}
