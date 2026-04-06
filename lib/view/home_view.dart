import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app_clinica_veterinaria/components/app_drawer.dart'; 
import '../controller/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final controller = GetIt.I.get<HomeController>();
  static const Color primaryTeal = Color(0xFF26C1A1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      drawer: const AppDrawer(), 
      appBar: AppBar(
        backgroundColor: primaryTeal,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Início',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none), 
            onPressed: () => controller.navegar(context, 'notificacao')
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app), 
            onPressed: () => controller.confirmarSair(context)
          ),
        ],
      ),
      // --- SCROLL VERTICAL ATIVADO ---
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // Efeito de "elástico" ao rolar
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bem-vindo de volta!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),

            // --- SCROLL HORIZONTAL ATIVADO ---
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildStatCard(
                    context, 
                    Icons.pets, 
                    'Meus Pets', 
                    'my_pets'
                  ),
                  _buildStatCard(
                    context, 
                    Icons.calendar_today, 
                    'Agendar', 
                    'agendar'
                  ),
                  _buildStatCard(
                    context, 
                    Icons.notifications, 
                    'Notificações', 
                    'notificacao'
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              'Próximos Eventos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            _buildAppointmentItem('Castração - Rex', '19/04 às 16h00', Colors.teal),
            _buildAppointmentItem('Vacinação - Rex', '21/04 às 08h00', Colors.orange),
            
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryTeal, 
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => controller.navegar(context, 'agendar'),
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Nova Consulta',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              'Ações Rápidas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            _buildQuickAction(
              Icons.history, 
              'Ver Histórico Clínico', 
              () => controller.navegar(context, 'historico')
            ),
            _buildQuickAction(
              Icons.forum, 
              'Falar com a Clínica', 
              () => controller.navegar(context, 'chat')
            ),
            _buildQuickAction(
              Icons.add_reaction, 
              'Adicionar Novo Pet', 
              () => controller.navegar(context, 'my_pets')
            ),
          ],
        ),
      ),
    );
  }

  // --- COMPONENTES AUXILIARES ---

  Widget _buildStatCard(BuildContext context, IconData icon, String label, String rota) {
    return GestureDetector(
      onTap: () => controller.navegar(context, rota),
      child: Container(
        width: 150, // Aumentado levemente para destacar o scroll
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: primaryTeal, size: 28),
            const SizedBox(height: 15),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const Text('Gerenciar', style: TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentItem(String titulo, String subtitulo, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(Icons.event, color: color, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitulo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          //const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, VoidCallback acao) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          alignment: Alignment.centerLeft,
          side: BorderSide(color: Colors.grey.shade200),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: acao,
        icon: Icon(icon, color: Colors.grey),
        label: Text(label, style: const TextStyle(color: Colors.black87)),
      ),
    );
  }
}







