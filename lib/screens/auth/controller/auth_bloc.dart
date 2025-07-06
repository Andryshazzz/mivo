import 'package:bloc/bloc.dart' show Bloc, Emitter;
import 'package:injectable/injectable.dart';

import '../../../repos/auth_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthState()) {
    on<SendCodeEvent>(_onSendCode);
    on<VerifyCodeEvent>(_onVerifyCode);
    // on<RefreshTokenEvent>(_onRefreshToken);
  }

  Future<void> _onSendCode(SendCodeEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await authRepository.sendCode(event.email);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onVerifyCode(
    VerifyCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final tokens = await authRepository.verifyCode(event.email, event.code);
      print('jwt: ${tokens['jwt']}');
      print('refresh: ${tokens['refresh_token']}');
      final jwtToken = await authRepository.refreshToken(
        tokens['refresh_token']!,
      );
      print('refreshTTTT: ${jwtToken['jwt']}');
      emit(
        state.copyWith(
          isLoading: false,
          isAuthorized: true,
          jwtToken: jwtToken['jwt'],
          refreshToken: tokens['refresh_token'],
          // userId: userId,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  // Future<void> _onRefreshToken(
  //   RefreshTokenEvent event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   emit(state.copyWith(isLoading: true, error: null));
  //   try {
  //     final tokens = await authRepository.refreshToken(event.refreshToken);
  //     emit(
  //       state.copyWith(
  //         isLoading: false,
  //         jwtToken: tokens['jwt'],
  //         refreshToken: tokens['refresh_token'],
  //       ),
  //     );
  //   } catch (e) {
  //     emit(state.copyWith(isLoading: false, error: e.toString()));
  //   }
  // }
}
