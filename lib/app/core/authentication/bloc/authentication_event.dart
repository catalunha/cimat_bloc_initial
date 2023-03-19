part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class _AuthenticationEventStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;
  const _AuthenticationEventStatusChanged(this.status);
}

class AuthenticationEventLogoutRequested extends AuthenticationEvent {}

class AuthenticationEventInitial extends AuthenticationEvent {}

class AuthenticationEventReceiveUser extends AuthenticationEvent {
  final UserModel? user;

  AuthenticationEventReceiveUser(this.user);
}
