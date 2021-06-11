import 'package:flutter/material.dart';
import 'package:ibenta_technical_test_flutter/views/users/users_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: UsersPage(),
    );
  }
}
