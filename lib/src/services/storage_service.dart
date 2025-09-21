import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _userNameKey = 'USER_NAME';

  // Menyimpan nama pengguna
  Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name);
  }

  // Mengambil nama pengguna
  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }
}
