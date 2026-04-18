import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app_clinica_veterinaria/components/app_drawer.dart';
import '../controller/notificacao_controller.dart';

class NotificacaoView extends StatelessWidget {
  NotificacaoView({super.key});

  //Localiza o controller via GetIt
  final controller = GetIt.I.get<NotificacaoController>();
  static const Color primaryTeal = Color(0xFF26C1A1);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF3F4F6),
          endDrawer: const AppDrawer(), //MENU À DIREITA
          appBar: AppBar(
            backgroundColor: primaryTeal,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            //NAVEGAÇÃO
            leading: BackButton(
              color: Colors.white,
              onPressed: () => controller.voltarParaHome(context),
            ),
            title: const Text(
              'Notificações',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            //Actions vazio para o ícone do endDrawer aparecer sozinho
            actions: const [],
          ),
          
          body: Column(
            children: [
              //LUGAR DO BOTÃO CABEÇALHOS DE AÇÕES DA LISTA
              _buildHeaderActions(),

              //LISTA DE NOTIFICAÇÕES
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

  //CONTADOR E MARCADOR DE LEITURA
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
          //BOTÃO MARCAR LIDAS
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
      //OPACIDADE SE LIDA
      opacity: item.isLida ? 0.5 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 10)
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: item.corIcone,
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




