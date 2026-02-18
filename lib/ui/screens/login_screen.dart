import 'package:flutter/material.dart';
import '../../data/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  final VoidCallback onNeedRegister;

  const LoginScreen({
    super.key,
    required this.onLoginSuccess,
    required this.onNeedRegister,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final login = _loginCtrl.text.trim();
    final password = _passwordCtrl.text;

    final ok = await _authRepository.login(login, password);
    if (!ok) {
      setState(() {
        _error = 'Неверный логин или пароль.';
      });
      return;
    }

    setState(() {
      _error = null;
    });

    widget.onLoginSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вход')),
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
                            (v == null || v.isEmpty)
                                ? 'Введите пароль'
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
                          onPressed: _login,
                          child: const Text('Войти'),
                        ),
                      ),
                      TextButton(
                        onPressed: widget.onNeedRegister,
                        child: const Text('Зарегистрироваться'),
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