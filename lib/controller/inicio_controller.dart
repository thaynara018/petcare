import 'package:flutter/material.dart';

class InicioController extends ChangeNotifier {
  //futuramente adicionar variáveis de estado ex: bool carregando = false;

  void navegarParaLogin(BuildContext context) {
    Navigator.pushNamed(context, 'login');
  }

  void navegarParaCadastro(BuildContext context) {
    Navigator.pushNamed(context, 'cadastro');
  }

  void navegarParaSobre(BuildContext context) {
    Navigator.pushNamed(context, 'sobre');
  }
}