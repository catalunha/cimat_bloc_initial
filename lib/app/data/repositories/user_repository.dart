import '../../core/models/user_model.dart';

abstract class UserRepository {
  // Stream<AuthenticationStatus> get status;
  Future<UserModel?> hasUserLogged();
  Future<UserModel?> readByEmail(String email);
  Future<UserModel?> register(
      {required String email, required String password});
  Future<UserModel?> login({required String email, required String password});
  Future<bool> logout();
  Future<void> requestPasswordReset(String email);
}
