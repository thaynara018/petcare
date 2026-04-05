import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Necessário para FilteringTextInputFormatter
import 'package:get_it/get_it.dart';
import '../controller/cadastro_controller.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  // Localizando o Controller via GetIt
  final controller = GetIt.I.get<CadastroController>();

  final txtNome = TextEditingController();
  final txtEmail = TextEditingController();
  final txtTelefone = TextEditingController();
  final txtSenha = TextEditingController();
  final txtConfirmarSenha = TextEditingController();

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
          onPressed: () => controller.voltarParaInicio(context), // Navegação: Voltar para Início
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: controller.formKey, // Vinculando a chave de validação
            child: Column(
              children: [
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/logo_verde.png',
                    height: 80, width: 80, fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Criar Conta',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
                ),
                const Text('Junte-se ao PetCare', style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 35),

                // CAMPO NOME
                _buildFieldLabel('Nome Completo'),
                _buildTextFormField(
                  controller: txtNome, 
                  hint: 'Seu nome',
                  validator: (v) => v!.isEmpty ? 'Informe seu nome' : null,
                ),
                const SizedBox(height: 15),

                // CAMPO E-MAIL (Com validação de formato)
                _buildFieldLabel('E-mail'),
                _buildTextFormField(
                  controller: txtEmail, 
                  hint: 'seu@email.com',
                  validator: (v) {
                    if (v!.isEmpty) return 'Informe seu e-mail';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // CAMPO TELEFONE (Apenas números)
                _buildFieldLabel('Telefone'),
                _buildTextFormField(
                  controller: txtTelefone, 
                  hint: '(11) 99999-9999',
                  isNumeric: true,
                  validator: (v) => v!.isEmpty ? 'Informe seu telefone' : null,
                ),
                const SizedBox(height: 15),

                // CAMPO SENHA
                _buildFieldLabel('Senha'),
                _buildTextFormField(
                  controller: txtSenha, 
                  hint: '********', 
                  isPassword: true,
                  validator: (v) => v!.isEmpty ? 'Crie uma senha' : null,
                ),
                const SizedBox(height: 15),

                // CAMPO CONFIRMAR SENHA
                _buildFieldLabel('Confirmar Senha'),
                _buildTextFormField(
                  controller: txtConfirmarSenha, 
                  hint: '********', 
                  isPassword: true,
                  validator: (v) => v!.isEmpty ? 'Confirme sua senha' : null,
                ),

                const SizedBox(height: 30),

                // BOTÃO: CRIAR CONTA (Navegação Home via Controller)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryTeal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => controller.realizarCadastro(
                      context, txtSenha.text, txtConfirmarSenha.text
                    ),
                    child: const Text('Criar Conta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(height: 25),

                // RODAPÉ: JÁ TEM CONTA (Navegação Login via Controller)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Já tem uma conta? ', style: TextStyle(color: Colors.black54)),
                    GestureDetector(
                      onTap: () => controller.irParaLogin(context),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(color: primaryTeal, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper: Etiquetas
  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF374151))),
      ),
    );
  }

  // Helper: Campos de Texto Otimizados
  Widget _buildTextFormField({
    required TextEditingController controller, 
    required String hint, 
    required String? Function(String?) validator,
    bool isPassword = false,
    bool isNumeric = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumeric ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
        hintText: hint,
        // AJUSTE: Cor do exemplo definida como cinza
        hintStyle: const TextStyle(color: Colors.grey), 
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        
        // Bordas quando não há erro
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), 
          borderSide: BorderSide.none,
        ),

        // PADRÃO DE ERRO: Borda vermelha quando a validação falha
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
