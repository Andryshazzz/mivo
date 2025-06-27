import 'package:auth_test/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const AuthScreen());
  }
}
