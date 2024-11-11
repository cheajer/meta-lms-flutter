import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeNotifier extends ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool _isDarkMode = false;

  ThemeNotifier() {
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode;

  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> _loadTheme() async {
    String? darkMode = await _storage.read(key: 'isDarkMode');
    _isDarkMode = darkMode == 'true';
    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    print(value);
    _isDarkMode = value;
    await _storage.write(key: 'isDarkMode', value: _isDarkMode.toString());
    notifyListeners();
  }
}
