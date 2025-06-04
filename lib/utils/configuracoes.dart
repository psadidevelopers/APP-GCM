import 'package:flutter/material.dart';

class Configuracoes {
  static recuperarTamanho(context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return ffem;
  }
}
