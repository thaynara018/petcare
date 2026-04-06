import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app_clinica_veterinaria/components/app_drawer.dart';
import '../controller/notificacao_controller.dart';

class NotificacaoView extends StatelessWidget {
  NotificacaoView({super.key});

  // Localiza o controller via GetIt
  final controller = GetIt.I.get<NotificacaoController>();
  static const Color primaryTeal = Color(0xFF26C1A1);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF3F4F6),
          // MENU À DIREITA: endDrawer garante que o ícone do menu apareça na direita
          endDrawer: const AppDrawer(),
          appBar: AppBar(
            backgroundColor: primaryTeal,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            // NAVEGAÇÃO: Botão voltar padrão para a Home
            leading: BackButton(
              color: Colors.white,
              onPressed: () => controller.voltarParaHome(context),
            ),
            title: const Text(
              'Notificações',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // Actions vazio para o ícone do endDrawer aparecer sozinho
            actions: const [],
          ),
          
          body: Column(
            children: [
              // NOVO LUGAR DO BOTÃO: Cabeçalho de ações da lista
              _buildHeaderActions(),

              // LISTA DE NOTIFICAÇÕES COM SCROLL
              Expanded(
                child: controller.listaNotificacoes.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: controller.listaNotificacoes.length,
                        itemBuilder: (context, index) {
                          final item = controller.listaNotificacoes[index];
                          return _buildNotificationCard(item);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- COMPONENTES DE INTERFACE ---

  // Widget que contém o contador e o botão de marcar como lidas
  Widget _buildHeaderActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${controller.listaNotificacoes.length} notificações',
            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
          // Botão movido da AppBar para cá
          GestureDetector(
            onTap: () => controller.marcarTodasComoLidas(),
            child: const Text(
              'Marcar todas como lidas',
              style: TextStyle(
                color: Colors.black87, 
                fontSize: 13, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text('Nenhuma notificação por aqui.', style: TextStyle(color: Colors.grey)),
    );
  }

  Widget _buildNotificationCard(NotificacaoItem item) {
    return AnimatedOpacity(
      // Se lida, fica com 50% de opacidade (0.5)
      opacity: item.isLida ? 0.5 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: item.corIcone.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icone, color: item.corIcone, size: 24),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.titulo,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        item.data,
                        style: const TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.descricao,
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




