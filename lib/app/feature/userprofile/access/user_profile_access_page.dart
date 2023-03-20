import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/user_profile_model.dart';
import '../../../core/repositories/user_profile_repository.dart';
import '../../../data/b4a/table/user_profile/user_profile_b4a.dart';
import '../../utils/app_photo_show.dart';
import '../../utils/app_text_title_value.dart';
import '../../utils/app_textformfield.dart';
import 'bloc/user_profile_access_bloc.dart';
import 'bloc/user_profile_access_event.dart';
import 'bloc/user_profile_access_state.dart';

class UserProfileAccessPage extends StatelessWidget {
  final UserProfileModel userProfileModel;
  const UserProfileAccessPage({
    Key? key,
    required this.userProfileModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider(
        create: (context) =>
            UserProfileRepository(userProfileB4a: UserProfileB4a()),
        child: BlocProvider(
          create: (context) => UserProfileAccessBloc(
              userProfileModel: userProfileModel,
              userProfileRepository:
                  RepositoryProvider.of<UserProfileRepository>(context)),
          child: UserProfileAccessView(userProfileModel: userProfileModel),
        ),
      ),
    );
  }
}

class UserProfileAccessView extends StatefulWidget {
  final UserProfileModel userProfileModel;

  const UserProfileAccessView({Key? key, required this.userProfileModel})
      : super(key: key);

  @override
  State<UserProfileAccessView> createState() => _UserProfileAccessViewState();
}

class _UserProfileAccessViewState extends State<UserProfileAccessView> {
  final _formKey = GlobalKey<FormState>();
  bool isActive = false;
  final _restrictionsTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    isActive = widget.userProfileModel.isActive;
    _restrictionsTEC.text =
        widget.userProfileModel.restrictions?.join(' ') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar este operador'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_upload),
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            context.read<UserProfileAccessBloc>().add(
                  UserProfileAccessEventFormSubmitted(
                    isActive: isActive,
                    restrictions: _restrictionsTEC.text,
                  ),
                );
          }
        },
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Text(
                    //   'Id: ${widget._userProfileAccessController.userProfile!.id}',
                    // ),
                    const SizedBox(height: 5),
                    AppImageShow(
                      photoUrl: widget.userProfileModel.photo,
                    ),
                    AppTextTitleValue(
                      title: 'Email: ',
                      value: widget.userProfileModel.email,
                      inColumn: true,
                    ),
                    AppTextTitleValue(
                      inColumn: true,
                      title: 'Nome completo: ',
                      value: '${widget.userProfileModel.name}',
                    ),
                    AppTextTitleValue(
                      inColumn: true,
                      title: 'Nome em tropa: ',
                      value: '${widget.userProfileModel.nickname}',
                    ),
                    AppTextTitleValue(
                      title: 'Telefone: ',
                      value: '${widget.userProfileModel.phone}',
                    ),

                    AppTextTitleValue(
                      title: 'Registro: ',
                      value: '${widget.userProfileModel.register}',
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    CheckboxListTile(
                      title: const Text("* Liberar acesso ?"),
                      value: isActive,
                      onChanged: (value) {
                        setState(() {
                          isActive = value ?? false;
                        });
                      },
                    ),
                    const Text('Marque as opções de acesso para este usuário.'),
                    Wrap(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Row(
                                children: [
                                  const Text('Admin'),
                                  BlocBuilder<UserProfileAccessBloc,
                                      UserProfileAccessState>(
                                    builder: (context, state) {
                                      return Checkbox(
                                          tristate: true,
                                          value: state.routes.contains('admin'),
                                          onChanged: (value) {
                                            context
                                                .read<UserProfileAccessBloc>()
                                                .add(
                                                    UserProfileAccessEventUpdateRoute(
                                                        route: 'admin'));
                                          });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 140,
                        //   child: Card(
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(left: 5, right: 5),
                        //       child: Row(
                        //         children: [
                        //           const Text('Patrimônio'),
                        //           Checkbox(
                        //               value: widget._userProfileAccessController
                        //                   .routesMap['patrimonio'],
                        //               onChanged: (value) => widget
                        //                       ._userProfileAccessController
                        //                       .routesMap['patrimonio'] =
                        //                   value ?? false),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 120,
                        //   child: Card(
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(left: 5, right: 5),
                        //       child: Row(
                        //         children: [
                        //           const Text('Reserva'),
                        //           Checkbox(
                        //               value: widget._userProfileAccessController
                        //                   .routesMap['reserva'],
                        //               onChanged: (value) => widget
                        //                       ._userProfileAccessController
                        //                       .routesMap['reserva'] =
                        //                   value ?? false),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 130,
                        //   child: Card(
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(left: 5, right: 5),
                        //       child: Row(
                        //         children: [
                        //           const Text('Operador'),
                        //           Checkbox(
                        //               value: widget._userProfileAccessController
                        //                   .routesMap['operador'],
                        //               onChanged: (value) => widget
                        //                       ._userProfileAccessController
                        //                       .routesMap['operador'] =
                        //                   value ?? false),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),

                    const Text('Informe os grupos com restrição:'),
                    AppTextFormField(
                      label: 'Um grupo por espaço',
                      controller: _restrictionsTEC,
                    ),

                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
