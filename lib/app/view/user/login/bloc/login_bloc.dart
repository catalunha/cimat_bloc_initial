import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cimat_bloc/app/core/models/user_model.dart';

import '../../../../data/repositories/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.initial()) {
    on<LoginEventFormSubmitted>(_onLoginEventFormSubmitted);
  }

  FutureOr<void> _onLoginEventFormSubmitted(
      LoginEventFormSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStateStatus.loading));
    try {
      UserModel? user = await _userRepository.login(
          email: event.username, password: event.password);
      if (user != null) {
        emit(state.copyWith(status: LoginStateStatus.success, user: user));
      }
    } catch (_) {
      emit(state.copyWith(
          status: LoginStateStatus.error, user: null, error: 'Falha no login'));
    }
  }
}
