import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/app/config/keys.dart';
import 'package:sudoku/game/data/models/difficulty.dart';

extension SharedPreferencesExt on SharedPreferences {
  Future<void> setDifficulty(Difficulty difficulty) => setString(kDifficultyKey, difficulty.name);

  Difficulty get difficulty {
    final cachedDifficulty = getString(kDifficultyKey) ?? '';
    return DifficultyExt.fromString(cachedDifficulty);
  }

  Future<void> setPreferredTheme(ThemeMode theme) => switch (theme) {
    ThemeMode.system => setInt(kPreferredThemeKey, 0),
    ThemeMode.light => setInt(kPreferredThemeKey, 1),
    ThemeMode.dark => setInt(kPreferredThemeKey, 2),
  };

  ThemeMode get preferredTheme => switch (getInt(kPreferredThemeKey)) {
    1 => ThemeMode.light,
    2 => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}