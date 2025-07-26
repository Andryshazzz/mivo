class UserState {
  final String userName;
  final bool? hasAuth;

  UserState({this.userName = 'Пусто', this.hasAuth});

  UserState copyWith({String? userName, bool? hasAuth}) {
    return UserState(
      userName: userName ?? this.userName,
      hasAuth: hasAuth ?? this.hasAuth,
    );
  }
}
