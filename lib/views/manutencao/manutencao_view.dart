import 'package:flutter/material.dart';

import '../../utils/estilos.dart';
import '../../utils/utils.dart';

class ManutencaoView extends StatefulWidget {
  const ManutencaoView({required this.title, super.key});
  final String title;

  @override
  State<ManutencaoView> createState() => _ManutencaoViewState();
}

class _ManutencaoViewState extends State<ManutencaoView> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = (fem * 0.97);

    return Scaffold(
      appBar: Estilos.appBarBranca(context, ffem),
      backgroundColor: Estilos.branco,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(21 * ffem, 18 * ffem, 21 * ffem, 70),
              alignment: Alignment.topLeft,
              child: Text(
                widget.title,
                style: Utils.safeGoogleFont(
                  'Nunito',
                  color: const Color(0xFF021B79),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
              child: Column(
                children: [
                  Image.asset('assets/imagens/manutencao.png', height: 200),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      'Em Manutenção',
                      textAlign: TextAlign.center,
                      style: Utils.safeGoogleFont(
                        color: const Color(0xFF1C1939),
                        fontSize: 16,
                        'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      'Verifique novamente mais tarde.',
                      textAlign: TextAlign.center,
                      style: Utils.safeGoogleFont(
                        color: const Color(0xFF7D8CBA),
                        fontSize: 12,
                        'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
