import 'package:flutter/material.dart';

class RecuperarSenhaController extends ChangeNotifier {
  // Chave para validar o TextFormField
  final formKey = GlobalKey<FormState>();

  // Lógica de Recuperação
  void solicitarRecuperacao(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // Se o e-mail for válido, exibe o Pop-up de sucesso
      _exibirPopupSucesso(context);
    }
  }

  // Pop-up de Sucesso (Dialog)
  void _exibirPopupSucesso(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('E-mail Enviado!'),
          content: const Text(
            'As instruções para redefinição de senha foram enviadas para o seu e-mail cadastrado.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o Pop-up
                irParaLogin(context);   // Navega para o Login
              },
              child: const Text('OK', style: TextStyle(color: Color(0xFF26C1A1))),
            ),
          ],
        );
      },
    );
  }

  // NAVEGAÇÃO: Voltar para Início (usado no botão back da AppBar)
  void irParaInicio(BuildContext context) {
    Navigator.pushNamed(context, 'inicio');
  }

  // NAVEGAÇÃO: Voltar para o Login
  void irParaLogin(BuildContext context) {
    Navigator.pushNamed(context, 'login');
  }
}