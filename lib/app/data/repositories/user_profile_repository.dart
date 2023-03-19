import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../core/models/user_profile_model.dart';
import '../utils/pagination.dart';

abstract class UserProfileRepository {
  Future<List<UserProfileModel>> list(
    QueryBuilder<ParseObject> query,
    Pagination pagination,
  );
  Future<String> update(UserProfileModel userProfileModel);
  Future<UserProfileModel?> readById(String id);
  Future<UserProfileModel?> getByRegister(String? value);
}
