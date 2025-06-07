import 'package:app_gcm_sa/components/card_nav_drawer_widget.dart';
import 'package:app_gcm_sa/utils/configuracoes.dart';
import 'package:app_gcm_sa/utils/estilos.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double ffem = Configuracoes.recuperarTamanho(context);

    return Stack(
      children: [
        Scaffold(
          appBar: Estilos.appBarHome(
            context,
            'Raphael',
            scaffoldKey,
            ffem,
            "",
            icon: true,
            imageIcon: 'assets/svgIcons/lucide--bell.svg',
          ),
          key: scaffoldKey,
          drawer: NavigationDrawerWidget(),
          backgroundColor: Estilos.branco,
          body: Container(
            color: Estilos.azulGradient4,
            child: Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Estilos.branco,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: SizedBox(
                height: 291 * ffem,
                child: Center(
                  child: Image.asset('assets/imagens/GCM-Logo.png'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
