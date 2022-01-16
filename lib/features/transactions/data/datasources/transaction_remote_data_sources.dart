import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;
import 'package:transactions_test_task/core/error/exception.dart';
import 'package:transactions_test_task/features/transactions/data/models/transaction_model.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';

abstract class ITransactionRemoteDataSource {
  Future<List<TransactionModel>> getAllTransactions();

  Future<TransactionModel> addTransactions(
      double amount, double fee, String type);

  Future<TransactionModel> cancelTransaction(TransactionModel transaction);
}

class TransactionRemoteDataSource implements ITransactionRemoteDataSource {
  final http.Client client;

  TransactionRemoteDataSource({required this.client});

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    return await _getTransactionsFromUrl('https://some/url');
  }

  Future<List<TransactionModel>> _getTransactionsFromUrl(String url) async {
    // тут можо будет посылать запросы
    // final response = await client
    //     .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    Map<String, dynamic> response = _getFakeTransactions();
    if (response['statusCode'] == 200) {
      final transactions = json.decode(response['body']);
      return (transactions as List)
          .map((transaction) => TransactionModel.fromJson(transaction))
          .toList();
    } else {
      throw ServerException();
    }
  }

  Map<String, dynamic> _getFakeTransactions() {
    var fakeData = [];
    for (var i = 0; i < 10; i++) {
      fakeData.add({
        'id': random.integer(999999, min: 1),
        'amount': random.decimal(min: 234.0, scale: 27),
        'type': typeOperationDict[TypeOperation.values[random.integer(TypeOperation.values.length, min: 0)].name.toString()],
        'status': statusDict[Status.values[random.integer(Status.values.length, min: 0)].name.toString()],
        'fee': random.decimal(min: 0.345, scale: 27),
        'date': faker.date.dateTime(minYear: 2020, maxYear: 2022).toString(),
      });
    }
    return {'statusCode': 200, 'body': jsonEncode(fakeData)};
  }

  @override
  Future<TransactionModel> addTransactions(
      double amount, double fee, String type) {
    // тут можо будет посылать запросы
    // final response = await client
    //     .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    return Future.value(TransactionModel(
        status: statusDict[Status.done.name.toString()],
        amount: amount,
        date: DateTime.now(),
        id: random.integer(999999, min: 1),
        fee: fee,
        type: type));
  }

  @override
  Future<TransactionModel> cancelTransaction(TransactionModel transaction) {
    // тут можо будет посылать запросы
    // final response = await client
    //     .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    return Future.value(TransactionModel(
        status: statusDict[Status.canceled.name.toString()],
        amount: transaction.amount,
        date: transaction.date,
        id: transaction.id,
        fee: transaction.fee,
        type: transaction.type));
  }
}
