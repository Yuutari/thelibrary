import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/characters_repository.dart';
import 'data/open_library_service.dart';
import 'data/auth_repository.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/register_screen.dart';
import 'ui/screens/home_screen.dart';

void main() {
  runApp(const ProjectMoonApp());
}

class ProjectMoonApp extends StatefulWidget {
  const ProjectMoonApp({super.key});

  @override
  State<ProjectMoonApp> createState() => _ProjectMoonAppState();
}

class _ProjectMoonAppState extends State<ProjectMoonApp> {
  bool _isLoggedIn = false;
  bool _isLoading = true;
  bool _showRegister = false;

  final CharactersRepository _charactersRepository = CharactersRepository();
  final OpenLibraryService _openLibraryService = OpenLibraryService();
  final AuthRepository _authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final hasLogin = prefs.getString(AuthRepository.keyLogin) != null &&
        prefs.getString(AuthRepository.keyPasswordHash) != null;
    setState(() {
      _isLoggedIn = false;
      _isLoading = false;
      _showRegister = !hasLogin;
    });
  }

  void _onLoginSuccess() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  void _onNeedRegister() {
    setState(() {
      _showRegister = true;
    });
  }

  void _onRegistered() {
    setState(() {
      _showRegister = false;
    });
  }

  void _onLogout() {
    setState(() {
      _isLoggedIn = false;
      _showRegister = false;
    });
  }

  ThemeData _buildTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0B0A0D),
      primaryColor: const Color(0xFF2F5B4F),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF2F5B4F),
        secondary: Color(0xFFE4C07A),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF141217),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      cardColor: const Color(0xFF18151B),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        theme: _buildTheme(),
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    Widget home;
    if (_isLoggedIn) {
      home = HomeScreen(
        charactersRepository: _charactersRepository,
        openLibraryService: _openLibraryService,
        onLogout: _onLogout,
      );
    } else if (_showRegister) {
      home = RegisterScreen(onRegistered: _onRegistered);
    } else {
      home = LoginScreen(
        onLoginSuccess: _onLoginSuccess,
        onNeedRegister: _onNeedRegister,
      );
    }

    return MaterialApp(
      title: 'ProjectMoon Wiki',
      theme: _buildTheme(),
      home: home,
    );
  }
}