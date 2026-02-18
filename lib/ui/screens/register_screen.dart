import 'package:flutter/material.dart';
import '../../data/auth_repository.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onRegistered;

  const RegisterScreen({super.key, required this.onRegistered});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _authRepository = AuthRepository();

  String? _error;

  @override
  void dispose() {
    _loginCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final login = _loginCtrl.text.trim();
    final password = _passwordCtrl.text;

    final ok = await _authRepository.register(login, password);
    if (!ok) {
      setState(() {
        _error = 'Пользователь с таким логином уже существует.';
      });
      return;
    }

    setState(() {
      _error = null;
    });

    widget.onRegistered();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _loginCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Логин'),
                        validator: (v) =>
                            (v == null || v.trim().isEmpty)
                                ? 'Введите логин'
                                : null,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Пароль'),
                        obscureText: true,
                        validator: (v) =>
                            (v == null || v.isEmpty || v.length < 4)
                                ? 'Минимум 4 символа'
                                : null,
                      ),
                      const SizedBox(height: 16),
                      if (_error != null) ...[
                        Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 8),
                      ],
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _register,
                          child: const Text('Зарегистрироваться'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}