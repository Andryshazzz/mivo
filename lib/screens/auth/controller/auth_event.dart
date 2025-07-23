import 'package:flutter/cupertino.dart';

@immutable
sealed class AuthEvent {}

final class SaveUserNameEvent extends AuthEvent {
  final String name;

  SaveUserNameEvent(this.name);
}

final class CheckAuthEvent extends AuthEvent {}
