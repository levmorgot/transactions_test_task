import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_test_task/common/widgets/error_message_widget.dart';
import 'package:transactions_test_task/common/widgets/loading_indicator_widget.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';
import 'package:transactions_test_task/features/transactions/presentation/bloc/transactions_list_cubit/transactions_list_cubit.dart';
import 'package:transactions_test_task/features/transactions/presentation/bloc/transactions_list_cubit/transactions_list_state.dart';

class TransactionsChart extends StatelessWidget {
  const TransactionsChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsListCubit, TransactionState>(builder: (context, state) {
      List<TransactionEntity> transactions = [];
      if (state is TransactionLoadingState) {
        return const LoadingIndicator();
      } else if (state is TransactionErrorState) {
        return ErrorMessage(
          message: state.message,
        );
      } else if (state is TransactionLoadedState) {
        transactions = state.transactionsList;
      }
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Indicator(text: typeOperationDict[TypeOperation.values[0].name]!, isSquare: false, color: Colors.green,),
              Indicator(text: typeOperationDict[TypeOperation.values[1].name]!, isSquare: false, color: Colors.orange,),
              Indicator(text: typeOperationDict[TypeOperation.values[2].name]!, isSquare: false, color: Colors.blue,),

            ],
          ),
          Center(
            child: PieChart(
              PieChartData(
                  centerSpaceRadius: 20
                // read about it in the PieChartData section
              ),
              swapAnimationDuration: const Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, //
            ),
          ),
        ],
      );
    });
  }
}




// Indicator
class Indicator extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final bool isSquare;
  final double size;

  const Indicator({
    Key? key,
    required this.color,
    this.textColor = Colors.white,
    required this.text,
    required this.isSquare,
    this.size = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
