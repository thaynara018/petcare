import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app_clinica_veterinaria/controller/sobre_controller.dart';

class SobreView extends StatelessWidget {
  SobreView({super.key});

  final controller = GetIt.I.get<SobreController>();
  static const Color primaryTeal = Color(0xFF26C1A1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryTeal,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
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
            // LOGO DA CLÍNICA (Atualizado para usar a imagem)
            _buildSectionLogo(),
            const SizedBox(height: 30),

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
              'estreitar o lço entre tutores e clínicas veterinárias, garantindo que nenhum cuidado seja esquecido.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
            ),

            const SizedBox(height: 40),

            _buildSectionTitle('Objetivo'),
            const SizedBox(height: 10),
            const Text(
              'Nossa missão é digitalizar o cuidado animal, oferecendo uma interface intuitiva onde a saúde do pet '
              'está a apenas um clique de distância. Queremos proporcionar paz de espírito para os tutores e eficiência para os veterinários.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54, fontStyle: FontStyle.italic),
            ),

            const SizedBox(height: 50),

            _buildSectionTitle('Desenvolvedores'),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDevAvatar('Pedro A. Villela', 'assets/pedro.png'),
                _buildDevAvatar('Thaynara F. Coelho', 'assets/thaynara.png'),
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

  // --- WIDGET ATUALIZADO ---
  Widget _buildSectionLogo() {
    return Center(
      // 1. O ClipRRect é quem faz o corte das bordas
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35), // Quanto maior o número, mais redondo
        child: Image.asset(
          'assets/logo_verde.png',
          height: 140,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.pets, 
            color: primaryTeal, 
            size: 80
          ),
        ),
      ),
    );
  }

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

  Widget _buildDevAvatar(String nome, String path) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            shape: BoxShape.circle,
            border: Border.all(color: primaryTeal, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              path,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.person,
                size: 50,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
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