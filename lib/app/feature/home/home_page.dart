import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/authentication/bloc/authentication_bloc.dart';
import 'comp/home_card_module.dart';
import 'comp/home_popmenu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Text(
                "Olá, ${state.user?.userProfile?.name ?? 'Atualize seu perfil.'}.");
          },
        ),
        actions: const [
          HomePopMenu(),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              HomeCardModule(
                title: 'Gerenciar usuários',
                access: const ['admin'],
                onAction: () {
                  Navigator.of(context).pushNamed('/userProfile/search');
                },
                icon: Icons.people,
                color: Colors.black87,
              ),
              HomeCardModule(
                title: 'Relatórios',
                access: const ['admin'],
                onAction: () {},
                icon: Icons.print_rounded,
                color: Colors.black87,
              ),
              HomeCardModule(
                title: 'Imagens de itens',
                access: const ['patrimonio'],
                onAction: () {
                  Navigator.of(context).pushNamed('/image/search');
                },
                icon: Icons.image,
                color: Colors.black54,
              ),
              HomeCardModule(
                title: 'Adicionar item',
                access: const ['patrimonio'],
                onAction: () {
                  Navigator.of(context).pushNamed('/item/addedit');
                },
                icon: Icons.add,
                color: Colors.black54,
              ),
              // CardHome(
              //   title: 'Buscar item',
              //   access: const ['patrimonio'],
              //   onAction: () {
              //     Get.toNamed(Routes.itemSearch);
              //   },
              //   icon: Icons.content_paste_search,
              //   color: Colors.black54,
              // ),
              // CardHome(
              //   title: 'Entregar item',
              //   access: const ['reserva'],
              //   onAction: () {
              //     Get.toNamed(Routes.cautionDeliveryConsult);
              //   },
              //   icon: Icons.keyboard_tab,
              //   color: Colors.black38,
              // ),
              // CardHome(
              //   title: 'Receber item',
              //   access: const ['reserva'],
              //   onAction: () {
              //     Get.toNamed(Routes.cautionGiveback);
              //   },
              //   icon: Icons.keyboard_return,
              //   color: Colors.black38,
              // ),
              // CardHome(
              //   title: 'Cautelas',
              //   access: const ['reserva'],
              //   onAction: () {
              //     Get.toNamed(Routes.cautionSearch, arguments: false);
              //   },
              //   icon: Icons.search,
              //   color: Colors.black38,
              // ),
              // CardHome(
              //   title: 'Meus itens temporários',
              //   access: const ['operador'],
              //   onAction: () {
              //     Get.toNamed(Routes.cautionReceiver);
              //   },
              //   icon: Icons.access_time,
              //   color: Colors.black26,
              // ),
              // CardHome(
              //   title: 'Meus itens permanentes',
              //   access: const ['operador'],
              //   onAction: () {
              //     Get.toNamed(Routes.cautionReceiverPermanent);
              //   },
              //   icon: Icons.timelapse,
              //   color: Colors.black26,
              // ),
              // CardHome(
              //   title: 'Minhas cautelas',
              //   access: const ['operador'],
              //   onAction: () {
              //     // Get.toNamed(Routes.cautionReceiverHistory);
              //     Get.toNamed(Routes.cautionSearch, arguments: true);
              //   },
              //   icon: Icons.av_timer,
              //   color: Colors.black26,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cimat Bloc'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(builder: (context) {
              return BlocSelector<AuthenticationBloc, AuthenticationState,
                      String>(
                  selector: (state) => state.user?.id ?? '...',
                  builder: (context, id) => Text('id: $id'));
            }),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Text('id: ${state.user?.id}'),
                    Text('email: ${state.user?.email}'),
                    Text('email: ${state.user?.userProfile}'),
                  ],
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationEventLogoutRequested());
                },
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
*/