part of 'user_profile_edit_bloc.dart';

enum UserProfileEditStateStatus { initial, loading, success, error }

class UserProfileEditState {
  final UserProfileEditStateStatus status;
  final String? error;
  final UserModel user;
  UserProfileEditState({
    required this.status,
    this.error,
    required this.user,
  });
  UserProfileEditState.initial(this.user)
      : status = UserProfileEditStateStatus.initial,
        error = '';
  UserProfileEditState copyWith({
    UserProfileEditStateStatus? status,
    String? error,
    UserModel? user,
  }) {
    return UserProfileEditState(
      status: status ?? this.status,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfileEditState &&
        other.status == status &&
        other.error == error &&
        other.user == user;
  }

  @override
  int get hashCode => status.hashCode ^ error.hashCode ^ user.hashCode;
}
