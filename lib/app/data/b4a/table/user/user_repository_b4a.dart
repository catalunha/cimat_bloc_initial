import 'dart:async';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../../core/models/user_model.dart';
import '../../../repositories/user_repository.dart';
import '../../entity/user_entity.dart';
import '../../utils/parse_error_code.dart';
import '../user_profile/user_profile_repository_b4a.dart';
import 'user_repository_exception.dart';

class UserRepositoryB4a implements UserRepository {
  // final _controller = StreamController<AuthenticationStatus>();
  // @override
  // Stream<AuthenticationStatus> get status async* {
  //   print(' get status....');
  //   await Future<void>.delayed(const Duration(seconds: 1));
  //   yield AuthenticationStatus.unauthenticated;
  //   yield* _controller.stream;
  // }

  @override
  Future<UserModel?> readByEmail(String email) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(UserEntity.className));
    query.whereEqualTo('email', email);
    query.includeObject(['userProfile']);
    query.first();
    ParseResponse? parseResponse;
    try {
      parseResponse = await query.query();
      if (parseResponse.success && parseResponse.results != null) {
        return UserEntity().fromParse(parseResponse.results!.first);
      } else {
        throw Exception();
      }
    } catch (e) {
      var errorCodes = ParseErrorCode(parseResponse!.error!);
      throw UserRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<UserModel?> register(
      {required String email, required String password}) async {
    ParseResponse? parseResponse;

    try {
      final user = ParseUser.createUser(email, password, email);
      parseResponse = await user.signUp();
      if (parseResponse.success && parseResponse.results != null) {
        UserModel userModel =
            await UserEntity().fromParse(parseResponse.results!.first);
        return userModel;
      } else {
        throw Exception();
      }
    } catch (e) {
      var errorCodes = ParseErrorCode(parseResponse!.error!);
      throw UserRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<UserModel?> login(
      {required String email, required String password}) async {
    UserModel userModel;
    ParseResponse? parseResponse;
    try {
      final user = ParseUser(email, password, null);

      parseResponse = await user.login();
      if (parseResponse.success) {
        // _controller.add(AuthenticationStatus.authenticated);
        ParseUser parseUser = parseResponse.results!.first;
        var profileField = parseUser.get('userProfile');
        var profileRepositoryB4a = UserProfileRepositoryB4a();

        userModel = UserModel(
          id: parseUser.objectId!,
          email: parseUser.emailAddress!,
          userProfile:
              await profileRepositoryB4a.readById(profileField.objectId),
        );
        return userModel;
      } else {
        throw Exception();
      }
    } catch (e) {
      var errorCodes = ParseErrorCode(parseResponse!.error!);
      throw UserRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    final ParseUser user = ParseUser(null, null, email);
    final ParseResponse parseResponse = await user.requestPasswordReset();
    if (!parseResponse.success) {
      var errorCodes = ParseErrorCode(parseResponse.error!);
      throw UserRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<bool> logout() async {
    final user = await ParseUser.currentUser() as ParseUser;
    var parseResponse = await user.logout();
    // _controller.add(AuthenticationStatus.unauthenticated);
    if (parseResponse.success) {
      return true;
    } else {
      return false;
    }
  }

  // void dispose() => _controller.close();
}
