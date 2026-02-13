import 'package:flutter/material.dart';
import '../data/auth_storage.dart';
import '../../library_index/presentation/library_index_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) return;

    final login = _loginController.text.trim();
    final password = _passwordController.text;

    final ok = await AuthStorage.login(login, password);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Неверный логин или пароль')),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LibraryIndexPage(),
      ),
    );
  }

  void _openRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF20120B),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Вход',
                  style: TextStyle(
                    color: Color(0xFFF4E1B2),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildField(
                  label: 'Логин',
                  controller: _loginController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Введите логин';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                _buildField(
                  label: 'Пароль',
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите пароль';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF2C94C),
                      foregroundColor: const Color(0xFF3A2415),
                    ),
                    child: const Text('Войти'),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _openRegister,
                  child: const Text(
                    'Нет аккаунта? Зарегистрироваться',
                    style: TextStyle(color: Color(0xFFD5B27A)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFD5B27A),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          style: const TextStyle(color: Color(0xFFF4E1B2)),
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xFF2B1810),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}