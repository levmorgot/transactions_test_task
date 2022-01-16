import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';

class TransactionsChart extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const TransactionsChart({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [
      _gerPercents(typeOperationDict[TypeOperation.add.name.toString()]!),
      _gerPercents(
          typeOperationDict[TypeOperation.transaction.name.toString()]!),
      _gerPercents(
          typeOperationDict[TypeOperation.withdrawal.name.toString()]!),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      //Initialize the spark charts widget
      child: SfCircularChart(
        title: ChartTitle(text: 'Типы транцакций'),
        legend: Legend(isVisible: true),
        series: <DoughnutSeries<_SalesData, String>>[
          DoughnutSeries<_SalesData, String>(
            explode: true,
            explodeIndex: 0,
            dataSource: data,
            xValueMapper: (_SalesData data, _) => data.type,
            yValueMapper: (_SalesData data, _) => data.percents,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }

  _SalesData _gerPercents(String type) {
    final double percents =
        transactions
            .where((transaction) => transaction.type == type)
            .length /
            transactions.length *
            100;
    return (_SalesData(type, double.parse(percents.toStringAsFixed(2))));
  }
}

class _SalesData {
  final String type;
  final double percents;

  _SalesData(this.type, this.percents);
}
