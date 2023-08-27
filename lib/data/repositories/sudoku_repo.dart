import 'package:sudoku/config/keys.dart';
import 'package:sudoku/data/models/difficulty.dart';
import 'package:sudoku/data/services/app_session.dart';

final sudokuRepo = SudokuRepo();

class SudokuRepo {
  Future<void> setDifficulty(Difficulty difficulty) async {
    await sharedPrefs.setString(kDifficulty, difficulty.name);
  }

  Difficulty getDifficulty() {
    final cachedDifficulty = sharedPrefs.getString(kDifficulty) ?? '';
    return DifficultyExt.fromString(cachedDifficulty);
  }
}