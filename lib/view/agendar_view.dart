import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app_clinica_veterinaria/components/app_drawer.dart';
import '../controller/agendar_controller.dart';

class AgendarView extends StatelessWidget {
  AgendarView({super.key});

  // Localiza o controller via GetIt
  final controller = GetIt.I.get<AgendarController>();
  static const Color primaryTeal = Color(0xFF26C1A1);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF3F4F6),
          // MENU À DIREITA: endDrawer para manter o padrão das outras telas
          endDrawer: const AppDrawer(),
          appBar: AppBar(
            backgroundColor: primaryTeal,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            leading: BackButton(
              color: Colors.white,
              onPressed: () => controller.voltar(context),
            ),
            title: const Text(
              'Agendar Consultas',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  // CARD: SELEÇÃO DE DATA
                  _buildCard(
                    title: 'Selecione a Data',
                    icon: Icons.calendar_today,
                    child: CalendarDatePicker(
                      initialDate: controller.dataSelecionada,
                      firstDate: DateTime.now(),
                      lastDate: controller.dataLimite, // Limite de 4 meses
                      onDateChanged: (date) => controller.setData(date),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // CARD: DETALHES DA CONSULTA
                  _buildCard(
                    title: 'Detalhes da Consulta',
                    icon: Icons.edit_calendar,
                    child: Column(
                      children: [
                        _buildDropdown('Escolha um pet', controller.listaPets, controller.petSelecionado, controller.setPet),
                        _buildDropdown('Escolha o serviço', controller.listaServicos, controller.servicoSelecionado, controller.setServico),
                        _buildDropdown('Escolha o horário', controller.listaHorarios, controller.horarioSelecionado, controller.setHorario),
                        
                        const SizedBox(height: 10),
                        
                        // CAMPO OBSERVAÇÕES (OBRIGATÓRIO)
                        TextFormField(
                          controller: controller.obsCtrl,
                          maxLines: 3,
                          validator: (v) => (v == null || v.isEmpty) ? 'As observações são obrigatórias' : null,
                          decoration: InputDecoration(
                            hintText: 'Descreva os sintomas ou motivo da consulta...',
                            filled: true,
                            fillColor: const Color(0xFFF9FAFB),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.redAccent)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // CARD: RESUMO DO AGENDAMENTO
                  _buildSummaryCard(),

                  const SizedBox(height: 25),

                  // BOTÃO CONFIRMAR
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryTeal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => controller.confirmarAgendamento(context),
                      child: const Text(
                        'Confirmar Agendamento',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- AUXILIARES DE INTERFACE (WIDGETS REUTILIZÁVEIS) ---

  Widget _buildCard({required String title, required IconData icon, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryTeal, size: 20),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(height: 30),
          child,
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? value, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: items.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryTeal.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryTeal.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Resumo do Agendamento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 12),
          _rowSummary('Data', controller.dataFormatada),
          _rowSummary('Horário', controller.horarioSelecionado ?? 'Selecione acima'),
          _rowSummary('Pet', controller.petSelecionado ?? 'Selecione acima'),
          _rowSummary('Serviço', controller.servicoSelecionado ?? 'Selecione acima'),
        ],
      ),
    );
  }

  Widget _rowSummary(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          Text(value, style: const TextStyle(color: Colors.black54, fontSize: 13)),
        ],
      ),
    );
  }
}


