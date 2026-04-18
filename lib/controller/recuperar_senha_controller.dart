import 'package:flutter/material.dart';

class RecuperarSenhaController extends ChangeNotifier {

  //CHAVE VALIDAÇÃO FORMULÁRIO
  final formKey = GlobalKey<FormState>();

  //LÓGICA DE RECUPERAÇÃO
  void solicitarRecuperacao(BuildContext context) {
    if (formKey.currentState!.validate()) {
      //SE VÁLIDO
      _exibirPopupSucesso(context);
    }
  }

  //POP-UP FEEDBACK DE SUCESSO
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
                Navigator.pop(context); //NAVEGAÇÃO
              },
              child: const Text('OK', style: TextStyle(color: Color(0xFF26C1A1))),
            ),
          ],
        );
      },
    );
  }

  //NAVEGAÇÃO
  void irParaInicio(BuildContext context) {
    Navigator.pushNamed(context, 'inicio');
  }

  //NAVEGAÇÃO
  void irParaLogin(BuildContext context) {
    Navigator.pushNamed(context, 'login');
  }
}