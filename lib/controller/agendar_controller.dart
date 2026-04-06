import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Necessário para formatar a data dd/mm/aaaa

class AgendarController extends ChangeNotifier {
  // Chave para validação do formulário (torna os campos obrigatórios)
  final formKey = GlobalKey<FormState>();

  // --- ESTADO DA TELA ---
  DateTime dataSelecionada = DateTime.now();
  String? petSelecionado;
  String? servicoSelecionado;
  String? horarioSelecionado;
  final obsCtrl = TextEditingController();

  // --- REGRAS DE NEGÓCIO ---
  
  // Define o limite máximo de 4 meses a partir de hoje
  DateTime get dataLimite => DateTime.now().add(const Duration(days: 120));

  // Formata a data para o padrão brasileiro no resumo
  String get dataFormatada => DateFormat('dd/MM/yyyy', 'pt_BR').format(dataSelecionada);

  // Lista de horários de 1h em 1h (07h às 18h)
  final List<String> listaHorarios = List.generate(12, (index) => '${index + 7}:00');

  // Principais serviços veterinários
  final List<String> listaServicos = [
    'Consulta de Rotina',
    'Vacinação',
    'Exames de Sangue',
    'Castração',
    'Limpeza de Tártaro',
    'Cirurgia Geral',
    'Banho e Tosa'
  ];

  // Lista de pets (Simulada - futuramente virá do MyPetsController)
  final List<String> listaPets = ['Rex'];

  // --- MÉTODOS DE ATUALIZAÇÃO ---

  void setData(DateTime data) {
    dataSelecionada = data;
    notifyListeners(); // Notifica a View para atualizar o resumo
  }

  void setPet(String? pet) {
    petSelecionado = pet;
    notifyListeners();
  }

  void setServico(String? servico) {
    servicoSelecionado = servico;
    notifyListeners();
  }

  void setHorario(String? horario) {
    horarioSelecionado = horario;
    notifyListeners();
  }

  // --- NAVEGAÇÃO E AÇÕES ---

  void confirmarAgendamento(BuildContext context) {
    // 1. Valida se os campos de texto (Observações) estão preenchidos
    if (formKey.currentState!.validate()) {
      
      // 2. Valida se os Dropdowns (seleções) não estão nulos
      if (petSelecionado == null || servicoSelecionado == null || horarioSelecionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, preencha todos os campos da consulta!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // 3. Feedback de Sucesso (Pop-up)
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF26C1A1)),
              SizedBox(width: 10),
              Text('Confirmado!'),
            ],
          ),
          content: Text(
            'O agendamento de $servicoSelecionado para o pet $petSelecionado foi realizado com sucesso para o dia $dataFormatada às $horarioSelecionado.',
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF26C1A1)),
              onPressed: () {
                Navigator.pop(context); // Fecha o pop-up
                Navigator.pushNamed(context, 'home'); // NAVEGAÇÃO: Volta para Home
              },
              child: const Text('Entendido', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
  }

  void voltar(BuildContext context) {
    Navigator.pushNamed(context, 'home');
  }
}


