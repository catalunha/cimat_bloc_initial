import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cimat_bloc/app/core/models/user_model.dart';

part 'user_profile_edit_event.dart';
part 'user_profile_edit_state.dart';

class UserProfileEditBloc
    extends Bloc<UserProfileEditEvent, UserProfileEditState> {
  UserProfileEditBloc({required UserModel userModel})
      : super(UserProfileEditState.initial(userModel)) {
    on<UserProfileEditEventFormSubmitted>(_onUserProfileEditEventFormSubmitted);
  }

  FutureOr<void> _onUserProfileEditEventFormSubmitted(
      UserProfileEditEventFormSubmitted event,
      Emitter<UserProfileEditState> emit) {
    emit(state.copyWith(status: UserProfileEditStateStatus.loading));
    UserModel user = state.user.copyWith(
      userProfile: state.user.userProfile!.copyWith(
        nickname: event.nickname,
        name: event.name,
        register: event.register,
        phone: event.phone,
      ),
    );
    emit(
        state.copyWith(user: user, status: UserProfileEditStateStatus.success));
  }
}
