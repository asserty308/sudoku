import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/app/services/app_session.dart';
import 'package:sudoku/app/services/shared_prefs.dart';

final sudokuRepo = SudokuRepo();

class SudokuRepo {
  Future<void> setDifficulty(Difficulty difficulty) async {
    await sharedPrefs.setDifficulty(difficulty);
  }

  Difficulty getDifficulty() {
    return sharedPrefs.difficulty;
  }
}