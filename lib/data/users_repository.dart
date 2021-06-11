import 'package:ibenta_technical_test_flutter/data/api_client.dart';
import 'package:ibenta_technical_test_flutter/models/user.dart';
import 'package:ibenta_technical_test_flutter/models/users_result.dart';

class UsersRepository {
  final ApiClient _client;

  UsersRepository(this._client);

  Future<List<User>> getUsers() async {
    final response = await _client.get('/users');
    return UsersResult.fromJson(response).users!;
  }

  Future<void> deleteUser(int id) async {
    await _client.delete('/users/$id');
  }

  Future<User> createUser(User user) async {
    final response = await _client.post('/users', user.toJson());
    return User.fromJson(response);
  }

  Future<User> updateUser(User user) async {
    final response = await _client.put('/users/${user.id}', user.toJson());
    return User.fromJson(response);
  }
}
