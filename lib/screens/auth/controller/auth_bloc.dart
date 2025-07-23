import 'package:auth_test/repos/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({required this.userRepository}) : super(AuthState()) {
    on<SaveUserNameEvent>(_saveUserName);
    on<CheckAuthEvent>(_checkAuth);
  }

  Future<void> _saveUserName(
    SaveUserNameEvent event,
    Emitter<AuthState> emit,
  ) async {
    await userRepository.saveUserName(event.name);
  }

  Future<void> _checkAuth(CheckAuthEvent event, Emitter<AuthState> emit) async {
    final userName = await userRepository.getUserName();
    if (userName != null) {
      emit(state.copyWith(userName: userName));
    } else {
      emit(state.copyWith(userName: 'ой'));
    }
  }
}
