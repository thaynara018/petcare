import 'package:flutter/material.dart';

class CadastroController extends ChangeNotifier {
  // Chave para validar o formulário como um todo
  final formKey = GlobalKey<FormState>();

  // Regra de Negócio: Validar e Navegar para Home
  void realizarCadastro(BuildContext context, String senha, String confirmarSenha) {
    if (formKey.currentState!.validate()) {
      // Validação Extra: Senhas iguais
      if (senha != confirmarSenha) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('As senhas não coincidem!'), backgroundColor: Colors.red),
        );
        return;
      }
      
      // Se passar em tudo, navega para a Home
      Navigator.pushNamed(context, 'home');
    }
  }

  // Navegação: Voltar para o Início
  void voltarParaInicio(BuildContext context) {
    Navigator.pushNamed(context, 'inicio');
  }

  // Navegação: Ir para o Login
  void irParaLogin(BuildContext context) {
    Navigator.pushNamed(context, 'login');
  }
}