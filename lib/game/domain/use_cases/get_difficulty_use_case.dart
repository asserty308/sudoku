import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/game/data/repositories/sudoku_repo.dart';

class GetDifficultyUseCase {
  GetDifficultyUseCase({required this.sudokuRepo});

  final SudokuRepo sudokuRepo;

  Difficulty execute() => sudokuRepo.getDifficulty();
}
