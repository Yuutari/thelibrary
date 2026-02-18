import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const SettingsScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Настройки',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: onLogout,
          icon: const Icon(Icons.logout),
          label: const Text('Выйти из аккаунта'),
        ),
        const SizedBox(height: 16),
        const Text(
          'Регистрация и вход работают локально с использованием SharedPreferences '
          'и хэшированием пароля через SHA‑256.',
        ),
      ],
    );
  }
}