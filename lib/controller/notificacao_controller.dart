import 'package:flutter/material.dart';

class NotificacaoItem {
  final String titulo;
  final String descricao;
  final String data;
  final IconData icone;
  final Color corIcone;
  bool isLida; //DEFINE SE O CARD FICARÁ OPACO OU NÃO

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
  //LISTTA INICIAL COM EXEMPLOS
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

  //AÇÃO MARCAR TODAS LIDAS
  void marcarTodasComoLidas() {
    for (var notificacao in listaNotificacoes) {
      notificacao.isLida = true;
    }
    notifyListeners(); //ATUALIZA
  }

  //NAVEGAÇÃO
  void voltarParaHome(BuildContext context) {
    Navigator.pushNamed(context, 'home');
  }
}