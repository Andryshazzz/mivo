import 'dart:async';

import 'package:auth_test/res/theme.dart';
import 'package:auth_test/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';

import 'res/dependencies.dart';

void main() async => runZonedGuarded<void>(() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const AuthApp());
}, (e, st) => print('main error $e, $st'));

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppTheme().lightTheme, home: const AuthScreen());
  }
}
