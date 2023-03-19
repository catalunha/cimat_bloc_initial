import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../data/b4a/table/user/user_repository_b4a.dart';
import '../../utils/app_button.dart';
import '../../utils/app_textformfield.dart';
import 'bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(
            userRepository: RepositoryProvider.of<UserRepositoryB4a>(context)),
        // child: Container(),
        child: const LoginView(),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailTec = TextEditingController();
  final _passwordTec = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailTec.text = 'catalunha.mj@gmail.com123';
    _passwordTec.text = '123456';
  }

  @override
  void dispose() {
    _emailTec.dispose();
    _passwordTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constrainsts) {
          return Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constrainsts.maxHeight,
                  maxWidth: 400,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Login',
                            // style: context.textTheme.titleLarge?.copyWith(
                            //   fontWeight: FontWeight.bold,
                            //   // color: context.theme.primaryColorDark,
                            // ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AppTextFormField(
                            label: 'Informe seu e-mail',
                            controller: _emailTec,
                            validator: Validatorless.multiple([
                              Validatorless.required('email obrigatório.'),
                              Validatorless.email('Email inválido.'),
                            ]),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          AppTextFormField(
                            label: 'Informe a Senha',
                            controller: _passwordTec,
                            obscureText: true,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required('Senha obrigatória.'),
                                Validatorless.min(6, 'Minimo de 6 caracteres.'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          AppButton(
                            label: 'Acessar',
                            onPressed: () {
                              final formValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                context.read<LoginBloc>().add(
                                      LoginEventFormSubmitted(
                                        username: _emailTec.text,
                                        password: _passwordTec.text,
                                      ),
                                    );
                              }
                            },
                            // width: context.width,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Esqueceu sua senha ?'),
                              TextButton(
                                onPressed: () {
                                  // if (_emailTec.text.isNotEmpty) {
                                  //   widget._loginController
                                  //       .forgotPassword(_emailTec.text.trim());
                                  // } else {
                                  //   Get.snackbar(
                                  //     'Oops',
                                  //     'Digite email para prosseguir',
                                  //     // backgroundColor: Colors.red,
                                  //     margin: const EdgeInsets.all(10),
                                  //   );
                                  // }
                                },
                                child: const Text(
                                  'Criar uma nova.',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Não possui uma conta ?'),
                              TextButton(
                                onPressed: () {
                                  // Get.toNamed(Routes.userRegisterEmail);
                                },
                                child: const Text(
                                  'CADASTRE-SE.',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/*
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameTEC = TextEditingController();
  final _passwordTEC = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameTEC.text = 'catalunha.mj@gmail.com';
    _passwordTEC.text = '123456';
  }

  @override
  void dispose() {
    _usernameTEC.dispose();
    _passwordTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStateStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.error ?? '...')));
        }
        if (state.status == LoginStateStatus.success) {
          context
              .read<AuthenticationBloc>()
              .add(AuthenticationEventReceiveUser(state.user));
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameTEC,
              decoration: const InputDecoration(label: Text('nome de usuario')),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Informação obrigatória';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordTEC,
              decoration: const InputDecoration(label: Text('senha')),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Informação obrigatória';
                }
                return null;
              },
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return state.status == LoginStateStatus.loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          final validate =
                              _formKey.currentState?.validate() ?? false;
                          if (validate) {
                            context.read<LoginBloc>().add(
                                  LoginEventFormSubmitted(
                                    username: _usernameTEC.text,
                                    password: _passwordTEC.text,
                                  ),
                                );
                          }
                        },
                        child: const Text('Login'),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/