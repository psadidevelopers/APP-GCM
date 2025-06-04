// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/estilos.dart';

// ignore: must_be_immutable
class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  late List<Map<String, dynamic>> _allMenuItems;

  // Future<void> _loadEnvironment() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     environment = prefs.getString('environment') ?? "producao";
  //   });
  // }

  Widget buildMenuItem({
    required String text,
    IconData? icon,
    String? iconSvg,
    VoidCallback? onClicked,
    int? notificacoes,
    List<Map<String, dynamic>>? children,
    bool isParent = false,
  }) {
    const color = Estilos.cinzaMenu;

    if (children != null) {
      children = children.where((element) => element.isNotEmpty).toList();
    } else {
      children = [];
    }

    return !isParent
        ? GestureDetector(
          onTap: onClicked,
          child: Container(
            margin: const EdgeInsets.only(left: 24, right: 24, bottom: 0),
            padding: const EdgeInsets.only(
              top: 0,
              bottom: 0,
              left: 12,
              right: 20,
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      iconSvg == null
                          ? Icon(icon, color: color, size: 20)
                          : SvgPicture.asset(
                            iconSvg,
                            // ignore: deprecated_member_use
                            color: color,
                            width: 20,
                            height: 20,
                          ),
                      const SizedBox(width: 12),
                      Text(
                        text,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  if (notificacoes != null)
                    if (notificacoes > 0)
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: Estilos.azulGradient3,
                          // borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            notificacoes > 99 ? '99+' : notificacoes.toString(),
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Estilos.branco,
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        )
        : Container(
          margin: const EdgeInsets.only(left: 24, right: 24, bottom: 0),
          padding: const EdgeInsets.only(top: 0, bottom: 0, left: 12),
          child: Column(
            children: [
              Theme(
                data: ThemeData(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  childrenPadding: EdgeInsets.zero,
                  tilePadding: EdgeInsets.zero,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            iconSvg!,
                            // ignore: deprecated_member_use
                            color: Estilos.cinzaMenu,
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            text,
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Estilos.cinzaMenu,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }

  @override
  void initState() {
    super.initState();

    _allMenuItems = [
      {
        'name': 'Inicio',
        'item': buildMenuItem(
          text: 'Inicio',
          iconSvg: 'assets/svgIcons/home.svg',
          onClicked: () => context.go("/home"),
          isParent: false,
        ),
      },
      {
        'name': 'Cadastro',
        'item': buildMenuItem(
          text: 'Cadastro',
          iconSvg: 'assets/svgIcons/user-round.svg',
          onClicked: () => context.go("/cadastro"),
          isParent: false,
        ),
      },
      {
        'name': 'Eventos',
        'item': buildMenuItem(
          text: 'Eventos',
          iconSvg: 'assets/svgIcons/lucide--calendar-days.svg',
          onClicked: () => context.go("/eventos"),
          isParent: false,
        ),
      },

      // Espaço
      {'name': '', 'item': const SizedBox(height: 10)},

      // Divider UX
      {'name': '', 'item': dividerUx()},

      // Sair
      {
        'name': 'name',
        'item': buildMenuItemSair(
          text: 'Sair',
          iconSvg: 'assets/svgIcons/log-out.svg',
          onClicked: () => sairApp(context),
        ),
      },
    ];
  }

  List<Map<String, dynamic>> searchSubMenuItems(String query) {
    List<Map<String, dynamic>> subMenuItems = [];

    for (var item in _allMenuItems) {
      if (item['name'].toLowerCase().contains(query.toLowerCase())) {
        subMenuItems.add(item);
      }

      List<Map<String, dynamic>>? children =
          (item['children'] as List<dynamic>?)
              ?.map((e) => Map<String, dynamic>.from(e as Map))
              .toList();

      if (children != null) {
        for (var child in children) {
          if (child.containsKey('title') &&
              child['title'].toLowerCase().contains(query.toLowerCase())) {
            subMenuItems.add({
              'name': child['title'],
              'item': ListTile(
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        child['icon'],
                        // ignore: deprecated_member_use
                        color: Estilos.cinzaMenu,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        child['title'],
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Estilos.cinzaMenu,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: child['onClicked'],
              ),
            });
          }
        }
      }
    }

    return subMenuItems;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        return;
      },
      child: SizedBox(
        // Para Funcionar precisa se o container a metade do botão maior do que o Drawer
        // Por Exemplo: Drawer = 270 botão = 30 o container deve ser = 285 ou seja 270 + (30 / 2)
        width: (MediaQuery.of(context).size.width * 0.9) + 15,
        child: Stack(
          children: [
            Drawer(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    15,
                  ), // Borda arredondada no canto superior direito
                  bottomRight: Radius.circular(
                    15,
                  ), // Borda arredondada no canto inferior direito
                ),
              ),
              backgroundColor: Estilos.branco,
              //width: 270,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Container(
                color: Estilos.branco,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _allMenuItems.length,
                        itemBuilder: (context, index) {
                          return _allMenuItems[index]['item'];
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/imagens/marca_psa_horizontal.png',
                      width: 113,
                    ),

                    // Versão do App
                    Container(
                      padding: const EdgeInsets.only(bottom: 24, top: 14),
                      child: Text(
                        'Versão 1.0.0',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Estilos.cinzaClaroAzulado,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Aqui carrega o botão de retornar para funcionar precisa de um container maior que o Drawer
            Positioned(
              top: 60,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Estilos.branco,
                    border: Border.all(
                      color: const Color.fromARGB(255, 246, 246, 246),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Estilos.azulGradient3,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Menu de opões de Sair
  Widget buildMenuItemSair({
    required String text,
    IconData? icon,
    String? iconSvg,
    VoidCallback? onClicked,
  }) {
    const color = Estilos.vermelhoMenu;

    return GestureDetector(
      onTap: onClicked,
      child: Container(
        color: Estilos.branco,
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 30,
          left: 12,
          right: 12,
        ),
        child: Row(
          children: [
            iconSvg == null
                ? Icon(icon, color: color, size: 20)
                : SvgPicture.asset(iconSvg, width: 20, height: 20),
            const SizedBox(width: 12),
            Text(
              text,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  // Divisor UX
  Widget dividerUx() {
    return const Divider(
      color: Estilos.cinzaDivider,
      indent: 24,
      endIndent: 24,
      thickness: 2,
      height: 24,
    );
  }

  // Sair do App
  void sairApp(BuildContext context) async {
    context.go("/");
    // try {
    // Limpa dados do usuário armazenas no shared preferences
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.clear();

    //   // Limpa o token de mensagens do Firebase
    //   await FirebaseMessaging.instance.deleteToken();

    //   // fechar o banco de dados
    //   DatabaseHelper databaseHelper = Modular.get<DatabaseHelper>();
    //   databaseHelper.closeDatabase();

    //   /// Limpa campos de login
    //   loginController.textFieldLoginCpfController.text = "";
    //   loginController.textFieldLoginSenhaController.text = "";

    //   widget.imageFile = null;

    //   /// Limpa dados do servidor controller
    //   servidorController.limparDados();

    //   // Modular.to.navigate('/');
    // } finally {
    //   Modular.to.navigate('/');
    //   debugPrint("Sair do App - 2");
    // }
  }
}
