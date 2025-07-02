class AuthState {
  final bool isLoading;
  final String? error;
  final bool isAuthorized;
  final String? userId;
  final String? refreshToken;
  final String? jwtToken;

  AuthState({
    this.isLoading = false,
    this.error,
    this.isAuthorized = false,
    this.userId,
    this.refreshToken,
    this.jwtToken,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    bool? isAuthorized,
    String? userId,
    String? refreshToken,
    String? jwtToken,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isAuthorized: isAuthorized ?? this.isAuthorized,
      userId: userId ?? this.userId,
      refreshToken: refreshToken ?? this.refreshToken,
      jwtToken: jwtToken ?? this.jwtToken,
    );
  }
}
