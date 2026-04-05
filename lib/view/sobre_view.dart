import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/sobre_controller.dart';

class SobreView extends StatelessWidget {
  SobreView({super.key});

  // Localizando o Controller via GetIt
  final controller = GetIt.I.get<SobreController>();

  static const Color primaryTeal = Color(0xFF26C1A1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // APP BAR: Seguindo o padrão verde com ícone branco
      appBar: AppBar(
        backgroundColor: primaryTeal,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => controller.voltarParaInicio(context),
        ),
        title: const Text(
          'Sobre o PetCare',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // LOGO DA CLÍNICA
            _buildSectionLogo(),
            const SizedBox(height: 30),

            // NOSSA HISTÓRIA
            _buildSectionTitle('Nossa História'),
            const SizedBox(height: 10),
            const Text(
              'O PetCare nasceu no coração de uma sala de aula de Análise e Desenvolvimento de Sistemas. '
              'Observando a dificuldade de amigos e familiares em organizar as vacinas, consultas e o histórico '
              'clínico de seus animais de estimação, Pedro e Thaynara decidiram unir tecnologia e amor aos animais.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              'O projeto, que começou como um desafio acadêmico, evoluiu para uma plataforma completa que visa '
              'estreitar o laço entre tutores e clínicas veterinárias, garantindo que nenhum cuidado seja esquecido.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
            ),

            const SizedBox(height: 40),

            // OBJETIVO
            _buildSectionTitle('Objetivo'),
            const SizedBox(height: 10),
            const Text(
              'Nossa missão é digitalizar o cuidado animal, oferecendo uma interface intuitiva onde a saúde do pet '
              'está a apenas um clique de distância. Queremos proporcionar paz de espírito para os tutores e eficiência para os veterinários.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54, fontStyle: FontStyle.italic),
            ),

            const SizedBox(height: 50),

            // DESENVOLVEDORES
            _buildSectionTitle('Desenvolvedores'),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDevAvatar('Pedro A. Villela', 'assets/pedro.png'), // Campo para foto do Pedro
                _buildDevAvatar('Thaynara F. Coelho', 'assets/thaynara.png'), // Campo para foto da Thaynara
              ],
            ),
            const SizedBox(height: 40),
            
            const Text(
              'Versão 1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // Widget: Logo estilizada
  Widget _buildSectionLogo() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: primaryTeal.withOpacity(0.1),
          padding: const EdgeInsets.all(20),
          child: const Icon(Icons.pets, color: primaryTeal, size: 60),
        ),
      ),
    );
  }

  // Widget: Título de Seção
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: primaryTeal,
      ),
    );
  }

  // Widget: Avatar dos Desenvolvedores
  Widget _buildDevAvatar(String nome, String path) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
            border: Border.all(color: primaryTeal, width: 2),
          ),
          child: ClipOval(
            child: Image.asset(
              path,
              fit: BoxFit.cover,
              // Caso a imagem não exista, mostra um ícone padrão
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.person,
                size: 50,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          nome,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Text(
          'Desenvolvedor ADS',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}