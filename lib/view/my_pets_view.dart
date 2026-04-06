import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:app_clinica_veterinaria/components/app_drawer.dart'; // IMPORTANTE: Importe seu menu lateral reutilizável
import '../controller/my_pets_controller.dart';

class MyPetsView extends StatelessWidget {
  MyPetsView({super.key});

  final controller = GetIt.I.get<MyPetsController>();
  static const Color primaryTeal = Color(0xFF26C1A1);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF3F4F6),
          
          // MENU À DIREITA: Usa endDrawer para o ícone de 3 traços aparecer à direita
          endDrawer: const AppDrawer(), 
          
          appBar: AppBar(
            backgroundColor: primaryTeal,
            elevation: 0,
            // CORREÇÃO: Torna o ícone do menu (hambúrguer) branco
            iconTheme: const IconThemeData(color: Colors.white),
            
            // NAVEGAÇÃO: Botão voltar para Home no canto esquerdo
            leading: BackButton(
              color: Colors.white,
              onPressed: () => controller.voltarParaHome(context),
            ),
            
            title: const Text(
              'Meus Pets',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          
          body: controller.meusPets.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: controller.meusPets.length,
                  itemBuilder: (context, index) => _buildPetCard(context, index),
                ),

          // BOTÃO ADICIONAR: Posicionado no canto inferior direito
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryTeal,
            onPressed: () => _exibirFormulario(context),
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        );
      },
    );
  }

  // --- HELPERS DE INTERFACE ---

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pets_outlined, size: 80, color: Colors.grey.shade200),
          const SizedBox(height: 16),
          const Text('Nenhum pet cadastrado', style: TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildPetCard(BuildContext context, int index) {
    final pet = controller.meusPets[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Container(
            height: 100, width: double.infinity,
            decoration: const BoxDecoration(
              color: primaryTeal,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const Icon(Icons.pets, size: 40, color: Colors.white54),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(pet.nome, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        IconButton(icon: const Icon(Icons.edit_outlined, color: Colors.grey), onPressed: () => _exibirFormulario(context, index: index)),
                        IconButton(icon: const Icon(Icons.delete_outline, color: Colors.redAccent), onPressed: () => _confirmarExclusao(context, index)),
                      ],
                    ),
                  ],
                ),
                Text('${pet.especie} • ${pet.raca}', style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                Text('Idade: ${pet.idade} anos', style: const TextStyle(fontWeight: FontWeight.w600)),
                const Divider(height: 30),
                /*SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {}, // Futura navegação para histórico
                    child: const Text('Ver Histórico Clínico', style: TextStyle(color: Colors.black87)),
                  */// ... dentro do método _buildPetCard

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    // AÇÃO DE NAVEGAÇÃO ADICIONADA:
                    onPressed: () => controller.irParaHistorico(context), 
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: const Text(
                      'Ver Histórico Clínico', 
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                )
                //  ),
                //)
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- FORMULÁRIO COM VALIDAÇÃO ---

  void _exibirFormulario(BuildContext context, {int? index}) {
    if (index != null) {
      final pet = controller.meusPets[index];
      controller.nomeCtrl.text = pet.nome;
      controller.especieCtrl.text = pet.especie;
      controller.racaCtrl.text = pet.raca;
      controller.idadeCtrl.text = pet.idade;
    } else {
      controller.nomeCtrl.clear(); controller.especieCtrl.clear();
      controller.racaCtrl.clear(); controller.idadeCtrl.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(index == null ? 'Novo Pet' : 'Editar Pet'),
        content: SingleChildScrollView(
          child: Form(
            key: controller.formKey, // VINCULA A CHAVE PARA BORDAS VERMELHAS
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // CAMPO DE IMAGEM: Placeholder solicitado
                GestureDetector(
                  onTap: () {}, // Futura implementação de picker de imagem
                  child: Container(
                    height: 80, width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100, 
                      borderRadius: BorderRadius.circular(15), 
                      border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, color: Colors.grey),
                        Text('Foto', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildFormField(controller.nomeCtrl, 'Nome do Pet'),
                _buildFormField(controller.especieCtrl, 'Espécie'),
                _buildFormField(controller.racaCtrl, 'Raça'),
                _buildFormField(controller.idadeCtrl, 'Idade', isNumeric: true),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryTeal),
            onPressed: () => controller.salvarPet(context, index),
            child: const Text('Salvar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // WIDGET AUXILIAR: Implementa a validação e o estilo de erro (Bordas Vermelhas)
  Widget _buildFormField(TextEditingController ctrl, String label, {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: ctrl,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumeric ? [FilteringTextInputFormatter.digitsOnly] : [],
        // VALIDAÇÃO: Impede salvar campos vazios
        validator: (value) => (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          filled: true,
          fillColor: const Color(0xFFF9FAFB),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          
          // ESTILO DE ERRO
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.redAccent, width: 1)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.redAccent, width: 2)),
          errorStyle: const TextStyle(color: Colors.redAccent),
        ),
      ),
    );
  }

  void _confirmarExclusao(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Pet'),
        content: const Text('Deseja remover este pet?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Não')),
          TextButton(onPressed: () { controller.excluirPet(index); Navigator.pop(context); }, child: const Text('Sim, excluir', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}

