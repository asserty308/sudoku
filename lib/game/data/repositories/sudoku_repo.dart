import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/app/data/repositories/app_prefs.dart';

class SudokuRepo {
  SudokuRepo({required this.sharedPrefs});

  final SharedPreferencesAsync sharedPrefs;
  
  Future<void> setDifficulty(Difficulty difficulty) => sharedPrefs.setDifficulty(difficulty);

  Future<Difficulty> getDifficulty() => sharedPrefs.difficulty;
}
