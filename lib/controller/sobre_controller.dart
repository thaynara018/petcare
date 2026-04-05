import 'package:flutter/material.dart';

class SobreController extends ChangeNotifier {
  // Navegação: Retorna para a tela de início
  void voltarParaInicio(BuildContext context) {
    Navigator.pushNamed(context, 'inicio');
  }
}