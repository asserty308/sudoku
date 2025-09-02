import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/game/data/repositories/sudoku_repo.dart';

class SetDifficultyUseCase {
  SetDifficultyUseCase({required this.sudokuRepo});

  final SudokuRepo sudokuRepo;

  Future<void> execute(Difficulty difficulty) =>
      sudokuRepo.setDifficulty(difficulty);
}
