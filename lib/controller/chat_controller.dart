import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessage {
  final String text;
  final String time;
  final bool isMe;
  ChatMessage({required this.text, required this.time, required this.isMe});
}

class ChatController extends ChangeNotifier {
  final List<ChatMessage> mensagens = [];
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool podeEnviar = false;

  ChatController() {
    _inicializarConversa();
    messageController.addListener(() {
      podeEnviar = messageController.text.trim().isNotEmpty;
      notifyListeners();
    });
  }

  void _inicializarConversa() {
    final horaAtual = DateFormat('HH:mm').format(DateTime.now());
    mensagens.add(ChatMessage(text: 'Olá, como posso ajudar?', time: horaAtual, isMe: false));
  }

  void enviarMensagem() {
    final texto = messageController.text.trim();
    if (texto.isNotEmpty) {
      final hora = DateFormat('HH:mm').format(DateTime.now());
      mensagens.add(ChatMessage(text: texto, time: hora, isMe: true));
      messageController.clear();
      notifyListeners();
      _scrollParaOFinal();
    }
  }

  // MÉTODO PARA ANEXOS: Centraliza as opções de mídia
  void abrirOpcoesAnexo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _itemAnexo(context, Icons.image, 'Foto', Colors.purple),
            _itemAnexo(context, Icons.videocam, 'Vídeo', Colors.pink),
            _itemAnexo(context, Icons.insert_drive_file, 'Documento', Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _itemAnexo(BuildContext context, IconData icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }

  void _scrollParaOFinal() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  void voltarParaHome(BuildContext context) => Navigator.pushNamed(context, 'home');
}