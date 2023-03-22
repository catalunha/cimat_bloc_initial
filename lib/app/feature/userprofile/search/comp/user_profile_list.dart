import 'package:cimat_bloc/app/feature/userprofile/search/comp/user_profile_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/user_profile_model.dart';

class UserProfileList extends StatelessWidget {
  final List<UserProfileModel> userProfileList;
  const UserProfileList({
    super.key,
    required this.userProfileList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userProfileList.length,
      itemBuilder: (context, index) {
        final person = userProfileList[index];
        return UserProfileCard(
          profile: person,
        );
      },
    );
  }
}
