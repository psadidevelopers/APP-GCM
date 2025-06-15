import 'package:app_gcm_sa/components/btn_padrao_square.dart';
import 'package:app_gcm_sa/components/card_nav_drawer_widget.dart';
import 'package:app_gcm_sa/utils/configuracoes.dart';
import 'package:app_gcm_sa/utils/estilos.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItem {
  MenuItem({required this.text, required this.link, required this.iconSvg});

  late String text;
  late String link;
  late String iconSvg;
}

List<MenuItem> menus = [
  MenuItem(
    text: "Cadastro",
    link: "/cadastro",
    iconSvg: "assets/svgIcons/user-round.svg",
  ),
  MenuItem(
    text: "Eventos",
    link: "/eventos",
    iconSvg: "assets/svgIcons/lucide--calendar-days.svg",
  ),
];

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double ffem = Configuracoes.recuperarTamanho(context);

    return Stack(
      children: [
        Scaffold(
          appBar: Estilos.appBarHome(context, 'Raphael', scaffoldKey, ffem, ""),
          key: scaffoldKey,
          drawer: NavigationDrawerWidget(),
          backgroundColor: Estilos.branco,
          body: Container(
            color: Estilos.azulGradient4,
            child: Container(
              decoration: const BoxDecoration(
                color: Estilos.branco,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: Colors.transparent,
                    height: 160 * ffem,
                    child: Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: menus.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left:
                                  index == 0
                                      ? 16.0 * ffem
                                      : 0, // Espaçamento à esquerda do primeiro item
                              top: 8.0 * ffem, // Espaçamento superior
                              bottom: 20.0 * ffem, // Espaçamento inferior
                              right:
                                  0.0, // Espaçamento direito entre itens (opcional)
                            ),
                            child: BtnPadraoSquare(
                              onTap: () => context.go(menus[index].link),
                              icon: menus[index].iconSvg,
                              textBtn: menus[index].text,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 145 * ffem,
                    child: Image.asset('assets/imagens/GCM-Logo.png'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
