import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final String title;
  final FloatingActionButton? floatingActionButton;
  final Widget? bottom;

  const BasePage({
    Key? key,
    required this.child,
    required this.title,
    this.floatingActionButton,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users Management"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: child,
          )
        ],
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottom,
    );
  }
}
