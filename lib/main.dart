import 'dart:async';
import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:ui_kit/ui_kit.dart';

import 'app/initialization.dart';
import 'app/router/router.dart';

void main() async => l.capture<void>(
  () => runZonedGuarded<void>(() async {
    await $initApp();
    runApp(const MivoApp());
  }, l.e),
  const LogOptions(
    printColors: false,
    output: LogOutput.print,
    overrideOutput: _customFormatter,
  ),
);

class MivoApp extends StatelessWidget {
  const MivoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}

String? _timeFormat(DateTime time) =>
    '${time.hour}:${time.minute.toString().padLeft(2, '0')}';

String? _customFormatter(LogMessage log) {
  final prefix = log.level.when(
    v: () => '1️⃣',
    vv: () => '2️⃣',
    vvv: () => '3️⃣',
    vvvv: () => '4️⃣',
    vvvvv: () => '5️⃣',
    vvvvvv: () => '6️⃣',
    info: () => 'ℹ️',
    debug: () => '⚒️',
    shout: () => '🎤',
    error: () => '❌',
    warning: () => '⚠️',
  );

  return '[$prefix]'
      '${_timeFormat(log.timestamp)}'
      '| ${log.message}';
}
