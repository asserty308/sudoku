import 'package:sudoku/data/models/difficulty.dart';
import 'package:sudoku/data/services/app_session.dart';
import 'package:sudoku/data/datasources/shared_prefs.dart';

final sudokuRepo = SudokuRepo();

class SudokuRepo {
  Future<void> setDifficulty(Difficulty difficulty) async {
    await sharedPrefs.setDifficulty(difficulty);
  }

  Difficulty getDifficulty() {
    return sharedPrefs.difficulty;
  }
}