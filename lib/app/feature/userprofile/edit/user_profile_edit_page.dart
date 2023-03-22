import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import 'package:cimat_bloc/app/core/authentication/authentication.dart';
import 'package:cimat_bloc/app/core/models/user_model.dart';

import '../../../core/repositories/user_profile_repository.dart';
import '../../utils/app_import_image.dart';
import '../../utils/app_textformfield.dart';
import 'bloc/user_profile_edit_bloc.dart';
/*
class UserProfileEditPage extends StatelessWidget {
  const UserProfileEditPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider(
        create: (_) {
          UserModel user =
              ModalRoute.of(context)!.settings.arguments as UserModel;
          return UserProfileEditBloc(userModel: user);
        },
        builder: (_, child) {
          UserModel user =
              ModalRoute.of(context)!.settings.arguments as UserModel;
          return UserProfileEditView(userModel: user);
        },
      ),
    );
  }
}
*/

class UserProfileEditPage extends StatelessWidget {
  final UserModel userModel;
  const UserProfileEditPage({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider(
        create: (context) => UserProfileRepository(),
        child: BlocProvider(
          create: (context) => UserProfileEditBloc(
              userModel: userModel,
              userProfileRepository:
                  RepositoryProvider.of<UserProfileRepository>(context)),
          child: UserProfileEditView(userModel: userModel),
        ),
      ),
    );
  }
}

class UserProfileEditView extends StatefulWidget {
  final UserModel userModel;
  const UserProfileEditView({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<UserProfileEditView> createState() => _UserProfileEditViewState();
}

class _UserProfileEditViewState extends State<UserProfileEditView> {
  final dateFormat = DateFormat('dd/MM/y');

  final _formKey = GlobalKey<FormState>();
  final _nicknameTec = TextEditingController();
  final _nameTec = TextEditingController();
  final _phoneTec = TextEditingController();
  final _registerTec = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nicknameTec.text = widget.userModel.userProfile?.nickname ?? "";
    _nameTec.text = widget.userModel.userProfile?.name ?? "";
    _phoneTec.text = widget.userModel.userProfile?.phone ?? "";
    _registerTec.text = widget.userModel.userProfile?.register ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar seu perfil'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_upload),
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            context.read<UserProfileEditBloc>().add(
                  UserProfileEditEventFormSubmitted(
                    nickname: _nicknameTec.text,
                    name: _nameTec.text,
                    register: _registerTec.text,
                    phone: _phoneTec.text,
                  ),
                );
          }
        },
      ),
      body: BlocListener<UserProfileEditBloc, UserProfileEditState>(
        listenWhen: (previous, current) {
          return previous.status != current.status;
        },
        listener: (context, state) async {
          if (state.status == UserProfileEditStateStatus.error) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.error ?? '...')));
          }
          if (state.status == UserProfileEditStateStatus.success) {
            Navigator.of(context).pop();
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationEventUpdateUserProfile(state.user));
            Navigator.of(context).pop();
          }
          if (state.status == UserProfileEditStateStatus.loading) {
            await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return const Center(child: CircularProgressIndicator());
              },
            );
          }
        },
        child: Center(
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Id: ${widget.userModel.userProfile!.id}',
                      ),
                      Text(
                        'email: ${widget.userModel.userProfile!.email}',
                      ),
                      const SizedBox(height: 5),
                      AppTextFormField(
                        label: '* Seu nome em tropa.',
                        controller: _nicknameTec,
                        validator: Validatorless.required(
                            'Nome em tropa é obrigatório'),
                      ),
                      AppTextFormField(
                        label: '* Seu nome completo.',
                        controller: _nameTec,
                        validator: Validatorless.required('Nome é obrigatório'),
                      ),
                      AppTextFormField(
                        label:
                            'O número de registro na corporação. Padrão 123/4',
                        controller: _registerTec,
                        validator: Validatorless.multiple([
                          Validatorless.required('Número é obrigatório'),
                        ]),
                      ),
                      AppTextFormField(
                          label: 'Seu telefone. Formato: DDDNÚMERO',
                          controller: _phoneTec,
                          validator: Validatorless.multiple([
                            Validatorless.number(
                                'Apenas números. Formato: DDDNÚMERO'),
                            Validatorless.required('Telefone é obrigatório'),
                          ])),
                      const SizedBox(height: 5),
                      AppImportImage(
                        label:
                            'Click aqui para buscar sua foto, apenas face. Padrão 3x4.',
                        imageUrl: widget.userModel.userProfile!.photo,
                        setXFile: (value) => context
                            .read<UserProfileEditBloc>()
                            .add(UserProfileEditEventSendXFile(xfile: value)),
                        maxHeightImage: 150,
                        maxWidthImage: 100,
                      ),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<bool> saveProfile() async {
  //   final formValid = _formKey.currentState?.validate() ?? false;
  //   if (formValid) {
  //     await widget._userProfileController.append(
  //       nickname: _nicknameTec.text,
  //       name: _nameTec.text,
  //       phone: _phoneTec.text,
  //       cpf: _cpfTec.text,
  //       register: _registerTec.text,
  //     );
  //     return true;
  //   }
  //   return false;
  // }
}
