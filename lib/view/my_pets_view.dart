import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Modelo de dados para o Pet
class Pet {
  String nome;
  String especie;
  String raca;
  String idade;

  Pet({
    required this.nome, 
    required this.especie, 
    required this.raca, 
    required this.idade
  });
}

class MyPetsView extends StatefulWidget {
  const MyPetsView({super.key});

  @override
  State<MyPetsView> createState() => _MyPetsViewState();
}

class _MyPetsViewState extends State<MyPetsView> {
  // Definição de cores padrão do projeto PetCare
  static const Color primaryTeal = Color(0xFF26C1A1);
  
  // Lista de pets (inicia vazia para simular estado real)
  final List<Pet> _meusPets = [];

  // Controllers para os campos do formulário
  final _nomeCtrl = TextEditingController();
  final _especieCtrl = TextEditingController();
  final _racaCtrl = TextEditingController();
  final _idadeCtrl = TextEditingController();

  // --- LÓGICA DE NEGÓCIO (CRUD) ---

  void _abrirFormulario({int? index}) {
    // Se index não for nulo, carrega os dados para edição
    if (index != null) {
      final pet = _meusPets[index];
      _nomeCtrl.text = pet.nome;
      _especieCtrl.text = pet.especie;
      _racaCtrl.text = pet.raca;
      _idadeCtrl.text = pet.idade;
    } else {
      // Caso contrário, limpa os campos para novo cadastro
      _nomeCtrl.clear();
      _especieCtrl.clear();
      _racaCtrl.clear();
      _idadeCtrl.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(index == null ? 'Novo Pet' : 'Editar Pet'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPopupField(_nomeCtrl, 'Nome'),
              _buildPopupField(_especieCtrl, 'Espécie'),
              _buildPopupField(_racaCtrl, 'Raça'),
              // Campo idade restrito a números
              _buildPopupField(_idadeCtrl, 'Idade', isNumeric: true),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => _salvarDados(index),
            child: const Text('Salvar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _salvarDados(int? index) {
    if (_nomeCtrl.text.isNotEmpty) {
      setState(() {
        final petData = Pet(
          nome: _nomeCtrl.text,
          especie: _especieCtrl.text,
          raca: _racaCtrl.text,
          idade: _idadeCtrl.text,
        );

        if (index == null) {
          _meusPets.add(petData);
        } else {
          _meusPets[index] = petData;
        }
      });
      Navigator.pop(context);
    }
  }

  void _confirmarExclusao(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Pet'),
        content: Text('Tem certeza que deseja remover ${_meusPets[index].nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _meusPets.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  // --- INTERFACE (UI) ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        leading: const BackButton(color: Colors.black87),
        title: const Text(
          'Meus Pets',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => _abrirFormulario(),
            icon: const Icon(Icons.add_circle, color: primaryTeal, size: 28),
          ),
        ],
      ),
      body: _meusPets.isEmpty 
          ? _buildEmptyState() 
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _meusPets.length,
              itemBuilder: (context, index) => _buildPetCard(index),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pets_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text(
            'Nenhum pet cadastrado',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          TextButton(
            onPressed: () => _abrirFormulario(),
            child: const Text('Cadastrar agora', style: TextStyle(color: primaryTeal)),
          ),
        ],
      ),
    );
  }

  Widget _buildPetCard(int index) {
    final pet = _meusPets[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          // Header visual do card
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: primaryTeal,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const Icon(Icons.pets, size: 45, color: Colors.white70),
          ),
          // Área de informações e ações
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pet.nome, 
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: Colors.grey, size: 22),
                          onPressed: () => _abrirFormulario(index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 22),
                          onPressed: () => _confirmarExclusao(index),
                        ),
                      ],
                    ),
                  ],
                ),
                Text('${pet.especie} • ${pet.raca}', style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 12),
                Text('Idade: ${pet.idade} anos', style: const TextStyle(fontWeight: FontWeight.w600)),
                const Divider(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: const Text('Ver Histórico Clínico', style: TextStyle(color: Colors.black87)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Componente de campo de entrada para o pop-up
  Widget _buildPopupField(TextEditingController ctrl, String label, {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumeric 
            ? [FilteringTextInputFormatter.digitsOnly] 
            : [],
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }
}



/*import 'package:flutter/material.dart';

// Modelo de Dados (Entidade)
class Pet {
  final String nome;
  final String especie;
  final String raca;
  final String idade;

  Pet({
    required this.nome, 
    required this.especie, 
    required this.raca, 
    required this.idade
  });
}

class MeusPetsView extends StatefulWidget {
  const MeusPetsView({super.key});

  @override
  State<MeusPetsView> createState() => _MeusPetsViewState();
}

class _MeusPetsViewState extends State<MeusPetsView> {
  static const Color primaryTeal = Color(0xFF26C1A1);

  // A lista agora inicia vazia para simular um novo usuário
  final List<Pet> _meusPets = [];

  // Controllers para o Pop-up
  final _nomeCtrl = TextEditingController();
  final _especieCtrl = TextEditingController();
  final _racaCtrl = TextEditingController();
  final _idadeCtrl = TextEditingController();

  void _abrirPopupCadastro() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('Novo Pet', style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInput(controller: _nomeCtrl, label: 'Nome'),
                _buildInput(controller: _especieCtrl, label: 'Espécie'),
                _buildInput(controller: _racaCtrl, label: 'Raça'),
                _buildInput(controller: _idadeCtrl, label: 'Idade'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryTeal),
              onPressed: _salvarPet,
              child: const Text('Salvar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _salvarPet() {
    if (_nomeCtrl.text.isNotEmpty && _especieCtrl.text.isNotEmpty) {
      setState(() {
        _meusPets.add(Pet(
          nome: _nomeCtrl.text,
          especie: _especieCtrl.text,
          raca: _racaCtrl.text,
          idade: _idadeCtrl.text,
        ));
      });
      // Limpar campos após salvar
      _nomeCtrl.clear();
      _especieCtrl.clear();
      _racaCtrl.clear();
      _idadeCtrl.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('Meus Pets', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: _abrirPopupCadastro,
            icon: const Icon(Icons.add_circle, color: primaryTeal, size: 30),
          ),
        ],
      ),
      body: _meusPets.isEmpty 
        ? _buildEmptyState() 
        : ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: _meusPets.length,
            itemBuilder: (context, index) => _buildPetCard(_meusPets[index]),
          ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pets, size: 100, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          const Text(
            'Você ainda não cadastrou nenhum pet.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: _abrirPopupCadastro,
            child: const Text('Cadastrar agora', style: TextStyle(color: primaryTeal, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildPetCard(Pet pet) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: primaryTeal,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: const Icon(Icons.pets, size: 50, color: Colors.white70),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pet.nome, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text('${pet.especie} • ${pet.raca}', style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 10),
                Text('Idade: ${pet.idade}', style: const TextStyle(fontWeight: FontWeight.w500)),
                const Divider(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Ver Histórico Clínico', style: TextStyle(color: Colors.black87)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput({required TextEditingController controller, required String label}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}*/