import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app_clinica_veterinaria/components/app_drawer.dart';
import '../controller/chat_controller.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});

  final controller = GetIt.I.get<ChatController>();
  static const Color primaryTeal = Color(0xFF26C1A1);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF3F4F6),
          endDrawer: const AppDrawer(), // Menu à direita mantendo o padrão
          appBar: AppBar(
            backgroundColor: primaryTeal,
            elevation: 1,
            iconTheme: const IconThemeData(color: Colors.white),
            // NAVEGAÇÃO: Botão voltar para Home
            leading: BackButton(onPressed: () => controller.voltarParaHome(context)),
            title: const Row(
              children: [
                CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.pets, color: Colors.white)),
                SizedBox(width: 12),
                Text('Chat Clínica', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.all(20),
                  itemCount: controller.mensagens.length,
                  itemBuilder: (context, index) => _buildChatBubble(controller.mensagens[index], context),
                ),
              ),
              _buildInputArea(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChatBubble(ChatMessage msg, BuildContext context) {
    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        decoration: BoxDecoration(
          color: msg.isMe ? primaryTeal : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(msg.isMe ? 20 : 0),
            bottomRight: Radius.circular(msg.isMe ? 0 : 20),
          ),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
        ),
        child: Column(
          crossAxisAlignment: msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // PROPORÇÃO: Texto aumentado para 18 para melhor leitura
            Text(
              msg.text,
              style: TextStyle(color: msg.isMe ? Colors.white : Colors.black87, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(msg.time, style: TextStyle(fontSize: 12, color: msg.isMe ? Colors.white70 : Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: const BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: Row(
          children: [
            // BOTÃO NO CANTO INFERIOR ESQUERDO: Anexos
            IconButton(
              icon: const Icon(Icons.add_a_photo_outlined, color: primaryTeal, size: 28),
              onPressed: () => controller.abrirOpcoesAnexo(context),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(30)),
                child: TextField(
                  controller: controller.messageController,
                  // PROPORÇÃO: Texto de input também em 18
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(hintText: 'Mensagem...', border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // BOTÃO ENVIAR
            GestureDetector(
              onTap: controller.enviarMensagem,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: controller.podeEnviar ? primaryTeal : Colors.grey.shade300,
                child: const Icon(Icons.send, color: Colors.white, size: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}