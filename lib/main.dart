import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

import 'app/dependencies/dependencies.dart';
import 'app/router/router.dart';

void main() async => runZonedGuarded<void>(() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MivoApp());
}, (e, st) => print('main error $e, $st'));

class MivoApp extends StatefulWidget {
  const MivoApp({super.key});

  @override
  State<MivoApp> createState() => _MivoAppState();
}

class _MivoAppState extends State<MivoApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.darkTheme,
      routerConfig: _router.config(),
    );
  }
}
