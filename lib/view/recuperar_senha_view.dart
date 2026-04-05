
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/recuperar_senha_controller.dart';

class RecuperarSenhaView extends StatefulWidget {
  const RecuperarSenhaView({super.key});

  @override
  State<RecuperarSenhaView> createState() => _RecuperarSenhaViewState();
}

class _RecuperarSenhaViewState extends State<RecuperarSenhaView> {
  // Localizando o Controller via GetIt
  final controller = GetIt.I.get<RecuperarSenhaController>();
  
  final txtEmailRecuperacao = TextEditingController();
  static const Color primaryTeal = Color(0xFF26C1A1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryTeal, // AppBar Verde
        elevation: 0,
        leading: BackButton(
          color: Colors.white, // Ícone Branco
          onPressed: () => controller.irParaInicio(context), // Navegação Início
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: controller.formKey, // Chave para validação
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/logo_verde.png',
                    height: 80, width: 80, fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Recuperar Senha',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Esqueceu sua chave de acesso?',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 40),

                // CAMPO E-MAIL (TextFormField)
                _buildFieldLabel('E-mail cadastrado'),
                _buildTextFormField(
                  controller: txtEmailRecuperacao,
                  hint: 'seu@email.com',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe seu e-mail';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Insira um e-mail válido';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confira as instruções no e-mail.',
                    style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.4),
                  ),
                ),
                const SizedBox(height: 35),

                // BOTÃO: Recuperar Senha
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryTeal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => controller.solicitarRecuperacao(context),
                    child: const Text('Recuperar Senha', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(height: 25),

                // NAVEGAÇÃO: Voltar para o login
                GestureDetector(
                  onTap: () => controller.irParaLogin(context),
                  child: const Text(
                    'Voltar para o login',
                    style: TextStyle(color: primaryTeal, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF374151))),
      ),
    );
  }

  // HELPER FORM FIELD: Configurado com as bordas de erro
  Widget _buildTextFormField({
    required TextEditingController controller, 
    required String hint,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        
        // BORDA PADRÃO (Sem erro)
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),

        errorStyle: const TextStyle(color: Colors.redAccent),
      ),
    );
  }
}
