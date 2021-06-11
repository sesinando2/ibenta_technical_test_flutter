import 'package:ibenta_technical_test_flutter/models/user.dart';

class UsersResult {
  List<User>? users;
  String? error;

  UsersResult({
    required this.users,
    this.error,
  });

  UsersResult.fromJson(Map<String, dynamic> json) {
    users = <User>[];
    if (json['content'] != null) {
      json['content'].forEach((v) {
        users?.add(User.fromJson(v));
      });
    }
  }
}
