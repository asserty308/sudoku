import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/app/domain/setup.dart';
import 'package:sudoku/app/data/repositories/app_prefs.dart';

class SudokuRepo {
  Future<void> setDifficulty(Difficulty difficulty) async {
    await sharedPrefs.setDifficulty(difficulty);
  }

  Difficulty getDifficulty() {
    return sharedPrefs.difficulty;
  }
}
