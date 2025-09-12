import 'package:sudoku/features/game/data/models/difficulty.dart';
import 'package:sudoku/features/game/data/repositories/sudoku_repo.dart';

class GetDifficultyUseCase {
  GetDifficultyUseCase({required this.sudokuRepo});

  final SudokuRepo sudokuRepo;

  Future<Difficulty> execute() => sudokuRepo.getDifficulty();
}
