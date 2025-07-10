import 'dart:async';
import 'package:auth_test/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

import 'app/dependencies/dependencies.dart';

void main() async => runZonedGuarded<void>(() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const AuthApp());
}, (e, st) => print('main error $e, $st'));

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppTheme.darkTheme, home: const AuthScreen());
  }
}
