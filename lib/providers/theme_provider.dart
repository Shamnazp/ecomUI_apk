import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _prefKey = 'isDarkMode';
  bool _isDark = false;

  bool get isDark => _isDark;
  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider() {
    _loadFromPrefs();
  }

  /// Flip the current theme, persist and notify listeners immediately.
  void toggleTheme() {
    _isDark = !_isDark;
    _saveToPrefs(); // fire-and-forget persistence
    notifyListeners();
  }

  /// Explicit setter useful for Switch.onChanged: waits for save then notifies.
  Future<void> setDark(bool value) async {
    _isDark = value;
    await _saveToPrefs();
    notifyListeners();
  }

  /// Load the saved preference (if any) and update the provider state.
  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDark = prefs.getBool(_prefKey) ?? false;
    } catch (e) {
      _isDark = false; // fallback to light on error
    }
    notifyListeners();
  }

  /// Save the current _isDark value to SharedPreferences.
  Future<void> _saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefKey, _isDark);
    } catch (e) {
      // ignore/save/log if needed - do not crash the app
    }
  }
}
