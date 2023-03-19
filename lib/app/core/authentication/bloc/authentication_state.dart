part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationState {
  final AuthenticationStatus status;
  final UserModel? user;
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });
  const AuthenticationState.unknown() : this._();
  const AuthenticationState.authenticated(UserModel? user)
      : this._(status: AuthenticationStatus.authenticated, user: user);
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated, user: null);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthenticationState &&
        other.status == status &&
        other.user == user;
  }

  @override
  int get hashCode => status.hashCode ^ user.hashCode;
}
