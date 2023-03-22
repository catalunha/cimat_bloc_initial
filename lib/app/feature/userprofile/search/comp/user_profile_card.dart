import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/user_profile_model.dart';
import '../../../utils/app_text_title_value.dart';
import '../../access/user_profile_access_page.dart';
import '../bloc/user_profile_search_bloc.dart';

class UserProfileCard extends StatelessWidget {
  final UserProfileModel profile;
  const UserProfileCard({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              profile.photo != null && profile.photo!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        profile.photo!,
                        height: 70,
                        width: 70,
                      ),
                    )
                  : const SizedBox(
                      height: 70,
                      width: 70,
                      child: Icon(Icons.person_outline),
                    ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AppTextTitleValue(
                    //   title: 'Id: ',
                    //   value: profile.id,
                    // ),
                    // AppTextTitleValue(
                    //   title: 'Email: ',
                    //   value: profile.email,
                    // ),
                    // AppTextTitleValue(
                    //   title: 'Nome: ',
                    //   value: '${profile.name}',
                    // ),
                    AppTextTitleValue(
                      title: 'Nome em tropa: ',
                      value: '${profile.nickname}',
                    ),
                    AppTextTitleValue(
                      title: 'Telefone: ',
                      value: '${profile.phone}',
                    ),
                    AppTextTitleValue(
                      title: 'Registro: ',
                      value: '${profile.register}',
                    ),
                    Wrap(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Navigator.of(context).pushNamed(
                            //     '/userProfile/access',
                            //     arguments: profile);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                // settings: RouteSettings(arguments: profile),
                                builder: (_) => BlocProvider.value(
                                  value: BlocProvider.of<UserProfileSearchBloc>(
                                      context),
                                  child: UserProfileAccessPage(
                                      userProfileModel: profile),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              '/userProfile/view',
                              arguments: profile,
                            );
                          },
                          icon: const Icon(
                            Icons.assignment_ind_outlined,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.copy,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // copy(String text) async {
  //   Get.snackbar(text, 'Id copiado.',
  //       margin: const EdgeInsets.all(10), duration: const Duration(seconds: 1));
  //   await Clipboard.setData(ClipboardData(text: text));
  // }
}
