import 'dart:ui';

import 'package:auth_test/app/app_bloc_observer.dart';
import 'package:auth_test/repos/user_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';
import 'dependencies.dart';

Future<void> $initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();

  PlatformDispatcher.instance.onError = (err, st) {
    l.e('Top level error: $err', st);
    return true;
  };

  await configureDependencies();

  await getIt<UserRepository>().getUserName();
}
