import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String userId;

  const HomeScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('userId: $userId')));
  }
}
