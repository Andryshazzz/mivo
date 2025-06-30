import 'package:flutter/cupertino.dart';

@immutable
sealed class AuthEvent {}

final class SendCodeEvent extends AuthEvent {
  final String email;

  SendCodeEvent(this.email);
}

final class VerifyCodeEvent extends AuthEvent {
  final String email;
  final String code;

  VerifyCodeEvent(this.email, this.code);
}

final class RefreshTokenEvent extends AuthEvent {
  final String refreshToken;

  RefreshTokenEvent(this.refreshToken);
}

final class CheckAuthEvent extends AuthEvent {
  final String jwt;

  CheckAuthEvent({required this.jwt});
}
