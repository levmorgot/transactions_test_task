import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:transactions_test_task/core/error/exception.dart';
import 'package:transactions_test_task/features/transactions/data/models/transaction_model.dart';

abstract class ITransactionLocalDataSource {
  Future<List<TransactionModel>> getLastTransactionsFromCache();

  Future<String> getLastEdit();

  Future<void> transactionToCache(List<TransactionModel> transactions);

  Future<void> lastEditToCache(String lastEdit);
}

const cacheTransactionsList = 'CACHE_TRANSACTIONS_LIST';
const cacheTransactionsLastEdit = 'CACHE_TRANSACTIONS_LAST_EDIT';

class TransactionLocalDataSource implements ITransactionLocalDataSource {
  final SharedPreferences sharedPreferences;

  TransactionLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> transactionToCache(List<TransactionModel> transactions) {
    final List<String> jsonTransactionList =
        transactions.map((transaction) => json.encode(transaction.toJson())).toList();
    sharedPreferences.setStringList(cacheTransactionsList, jsonTransactionList);
    return Future.value();
  }

  @override
  Future<List<TransactionModel>> getLastTransactionsFromCache() {
    final jsonTransactionList = sharedPreferences.getStringList(cacheTransactionsList);
    if (jsonTransactionList != null && jsonTransactionList.isNotEmpty) {
      try {
        return Future.value(jsonTransactionList
            .map((transaction) => TransactionModel.fromJson(json.decode(transaction)))
            .toList());
      } catch (e) {
        throw CacheException();
      }
    } else if (jsonTransactionList != null && jsonTransactionList.isEmpty) {
      return Future.value([]);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> getLastEdit() {
    final jsonTransactionLastEdit = sharedPreferences.getString(cacheTransactionsLastEdit);
    if (jsonTransactionLastEdit != null && jsonTransactionLastEdit.isNotEmpty) {
      try {
        return Future.value(jsonTransactionLastEdit);
      } catch (e) {
        throw CacheException();
      }
    } else {
      return Future.value("");
    }
  }

  @override
  Future<void> lastEditToCache(String lastEdit) {
    sharedPreferences.setString(cacheTransactionsLastEdit, lastEdit);
    return Future.value();
  }
}
