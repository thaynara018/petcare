import 'package:flutter/material.dart';

// Modelo para os itens do histórico
class HistoricoItem {
  final String titulo;
  final String data;
  final String responsavel;
  final String descricao;
  final IconData icone;
  final bool temDownload;

  HistoricoItem({
    required this.titulo,
    required this.data,
    required this.responsavel,
    required this.descricao,
    required this.icone,
    this.temDownload = false,
  });
}

class HistoricoController extends ChangeNotifier {

  // Estado: Pet e Aba selecionada
  String petSelecionado = 'Rex';
  int abaAtiva = 0; // 0: Consultas, 1: Vacinas, 2: Medicamentos

  final List<String> listaPets = ['Rex'];

  // --- DADOS DEMONSTRATIVOS ---
  
  final List<HistoricoItem> consultas = [
    HistoricoItem(
      titulo: 'Consulta de Rotina',
      data: '10/10/2025',
      responsavel: 'Dr. Carlos Silva',
      descricao: 'Check-up geral realizado. O animal apresenta batimentos normais e peso estável.',
      icone: Icons.medical_services_outlined,
    ),
  ];

  final List<HistoricoItem> vacinas = [
    HistoricoItem(
      titulo: 'Vacina V10',
      data: '15/09/2025',
      responsavel: 'Dra. Ana Santos',
      descricao: 'Reforço anual aplicado. Próxima dose recomendada em 15/09/2026.',
      icone: Icons.vaccines_outlined,
      temDownload: true, // Certificado de vacinação
    ),
  ];

  final List<HistoricoItem> medicamentos = [
    HistoricoItem(
      titulo: 'Antipulgas Bravecto',
      data: '01/08/2025',
      responsavel: 'Farmácia Pet',
      descricao: 'Administrado via oral. Proteção válida por 3 meses.',
      icone: Icons.medication_outlined,
      temDownload: true, // Receita digital
    ),
  ];

  // --- MÉTODOS ---

  void mudarPet(String? novoPet) {
    if (novoPet != null) {
      petSelecionado = novoPet;
      notifyListeners();
    }
  }

  void mudarAba(int index) {
    abaAtiva = index;
    notifyListeners();
  }

  void voltar(BuildContext context) {
    Navigator.pushNamed(context, 'home');
  }
}