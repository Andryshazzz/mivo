import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';

class AppBlocObserver extends BlocObserver {
  static String _toString(Object? object) => object.runtimeType.toString();

  @override
  void onCreate(BlocBase<Object?> bloc) {
    super.onCreate(bloc);
    l.v('BLoC создан: ${_toString(bloc)}');
  }

  @override
  void onEvent(Bloc<Object?, Object?> bloc, Object? event) {
    super.onEvent(bloc, event);
    l.v('Событие в ${_toString(bloc)}: ${_toString(event)}');
  }

  @override
  void onChange(BlocBase<Object?> bloc, Change<Object?> change) {
    super.onChange(bloc, change);
    l.vv('Изменение состояния в ${_toString(bloc)}: ${_toString(change)}');
  }

  @override
  void onTransition(
    Bloc<Object?, Object?> bloc,
    Transition<Object?, Object?> transition,
  ) {
    super.onTransition(bloc, transition);
    l.vvv('Переход в ${_toString(bloc)}: ${_toString(transition)}');
  }

  @override
  void onError(BlocBase<Object?> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    l.e('Ошибка в ${_toString(bloc)}: $error\n$stackTrace');
  }

  @override
  void onClose(BlocBase<Object?> bloc) {
    super.onClose(bloc);
    l.w('BLoC закрыт: ${_toString(bloc)}');
  }
}
