import 'dart:async';
import 'package:auth_test/app/dependencies/dependencies.dart';
import 'package:auth_test/screens/auth/controller/user_bloc.dart';
import 'package:flashy_flushbar/flashy_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';
import 'package:ui_kit/ui_kit.dart';

import 'app/dependencies/initialization.dart';
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
    return BlocProvider(
      create: (context) => getIt<UserBloc>(),
      child: MaterialApp.router(
        theme: AppTheme.darkTheme,
        routerConfig: AppRouter.router,
        builder: FlashyFlushbarProvider.init(),
      ),
    );
  }
}

String? _timeFormat(DateTime time) =>
    '${time.hour}:${time.minute.toString().padLeft(2, '0')}';

String? _customFormatter(LogMessage log) {
  final prefix = log.level.when(
    v: () => '✅',
    vv: () => '🔄',
    vvv: () => '🏹',
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
      ' ${_timeFormat(log.timestamp)}'
      ' | ${log.message}';
}
