import 'package:flutter/material.dart';

class InicioController extends ChangeNotifier {
  // Aqui você adicionaria variáveis de estado futuramente
  // Ex: bool carregando = false;

  void navegarParaLogin(BuildContext context) {
    Navigator.pushNamed(context, 'login');
    //Navigator.pushNamed(context, '/login');
  }

  void navegarParaCadastro(BuildContext context) {
    Navigator.pushNamed(context, 'cadastro');
   // Navigator.pushNamed(context, '/cadastrar');
  }

  void navegarParaSobre(BuildContext context) {
    Navigator.pushNamed(context, 'sobre');
    //Navigator.pushNamed(context, '/sobre');
  }
}