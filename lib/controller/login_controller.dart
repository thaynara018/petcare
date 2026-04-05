import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  // Chave global para o formulário, permitindo validar todos os campos de uma vez
  final formKey = GlobalKey<FormState>();

  // Navegação: Ponto centralizado para ir para a Home após validação
  void realizarLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // Se o formulário for válido, navega para a Home
      Navigator.pushNamed(context, 'home');
    }
  }

  // Navegação: Para Recuperar Senha
  void irParaRecuperarSenha(BuildContext context) {
    Navigator.pushNamed(context, 'recuperar_senha');
  }

  // Navegação: Para Cadastro
  void irParaCadastro(BuildContext context) {
    Navigator.pushNamed(context, 'cadastro');
  }

  // Navegação: Voltar para o Início
  void voltarParaInicio(BuildContext context) {
    Navigator.pushNamed(context, 'inicio');
  }
}