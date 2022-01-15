import 'package:flutter/material.dart';
import 'package:transactions_test_task/common/styles/app_colors.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';

class TransactionInfo extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionInfo({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Детальная информация',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ..._buildInfoField('Дата транзакции:', transaction.date.toIso8601String()),
        ..._buildInfoField('Сумма:', transaction.amount.toStringAsFixed(2)),
        ..._buildInfoField('Комиссия:', '${transaction.fee.toStringAsFixed(2)}%'),
        ..._buildInfoField('Итого:',
            (transaction.amount + transaction.fee * transaction.amount / 100).toStringAsFixed(2)),
        ..._buildInfoField('Номер транзакции:', transaction.id),
        ..._buildInfoField('Тип операции:', transaction.type),
        ..._buildInfoField('Статус операции:', transaction.status),
      ],
    );
  }

  List<Widget> _buildInfoField(String title, dynamic value) {
    return [
      Text(
        title,
        style: const TextStyle(
          color: AppColors.greyColor,
          fontSize: 16,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        value.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      const SizedBox(
        height: 12,
      ),
    ];
  }
}
