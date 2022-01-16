import 'package:shared_preferences/shared_preferences.dart';
import 'package:transactions_test_task/core/error/exception.dart';

abstract class IUserLocalDataSource {
  Future<int> getActiveUserId();

  Future<void> setActiveUserId(int id);

  Future<int> logout();
}

const cacheActiveUserId = 'CACHE_ACTIVE_USER_ID_LIST';

class UserLocalDataSource implements IUserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSource({required this.sharedPreferences});

  @override
  Future<int> getActiveUserId() {
    final jsonUserId = sharedPreferences.getInt(cacheActiveUserId);
    if (jsonUserId != null) {
      try {
        return Future.value(jsonUserId);
      } catch (e) {
        throw CacheException();
      }
    } else {
      return Future.value(0);
    }
  }

  @override
  Future<int> logout() {
    final jsonUserId = sharedPreferences.getInt(cacheActiveUserId);
    if (jsonUserId != null) {
      sharedPreferences.remove(cacheActiveUserId);
      return Future.value(jsonUserId);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> setActiveUserId(int id) {
    try {
      sharedPreferences.setInt(cacheActiveUserId, id);
      return Future.value();
    } catch (e) {
      throw CacheException();
    }
  }
}
