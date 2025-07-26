class AuthState {
  final String? userName;
  final bool? hasAuth;

  AuthState({this.userName, this.hasAuth});

  AuthState copyWith({String? userName, bool? hasAuth}) {
    return AuthState(
      userName: userName ?? this.userName,
      hasAuth: hasAuth ?? this.hasAuth,
    );
  }
}
