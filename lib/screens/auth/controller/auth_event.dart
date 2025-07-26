import 'package:flutter/cupertino.dart';

@immutable
sealed class AuthEvent {}

final class SaveUserNameEvent extends AuthEvent {
  final String name;

  SaveUserNameEvent({required this.name});
}

final class CheckAuthEvent extends AuthEvent {}

final class HasAuthEvent extends AuthEvent {}
