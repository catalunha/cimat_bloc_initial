import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../../core/models/user_profile_model.dart';
import '../../../repositories/user_profile_repository.dart';
import '../../../utils/pagination.dart';
import '../../entity/user_profile_entity.dart';
import '../../utils/parse_error_code.dart';
import 'user_profile_repository_exception.dart';

class UserProfileRepositoryB4a implements UserProfileRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    query.setAmountToSkip((pagination.page - 1) * pagination.limit);
    query.setLimit(pagination.limit);

    return query;
  }

  @override
  Future<List<UserProfileModel>> list(
    QueryBuilder<ParseObject> query,
    Pagination pagination,
  ) async {
    QueryBuilder<ParseObject> query2;
    query2 = await getQueryAll(query, pagination);

    ParseResponse? response;
    try {
      response = await query2.query();
      List<UserProfileModel> listTemp = <UserProfileModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(UserProfileEntity().fromParse(element));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw UserProfileRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<UserProfileModel?> readById(String id) async {
    log('+++', name: 'UserProfileRepositoryB4a.readById');
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));
    query.whereEqualTo('objectId', id);

    query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return UserProfileEntity().fromParse(response.results!.first);
      } else {
        // throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw UserProfileRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
    return null;
  }

  @override
  Future<String> update(UserProfileModel profileModel) async {
    final userProfileParse = await UserProfileEntity().toParse(profileModel);
    ParseResponse? response;
    try {
      response = await userProfileParse.save();

      if (response.success && response.results != null) {
        ParseObject userProfile = response.results!.first as ParseObject;
        return userProfile.objectId!;
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw UserProfileRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<UserProfileModel?> getByRegister(String? value) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));
    query.whereEqualTo('register', value);

    query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return UserProfileEntity().fromParse(response.results!.first);
      } else {
        // throw Exception();
        return null;
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw UserProfileRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
