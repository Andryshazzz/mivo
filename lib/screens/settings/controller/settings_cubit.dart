import 'package:auth_test/screens/settings/controller/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState());

  void changeTheme(String theme) {
    emit(state.copyWith(theme: theme));
  }
}
