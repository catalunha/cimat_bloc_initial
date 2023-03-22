import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cimat_bloc/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../../core/models/user_profile_model.dart';
import '../../../../core/repositories/user_profile_repository.dart';
import '../../../../data/b4a/entity/user_profile_entity.dart';
import 'user_profile_search_event.dart';
import 'user_profile_search_state.dart';

class UserProfileSearchBloc
    extends Bloc<UserProfileSearchEvent, UserProfileSearchState> {
  final UserProfileRepository _userProfileRepository;

  UserProfileSearchBloc({required UserProfileRepository userProfileRepository})
      : _userProfileRepository = userProfileRepository,
        super(UserProfileSearchState.initial()) {
    on<UserProfileSearchEventNextPage>(_onUserProfileSearchEventNextPage);
    on<UserProfileSearchEventPreviousPage>(
        _onUserProfileSearchEventPreviousPage);
    on<UserProfileSearchEventFormSubmitted>(
        _onUserProfileSearchEventFormSubmitted);
  }

  FutureOr<void> _onUserProfileSearchEventPreviousPage(
      UserProfileSearchEventPreviousPage event,
      Emitter<UserProfileSearchState> emit) async {
    emit(
      state.copyWith(
        status: UserProfileSearchStateStatus.loading,
      ),
    );
    if (state.page > 1) {
      emit(
        state.copyWith(
          page: state.page - 1,
        ),
      );
      List<UserProfileModel> userProfileModelListGet =
          await _userProfileRepository.list(
        state.query,
        Pagination(page: state.page, limit: state.limit),
      );
      if (state.page == 1) {
        emit(
          state.copyWith(
            page: 1,
            firstPage: true,
            lastPage: false,
          ),
        );
      }
      emit(state.copyWith(
        status: UserProfileSearchStateStatus.success,
        userProfileModelList: userProfileModelListGet,
        lastPage: false,
      ));
    } else {
      emit(state.copyWith(
        status: UserProfileSearchStateStatus.success,
        lastPage: false,
      ));
    }
  }

  FutureOr<void> _onUserProfileSearchEventNextPage(
      UserProfileSearchEventNextPage event,
      Emitter<UserProfileSearchState> emit) async {
    emit(
      state.copyWith(status: UserProfileSearchStateStatus.loading),
    );
    List<UserProfileModel> userProfileModelListGet =
        await _userProfileRepository.list(
      state.query,
      Pagination(page: state.page + 1, limit: state.limit),
    );
    if (userProfileModelListGet.isEmpty) {
      emit(state.copyWith(
        status: UserProfileSearchStateStatus.success,
        firstPage: false,
        lastPage: true,
      ));
    } else {
      emit(state.copyWith(
        status: UserProfileSearchStateStatus.success,
        userProfileModelList: userProfileModelListGet,
        page: state.page + 1,
        firstPage: false,
      ));
    }
  }

  FutureOr<void> _onUserProfileSearchEventFormSubmitted(
      UserProfileSearchEventFormSubmitted event,
      Emitter<UserProfileSearchState> emit) async {
    emit(state.copyWith(
        status: UserProfileSearchStateStatus.loading,
        firstPage: true,
        lastPage: false,
        page: 1,
        userProfileModelList: []));
    try {
      QueryBuilder<ParseObject> query =
          QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));

      if (event.nameContainsBool) {
        query.whereContains('name', event.nameContainsString);
      }
      if (event.nicknameContainsBool) {
        query.whereContains('nickname', event.nicknameContainsString);
      }
      if (event.registerEqualToBool) {
        query.whereEqualTo('register', event.registerEqualToString);
      }
      if (event.phoneEqualToBool) {
        query.whereEqualTo('phone', event.phoneEqualToString);
      }
      query.orderByDescending('updatedAt');
      List<UserProfileModel> userProfileModelListGet =
          await _userProfileRepository.list(
        query,
        Pagination(page: state.page, limit: state.limit),
      );

      emit(
        state.copyWith(
            status: UserProfileSearchStateStatus.success,
            userProfileModelList: userProfileModelListGet),
      );
    } catch (_) {
      emit(
        state.copyWith(
            status: UserProfileSearchStateStatus.error,
            error: 'Erro na montagem da busca'),
      );
    }
  }
}
