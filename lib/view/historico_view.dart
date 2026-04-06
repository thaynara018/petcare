import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app_clinica_veterinaria/components/app_drawer.dart';
import '../controller/historico_controller.dart';

class HistoricoView extends StatelessWidget {
  HistoricoView({super.key});

  final controller = GetIt.I.get<HistoricoController>();
  static const Color primaryTeal = Color(0xFF26C1A1);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF3F4F6),
          endDrawer: const AppDrawer(), // Menu à direita
          appBar: AppBar(
            backgroundColor: primaryTeal,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            leading: BackButton(
              color: Colors.white,
              onPressed: () => controller.voltar(context),
            ),
            title: const Text(
              'Histórico Clínico',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: Column(
            children: [
              // CABEÇALHO: Seleção de Pet
              _buildPetSelector(),
              
              // SELETOR DE CATEGORIAS (Abas customizadas)
              _buildCategoryTabs(),

              // LISTA DE HISTÓRICO (Scrollable)
              Expanded(
                child: _buildHistoryList(),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- WIDGETS DE INTERFACE ---

  Widget _buildPetSelector() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Selecione o Pet', style: TextStyle(color: Colors.grey, fontSize: 12)),
          DropdownButton<String>(
            value: controller.petSelecionado,
            isExpanded: true,
            underline: Container(height: 1, color: primaryTeal.withOpacity(0.3)),
            items: controller.listaPets.map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (val) => controller.mudarPet(val),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _tabButton(0, 'Consultas'),
          _tabButton(1, 'Vacinas'),
          _tabButton(2, 'Medicamentos'),
        ],
      ),
    );
  }

  Widget _tabButton(int index, String label) {
    bool isActive = controller.abaAtiva == index;
    return GestureDetector(
      onTap: () => controller.mudarAba(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? primaryTeal : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
        ),
        child: Text(
          label,
          style: TextStyle(color: isActive ? Colors.white : Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildHistoryList() {
    List<HistoricoItem> itensExibidos;
    
    // Define qual lista mostrar baseada na aba ativa
    if (controller.abaAtiva == 0) itensExibidos = controller.consultas;
    else if (controller.abaAtiva == 1) itensExibidos = controller.vacinas;
    else itensExibidos = controller.medicamentos;

    if (itensExibidos.isEmpty) {
      return const Center(child: Text('Nenhum registro encontrado.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: itensExibidos.length,
      itemBuilder: (context, index) {
        final item = itensExibidos[index];
        return _buildHistoryCard(item);
      },
    );
  }

  Widget _buildHistoryCard(HistoricoItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ÍCONE LATERAL COM CONTAINER CLARO (Conforme a imagem)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: primaryTeal.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(item.icone, color: primaryTeal),
          ),
          const SizedBox(width: 15),
          // CONTEÚDO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('${item.data} • ${item.responsavel}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 10),
                Text(item.descricao, style: const TextStyle(fontSize: 13, color: Colors.black87)),
              ],
            ),
          ),
          // BOTÃO DOWNLOAD (Se disponível)
          if (item.temDownload)
            IconButton(
              icon: const Icon(Icons.file_download_outlined, color: primaryTeal),
              onPressed: () {
                // Futura implementação de download de PDF/Imagem
              },
            ),
        ],
      ),
    );
  }
}