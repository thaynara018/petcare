import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/home_controller.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Recuperando o controller via GetIt
    final controller = GetIt.I.get<HomeController>();
    const Color primaryTeal = Color(0xFF26C1A1);

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: primaryTeal),
            child: Center(
              child: Text(
                'PetCare\n  Menu',
                style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          _buildItem(context, Icons.home, 'Início', () => controller.navegar(context, 'home')),
          _buildItem(context, Icons.pets, 'Meus Pets', () => controller.navegar(context, 'my_pets')),
          _buildItem(context, Icons.calendar_month, 'Agendar Consultas', () => controller.navegar(context, 'agendar')),
          _buildItem(context, Icons.notifications, 'Notificações', () => controller.navegar(context, 'notificacao')),
          _buildItem(context, Icons.chat, 'Conversar com a Clínica', () => controller.navegar(context, 'chat')),
          _buildItem(context, Icons.description, 'Histórico Clínico', () => controller.navegar(context, 'historico')),
          const Spacer(),
          const Divider(),
          _buildItem(context, Icons.logout, 'Sair', () => controller.confirmarSair(context), color: Colors.red),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Widget auxiliar para os itens do menu
  Widget _buildItem(BuildContext context, IconData icon, String titulo, VoidCallback acao, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black87),
      title: Text(titulo, style: TextStyle(color: color ?? Colors.black87, fontWeight: FontWeight.w500)),
      onTap: () {
        Navigator.pop(context); // Fecha o menu lateral
        acao();
      },
    );
  }
}