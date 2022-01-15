import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;
import 'package:transactions_test_task/core/error/exception.dart';
import 'package:transactions_test_task/features/transactions/data/models/transaction_model.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';

abstract class ITransactionRemoteDataSource {
  Future<List<TransactionModel>> getAllTransactions();

  Future<TransactionModel> addTransactions(
      double amount, double fee, TypeOperation type);

  Future<TransactionModel> cancelTransaction(TransactionModel transaction);
}

class TransactionsRemoteDataSource implements ITransactionRemoteDataSource {
  final http.Client client;

  TransactionsRemoteDataSource({required this.client});

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
    var typeOperationList = List<TypeOperation>.from(TypeOperation.values)
      ..shuffle();
    var statusList = List<Status>.from(TypeOperation.values)..shuffle();
    for (var i = 0; i < 10; i++) {
      fakeData.add({
        'id': random.integer(999999, min: 1),
        'amount': random.decimal(min: 0.0, scale: 2),
        'type': typeOperationList.take(1).toList()[0],
        'status': statusList.take(1).toList()[0],
        'fee': random.decimal(min: 0.0, scale: 2),
        'date': faker.date.dateTime(minYear: 2020, maxYear: 2022),
      });
    }
    return {'statusCode': 200, 'body': jsonEncode(fakeData)};
  }

  @override
  Future<TransactionModel> addTransactions(
      double amount, double fee, TypeOperation type) {
    // тут можо будет посылать запросы
    // final response = await client
    //     .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    return Future.value(TransactionModel(
        status: Status.done,
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
        status: Status.canceled,
        amount: transaction.amount,
        date: transaction.date,
        id: transaction.id,
        fee: transaction.fee,
        type: transaction.type));
  }
}
