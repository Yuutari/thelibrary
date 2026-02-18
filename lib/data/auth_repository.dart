import 'package:shared_preferences/shared_preferences.dart';
import '../utils/password_hasher.dart';

class AuthRepository {
  static const keyLogin = 'user_login';
  static const keyPasswordHash = 'user_password_hash';

  Future<bool> register(String login, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final existingLogin = prefs.getString(keyLogin);

    if (existingLogin != null && existingLogin == login) {
      return false;
    }

    final hash = hashPassword(password);
    await prefs.setString(keyLogin, login);
    await prefs.setString(keyPasswordHash, hash);
    return true;
  }

  Future<bool> login(String login, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedLogin = prefs.getString(keyLogin);
    final savedHash = prefs.getString(keyPasswordHash);

    if (savedLogin == null || savedHash == null) {
      return false;
    }
    if (savedLogin != login) {
      return false;
    }

    final hash = hashPassword(password);
    return hash == savedHash;
  }
}