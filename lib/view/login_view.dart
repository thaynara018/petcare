import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Instância do Controller via GetIt
  final controller = GetIt.I.get<LoginController>();

  final txtEmail = TextEditingController();
  final txtSenha = TextEditingController();

  static const Color primaryTeal = Color(0xFF26C1A1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar Verde com botão de voltar Branco
      appBar: AppBar(
        backgroundColor: primaryTeal,
        elevation: 0,
        leading: BackButton(
          color: Colors.white,
          // Ponto de Navegação: Voltar para tela de Início
          onPressed: () => controller.voltarParaInicio(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            // Vincula a chave do controller ao formulário
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo da Clínica
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/logo_verde.png',
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 15),
                
                // Títulos da Tela
                const Text(
                  'PetCare',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const Text(
                  'Entre na sua conta',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 40),

                // CAMPO E-MAIL: Com validação de formato e preenchimento
                _buildFieldLabel('E-mail'),
                const SizedBox(height: 8),
                _buildTextFormField(
                  controller: txtEmail,
                  hint: 'seu@email.com',
                  icon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu e-mail';
                    }
                    // Regex para validar formato de e-mail
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Insira um e-mail válido';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),

                // CAMPO SENHA: Com validação de preenchimento
                _buildFieldLabel('Senha'),
                const SizedBox(height: 8),
                _buildTextFormField(
                  controller: txtSenha,
                  hint: '********',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // BOTÃO ENTRAR: Dispara a lógica de validação e navegação para HOME
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryTeal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () => controller.realizarLogin(context),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Rodapé com links de navegação
                Column(
                  children: [
                    // NAVEGAÇÃO: Link para Recuperar Senha
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Esqueceu a senha? ', style: TextStyle(color: Colors.black54)),
                        GestureDetector(
                          onTap: () => controller.irParaRecuperarSenha(context),
                          child: const Text(
                            'Clique aqui',
                            style: TextStyle(
                              color: primaryTeal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // NAVEGAÇÃO: Link para Cadastro
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Não tem uma conta? ', style: TextStyle(color: Colors.black54)),
                        GestureDetector(
                          onTap: () => controller.irParaCadastro(context),
                          child: const Text(
                             'Cadastre-se',
                             style: TextStyle(
                               color: primaryTeal,
                               fontWeight: FontWeight.bold,
                              ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para as etiquetas (Labels)
  Widget _buildFieldLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color(0xFF374151),
        ),
      ),
    );
  }

  // Widget auxiliar otimizado para campos de formulário com validação
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator, // Função de validação
    IconData? icon,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator, // Aplica a regra de validação
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        // Estilo da borda quando houver erro de validação
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

