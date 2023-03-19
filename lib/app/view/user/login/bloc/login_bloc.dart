import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cimat_bloc/app/core/models/user_model.dart';
import 'package:cimat_bloc/app/data/b4a/b4a_exception.dart';

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
        if (user.userProfile!.isActive == true) {
          emit(state.copyWith(status: LoginStateStatus.success, user: user));
        } else {
          emit(state.copyWith(
              status: LoginStateStatus.error,
              user: null,
              error: 'Sua conta ainda esta em análise'));
        }
      }
    } on B4aException catch (e) {
      print(e);
      emit(state.copyWith(
          status: LoginStateStatus.error,
          user: null,
          error: '${e.message} (${e.where} -> ${e.originalError}'));
    } catch (e) {
      print(e);
      emit(state.copyWith(
          status: LoginStateStatus.error,
          user: null,
          error: 'Erro desconhecido no login'));
    }
  }
}
