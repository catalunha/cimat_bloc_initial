part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginEventFormSubmitted extends LoginEvent {
  final String username;
  final String password;
  LoginEventFormSubmitted({required this.username, required this.password});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginEventFormSubmitted &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
