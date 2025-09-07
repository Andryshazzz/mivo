import 'package:auth_test/repos/user_repo.dart';
import 'package:auth_test/screens/auth/controller/user_event.dart';
import 'package:auth_test/screens/auth/controller/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_kit/ui_kit.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserState()) {
    on<UserEvent>(
      (event, emit) => switch (event) {
        SaveUserNameEvent() => _saveUserName(event, emit),
        GetUserNameEvent() => _getUserName(event, emit),
        HasAuthEvent() => _hasUser(event, emit),
      },
    );
  }

  Future<void> _saveUserName(
    SaveUserNameEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userRepository.saveUserName(event.name);
    } catch (e) {
      Flushbar(text: 'Упс... Ошибка', type: FlushbarType.error).show();
    }
  }

  Future<void> _getUserName(
    GetUserNameEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      final userName = await userRepository.getUserName();
      if (userName != null) {
        emit(state.copyWith(userName: userName, hasAuth: true));
      } else {
        emit(state.copyWith(userName: 'ой', hasAuth: false));
      }
    } catch (e) {
      Flushbar(text: 'Упс... Ошибка', type: FlushbarType.error).show();
    }
  }

  Future<void> _hasUser(HasAuthEvent event, Emitter<UserState> emit) async {
    try {
      final hasAuth = await userRepository.hasUser();
      emit(state.copyWith(hasAuth: hasAuth));
    } catch (e) {
      Flushbar(text: 'Упс... Ошибка', type: FlushbarType.error).show();
    }
  }
}
