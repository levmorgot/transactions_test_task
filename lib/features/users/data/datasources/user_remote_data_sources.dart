import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;
import 'package:transactions_test_task/features/users/data/models/user_model.dart';

abstract class IUserRemoteDataSource {
  Future<UserModel> login(String login, String password);
}

class UserRemoteDataSource implements IUserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSource({required this.client});

  @override
  Future<UserModel> login(String login, String password) async {
    return await _getUser(login, password);
    // return await _getUserFromUrl('https://some/url');
  }

  // Future<List<UserModel>> _getUserFromUrl(String url) async {
  //   // тут можо будет посылать запросы
  //   // final response = await client
  //   //     .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
  //   Map<String, dynamic> response = _getFakeUsers();
  //   if (response['statusCode'] == 200) {
  //     final users = json.decode(response['body']);
  //     return (users as List)
  //         .map((user) => UserModel.fromJson(user))
  //         .toList();
  //   } else {
  //     throw ServerException();
  //   }
  // }

  Future<UserModel> _getUser(String login, String password) {
    return Future.value(UserModel(
        id: random.integer(999999, min: 1), login: login, password: password));
  }
}
