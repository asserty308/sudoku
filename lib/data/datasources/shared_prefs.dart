import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/config/keys.dart';
import 'package:sudoku/data/models/difficulty.dart';

extension SharedPreferencesExt on SharedPreferences {
  Difficulty get difficulty {
    final cachedDifficulty = getString(kDifficulty) ?? '';
    return DifficultyExt.fromString(cachedDifficulty);
  }
}