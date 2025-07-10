// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auth_test/data/api_client.dart' as _i551;
import 'package:auth_test/repos/auth_repo.dart' as _i246;
import 'package:auth_test/screens/auth/controller/auth_bloc.dart' as _i419;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i551.ApiClient>(() => _i551.ApiClient());
    gh.singleton<_i246.AuthRepository>(
      () => _i246.AuthRepository(apiClient: gh<_i551.ApiClient>()),
    );
    gh.factory<_i419.AuthBloc>(
      () => _i419.AuthBloc(authRepository: gh<_i246.AuthRepository>()),
    );
    return this;
  }
}
