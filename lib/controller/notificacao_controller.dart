import 'package:flutter/material.dart';

class NotificacaoItem {
  final String titulo;
  final String descricao;
  final String data;
  final IconData icone;
  final Color corIcone;
  bool isLida; // Define se o card ficará opaco ou não

  NotificacaoItem({
    required this.titulo,
    required this.descricao,
    required this.data,
    required this.icone,
    required this.corIcone,
    this.isLida = false,
  });
}

class NotificacaoController extends ChangeNotifier {
  // Lista inicial com os exemplos solicitados
  final List<NotificacaoItem> listaNotificacoes = [
    NotificacaoItem(
      titulo: 'Consulta Agendada',
      descricao: 'Rex tem consulta amanhã às 14:30.',
      data: 'Ontem',
      icone: Icons.calendar_month,
      corIcone: const Color(0xFF26C1A1),
    ),
    NotificacaoItem(
      titulo: 'Atraso na Vacinação',
      descricao: 'Bob está com a vacina antirrábica atrasada.',
      data: '3 dias atrás',
      icone: Icons.priority_high,
      corIcone: Colors.orange,
    ),
  ];

  // Ação para marcar todas como lidas
  void marcarTodasComoLidas() {
    for (var notificacao in listaNotificacoes) {
      notificacao.isLida = true;
    }
    notifyListeners(); // Atualiza a interface
  }

  // NAVEGAÇÃO: Volta para a Home
  void voltarParaHome(BuildContext context) {
    Navigator.pushNamed(context, 'home');
  }
}