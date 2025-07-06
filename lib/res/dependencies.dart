import 'package:auth_test/res/dependencies.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.I;

@injectableInit
Future<void> configureDependencies() async => getIt.init();
