import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cimat_bloc/app/core/models/user_model.dart';

import '../../../data/b4a/b4a_exception.dart';
import '../../../data/b4a/init_back4app.dart';
import '../../../data/repositories/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    // on<_AuthenticationEventStatusChanged>(_onAuthenticationEventStatusChanged);
    on<AuthenticationEventInitial>(_onAuthenticationEventInitial);
    on<AuthenticationEventReceiveUser>(onAuthenticationEventReceiveUser);
    on<AuthenticationEventLogoutRequested>(
        _onAuthenticationEventLogoutRequested);
    // _authenticationStatusSubscription = _userRepository.status.listen(
    //   (status) => add(_AuthenticationEventStatusChanged(status)),
    // );
  }
  // late StreamSubscription<AuthenticationStatus>
  //     _authenticationStatusSubscription;

  // FutureOr<void> _onAuthenticationEventStatusChanged(
  //     _AuthenticationEventStatusChanged event,
  //     Emitter<AuthenticationState> emit) async {
  //   if (event.status == AuthenticationStatus.unauthenticated) {
  //     return emit(const AuthenticationState.unauthenticated());
  //   } else if (event.status == AuthenticationStatus.authenticated) {
  //     return emit(const AuthenticationState.authenticated());

  //     // final user = await _tryGetUser();
  //     // return emit(user != null
  //     //     ? AuthenticationState.authenticated(user)
  //     //     : const AuthenticationState.unauthenticated());
  //   } else {}
  // }

  // Future<User?> _tryGetUser() async {
  //   try {
  //     final user = await _userRepository.getUser();
  //     return user;
  //   } catch (_) {
  //     return null;
  //   }
  // }

  FutureOr<void> _onAuthenticationEventLogoutRequested(
      AuthenticationEventLogoutRequested event,
      Emitter<AuthenticationState> emit) async {
    try {
      bool logout = await _userRepository.logout();
      if (logout) {
        return emit(const AuthenticationState.unauthenticated());
      }
      return emit(const AuthenticationState.unauthenticated());
    } catch (_) {
      return emit(const AuthenticationState.unauthenticated());
    }
  }

  // @override
  // Future<void> close() {
  //   // _authenticationStatusSubscription.cancel();
  //   return super.close();
  // }

  FutureOr<void> onAuthenticationEventReceiveUser(
      AuthenticationEventReceiveUser event, Emitter<AuthenticationState> emit) {
    print('onAuthenticationEventReceiveUser');
    emit(AuthenticationState.authenticated(event.user));
  }

  FutureOr<void> _onAuthenticationEventInitial(AuthenticationEventInitial event,
      Emitter<AuthenticationState> emit) async {
    InitBack4app initBack4app = InitBack4app();
    try {
      bool initParse = await initBack4app.init();
      if (initParse) {
        final user = await _userRepository.hasUserLogged();
        if (user != null) {
          emit(AuthenticationState.authenticated(user));
        } else {
          await Future.delayed(const Duration(seconds: 2));
          emit(const AuthenticationState.unauthenticated());
        }
      }
    } on B4aException catch (e) {
      print('+++ _onAuthenticationEventInitial');
      print(e);
      print('--- _onAuthenticationEventInitial');
      emit(state.copyWith(
          status: AuthenticationStatus.databaseError, error: e.toString()));
    } catch (e) {
      print(e);
      emit(state.copyWith(
          status: AuthenticationStatus.unauthenticated,
          error: 'Erro desconhecido na inicialização'));
    }
  }
}
