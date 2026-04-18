import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {

  //CHAVE VALIDAÇÃO FORMULÁRIO
  final formKey = GlobalKey<FormState>();

  //NAVEGAÇÕES

  //Para a Home após validação
  void realizarLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      //Se o formulário for válido
      Navigator.pushNamed(context, 'home');
    }
  }

  void irParaRecuperarSenha(BuildContext context) {
    Navigator.pushNamed(context, 'recuperar_senha');
  }

  void irParaCadastro(BuildContext context) {
    Navigator.pushNamed(context, 'cadastro');
  }

  void voltarParaInicio(BuildContext context) {
    Navigator.pushNamed(context, 'inicio');
  }
}