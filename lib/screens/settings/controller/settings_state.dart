class SettingsState {
  final String theme;

  SettingsState({this.theme = 'dark'});

  SettingsState copyWith({String? theme}) {
    return SettingsState(theme: theme ?? this.theme);
  }
}
