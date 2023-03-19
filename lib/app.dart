import 'package:cimat_bloc/app/data/b4a/table/user/user_repository_b4a.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/core/authentication/bloc/authentication_bloc.dart';
import 'app/view/home/home_page.dart';
import 'app/view/splash/splash_page.dart';
import 'app/view/user/login/login_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final UserRepositoryB4a _userRepository;

  @override
  void initState() {
    super.initState();
    _userRepository = UserRepositoryB4a();
  }

  @override
  void dispose() {
    // _userRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _userRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          userRepository: _userRepository,
        )..add(AuthenticationEventInitial()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      navigatorKey: _navigatorKey,

      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(), (route) => false);
            } else if (state.status == AuthenticationStatus.unauthenticated) {
              _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(), (route) => false);
            } else {
              return;
            }
          },
          child: child,
        );
      },
      // onGenerateRoute: (_) => SplashPage.route(),
      routes: {
        '/': (_) => const SplashPage(),
      },
      initialRoute: '/',
    );
  }
}
