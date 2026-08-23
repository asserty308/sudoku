import 'package:sudoku/features/game/data/models/difficulty.dart';
import 'package:sudoku/features/game/data/repositories/sudoku_repo.dart';

class SetDifficultyUseCase({required final SudokuRepo sudokuRepo}) {
  Future<void> execute(Difficulty difficulty) =>
      sudokuRepo.setDifficulty(difficulty);
}
