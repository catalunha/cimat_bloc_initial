import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../core/models/user_profile_model.dart';
import '../../../../core/repositories/user_profile_repository.dart';
import 'user_profile_access_event.dart';
import 'user_profile_access_state.dart';

class UserProfileAccessBloc
    extends Bloc<UserProfileAccessEvent, UserProfileAccessState> {
  final UserProfileRepository _userProfileRepository;

  UserProfileAccessBloc(
      {required UserProfileModel userProfileModel,
      required UserProfileRepository userProfileRepository})
      : _userProfileRepository = userProfileRepository,
        super(UserProfileAccessState.initial(userProfileModel)) {
    on<UserProfileAccessEventFormSubmitted>(
        _onUserProfileAccessEventFormSubmitted);
    on<UserProfileAccessEventUpdateRoute>(_onUserProfileAccessEventUpdateRoute);
  }

  FutureOr<void> _onUserProfileAccessEventFormSubmitted(
      UserProfileAccessEventFormSubmitted event,
      Emitter<UserProfileAccessState> emit) async {
    emit(state.copyWith(status: UserProfileAccessStateStatus.loading));
    try {
      UserProfileModel userProfileModel = state.userProfileModel.copyWith(
        isActive: event.isActive,
        restrictions:
            event.restrictions.isNotEmpty ? event.restrictions.split(' ') : [],
        routes: state.routes,
      );

      await _userProfileRepository.update(userProfileModel);
      emit(state.copyWith(
          userProfileModel: userProfileModel,
          status: UserProfileAccessStateStatus.success));
    } catch (_) {
      emit(state.copyWith(
          status: UserProfileAccessStateStatus.error,
          error: 'Erro ao salvar dados neste perfil'));
    }
  }

  FutureOr<void> _onUserProfileAccessEventUpdateRoute(
      UserProfileAccessEventUpdateRoute event,
      Emitter<UserProfileAccessState> emit) {
    List<String> routes = [...state.routes];
    if (routes.contains(event.route)) {
      routes.remove(event.route);
    } else {
      routes.add(event.route);
    }
    emit(state.copyWith(routes: routes));
  }
}
