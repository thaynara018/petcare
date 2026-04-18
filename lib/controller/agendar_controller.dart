import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //PARA FORMATAR DATA

class AgendarController extends ChangeNotifier {

  //CHAVE VALIDAÇÃO FORMULÁRIO (torna os campos obrigatórios)
  final formKey = GlobalKey<FormState>();

  //ESTADO DA TELA
  DateTime dataSelecionada = DateTime.now();
  String? petSelecionado;
  String? servicoSelecionado;
  String? horarioSelecionado;
  final obsCtrl = TextEditingController();

  // --- REGRAS DE NEGÓCIO ---
  
  //LIMITE MAXIMO PARA AGENDAMENTO 4 MESES
  DateTime get dataLimite => DateTime.now().add(const Duration(days: 120));

  //FORMATA A DATA BR
  String get dataFormatada => DateFormat('dd/MM/yyyy', 'pt_BR').format(dataSelecionada);

  //LISTA HORÁRIOS DE 1H EM 1H DAS 7H ÀS 18H
  final List<String> listaHorarios = List.generate(12, (index) => '${index + 7}:00');

  //PRINCIPAIS SERVIÇOS
  final List<String> listaServicos = [
    'Consulta de Rotina',
    'Vacinação',
    'Exames de Sangue',
    'Castração',
    'Limpeza de Tártaro',
    'Cirurgia Geral',
    'Banho e Tosa'
  ];

  //LISTA DE PETS (Simulada - futuramente virá do MyPetsController)
  final List<String> listaPets = ['Rex'];

  // --- MÉTODOS DE ATUALIZAÇÃO ---

  void setData(DateTime data) {
    dataSelecionada = data;
    notifyListeners(); //Notifica a View para atualizar o resumo
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
    //VALIDA O CAMPOS
    if (formKey.currentState!.validate()) {
      
      //VALIDA AS SELEÇÕES NÃO NULAS
      if (petSelecionado == null || servicoSelecionado == null || horarioSelecionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, preencha todos os campos da consulta!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      //POP-UP FEEDBACK DE SUCESSO
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
                Navigator.pop(context); //FECHA POP-UP
                Navigator.pushNamed(context, 'home'); //NAVEGAÇÃO
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


