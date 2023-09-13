import 'package:flutter/material.dart';
import 'package:sudoku/app/config/keys.dart';
import 'package:sudoku/app/services/app_session.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  ThemeMode get themeMode {
    // 0 = system, 1 = light, 2 = dark
    final int mode = sharedPrefs.getInt(kPreferredTheme) ?? 0;

    switch (mode) {
      case 1: return ThemeMode.light;
      case 2: return ThemeMode.dark;
      default: return ThemeMode.system;
    }
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    switch (theme) {
      case ThemeMode.system:
        sharedPrefs.setInt(kPreferredTheme, 0);
        break;
      case ThemeMode.light:
        sharedPrefs.setInt(kPreferredTheme, 1);
        break;
      case ThemeMode.dark:
        sharedPrefs.setInt(kPreferredTheme, 2);
        break;
    }
  }
}
