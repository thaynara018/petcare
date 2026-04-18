import 'package:flutter/material.dart';

class SobreController extends ChangeNotifier {
  //NAVEGAÇÃO
  void voltarParaInicio(BuildContext context) {
    Navigator.pushNamed(context, 'inicio');
  }
}