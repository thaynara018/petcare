import 'package:flutter/material.dart';

// --- CONTROLLER ---
// Gerencia a lógica de navegação e o estado da tela principal
class HomeController extends ChangeNotifier {
  
  // PONTO DE NAVEGAÇÃO: Realiza o logoff limpando a pilha de telas
  void confirmarSair(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair da conta'),
        content: const Text('Deseja realmente encerrar sua sessão?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // NAVEGAÇÃO: Volta para a tela inicial e remove todas as outras da memória
              Navigator.pushNamedAndRemoveUntil(context, 'inicio', (route) => false);
            },
            child: const Text('Sair', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // PONTO DE NAVEGAÇÃO: Método genérico para transição entre telas
  void navegar(BuildContext context, String rota) {
    Navigator.pushNamed(context, rota);
  }
}


