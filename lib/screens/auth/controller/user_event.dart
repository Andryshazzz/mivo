import 'package:flutter/cupertino.dart';

@immutable
sealed class UserEvent {}

final class SaveUserNameEvent extends UserEvent {
  final String name;

  SaveUserNameEvent({required this.name});
}

final class GetUserNameEvent extends UserEvent {}

final class HasAuthEvent extends UserEvent {}
