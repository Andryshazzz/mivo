// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auth_test/data/source/local/db.dart' as _i824;
import 'package:auth_test/data/source/network/api_client.dart' as _i772;
import 'package:auth_test/repos/auth_repo.dart' as _i246;
import 'package:auth_test/repos/task_repo.dart' as _i613;
import 'package:auth_test/screens/auth/controller/auth_bloc.dart' as _i97;
import 'package:auth_test/screens/task/controller/task_bloc.dart' as _i300;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i772.ApiClient>(() => _i772.ApiClient());
    gh.singleton<_i824.Database>(() => _i824.Database());
    gh.singleton<_i613.TodoRepository>(
      () => _i613.TodoRepository(db: gh<_i824.Database>()),
    );
    gh.factory<_i300.TaskBloc>(
      () => _i300.TaskBloc(repo: gh<_i613.TodoRepository>()),
    );
    gh.singleton<_i246.AuthRepository>(
      () => _i246.AuthRepository(apiClient: gh<_i772.ApiClient>()),
    );
    gh.factory<_i97.AuthBloc>(
      () => _i97.AuthBloc(authRepository: gh<_i246.AuthRepository>()),
    );
    return this;
  }
}
