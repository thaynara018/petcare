import 'package:flutter/material.dart';

class Pet {
  String nome, especie, raca, idade;
  Pet({required this.nome, required this.especie, required this.raca, required this.idade});
}

class MyPetsController extends ChangeNotifier {
  // Inicializando a lista com os exemplos 
  final List<Pet> meusPets = [
    Pet(nome: 'Rex', especie: 'Cachorro', raca: 'Golden Retriever', idade: '5'),
  ];
  
  final formKey = GlobalKey<FormState>();

  final nomeCtrl = TextEditingController();
  final especieCtrl = TextEditingController();
  final racaCtrl = TextEditingController();
  final idadeCtrl = TextEditingController();

  void salvarPet(BuildContext context, int? index) {
    if (formKey.currentState!.validate()) {
      final novoPet = Pet(
        nome: nomeCtrl.text,
        especie: especieCtrl.text,
        raca: racaCtrl.text,
        idade: idadeCtrl.text,
      );

      if (index == null) {
        meusPets.add(novoPet);
      } else {
        meusPets[index] = novoPet;
      }
      
      notifyListeners();
      Navigator.pop(context);
    }
  }

  void excluirPet(int index) {
    meusPets.removeAt(index);
    notifyListeners();
  }

  void voltarParaHome(BuildContext context) {
    Navigator.pushNamed(context, 'home');
  }

  void irParaHistorico(BuildContext context) {
  // NAVEGAÇÃO: Direciona para a tela de histórico clínico
  Navigator.pushNamed(context, 'historico');
  }
}


/*import 'package:flutter/material.dart';

class Pet {
  String nome, especie, raca, idade;
  Pet({required this.nome, required this.especie, required this.raca, required this.idade});
}

class MyPetsController extends ChangeNotifier {
  final List<Pet> meusPets = [];
  final formKey = GlobalKey<FormState>();

  final nomeCtrl = TextEditingController();
  final especieCtrl = TextEditingController();
  final racaCtrl = TextEditingController();
  final idadeCtrl = TextEditingController();

  // NAVEGAÇÃO: Volta explicitamente para a Home
  void voltarParaHome(BuildContext context) {
    Navigator.pushNamed(context, 'home');
  }

  void salvarPet(BuildContext context, int? index) {
    // Dispara a validação dos campos (borda vermelha)
    if (formKey.currentState!.validate()) {
      final novoPet = Pet(
        nome: nomeCtrl.text,
        especie: especieCtrl.text,
        raca: racaCtrl.text,
        idade: idadeCtrl.text,
      );

      if (index == null) {
        meusPets.add(novoPet);
      } else {
        meusPets[index] = novoPet;
      }
      
      notifyListeners();
      Navigator.pop(context);
    }
  }

  void excluirPet(int index) {
    meusPets.removeAt(index);
    notifyListeners();
  }
}*/

