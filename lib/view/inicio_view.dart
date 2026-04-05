import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// Import do seu controller aqui
import '../controller/inicio_controller.dart';

class InicioView extends StatefulWidget {
  const InicioView({super.key});

  @override
  State<InicioView> createState() => _InicioViewState();
}

class _InicioViewState extends State<InicioView> {
  // PONTO DE GET IT: Localizando o controller registrado globalmente
  final controller = GetIt.I.get<InicioController>();

  static const Color primaryTeal = Color(0xFF26C1A1);

  final List<Map<String, dynamic>> funcionalidades = [
    {'nome': 'Agendamento', 'icon': Icons.calendar_today},
    {'nome': 'Histórico', 'icon': Icons.assignment},
    {'nome': 'Chat Direto', 'icon': Icons.chat_bubble_outline},
    {'nome': 'Lembretes', 'icon': Icons.notifications_active_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: primaryTeal,
        elevation: 0,
        centerTitle: false,
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/logo_branca.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: const Text(
          'PetCare',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        // BOTÃO INFORMAÇÕES: Navegação para tela Sobre
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () => controller.navegarParaSobre(context),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth > 600 ? 50 : 25,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeroHeader(screenWidth),
                  const SizedBox(height: 50),
                  // CAMPO SERVIÇOS: Título da seção de utilitários
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Serviços',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildResponsiveGrid(screenWidth),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TITULOS E CABEÇALHO HERO
  Widget _buildHeroHeader(double width) {
    double titleSize = width > 600 ? 48 : 34;

    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.2,
            ),
            children: const [
              TextSpan(text: 'Cuidado Veterinário\n'),
              TextSpan(text: 'Completo e Digital\n', style: TextStyle(color: primaryTeal)),
              TextSpan(
                text: 'Gerencie a saúde dos seus pets\n em um só lugar',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        // BOTÕES DE AÇÃO PRINCIPAL
        Wrap(
          spacing: 15,
          runSpacing: 15,
          alignment: WrapAlignment.center,
          children: [
            // BOTÃO CRIAR CONTA: Direciona para Cadastro
            _buildActionIcon('Criar conta', primaryTeal, Colors.white, true, 
                () => controller.navegarParaCadastro(context)),
            // BOTÃO ENTRAR: Direciona para Login
            _buildActionIcon('Entrar', Colors.white, primaryTeal, false, 
                () => controller.navegarParaLogin(context)),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIcon(String label, Color bg, Color text, bool isFull, VoidCallback acao) {
    return SizedBox(
      width: 180,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: text,
          elevation: isFull ? 4 : 0,
          side: isFull ? BorderSide.none : const BorderSide(color: primaryTeal, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: acao,
        child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // GRID DE SERVIÇOS: Itens interativos que levam ao login
  Widget _buildResponsiveGrid(double width) {
    int crossAxisCount = 2;
    if (width > 500) crossAxisCount = 3;
    if (width > 750) crossAxisCount = 4;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: funcionalidades.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final item = funcionalidades[index];
        return InkWell(
          // NAVEGAÇÃO DOS SERVIÇOS: Todos exigem login nesta fase
          onTap: () => controller.navegarParaLogin(context),
          borderRadius: BorderRadius.circular(12),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item['icon'], color: primaryTeal, size: 25),
                  const SizedBox(height: 10),
                  Text(
                    item['nome'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
