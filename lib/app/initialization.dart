import 'dart:ui';
import 'package:auth_test/repos/user_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:l/l.dart';
import 'dependencies/dependencies.dart';

Future<void> $initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  PlatformDispatcher.instance.onError = (err, st) {
    l.e('Top level error: $err', st);
    return true;
  };
  await configureDependencies();

  await getIt<UserRepository>().getUserName();
}
