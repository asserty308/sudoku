import 'package:sudoku/data/models/difficulty.dart';
import 'package:sudoku/data/models/sudoku_model.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

Future<SudokuModel> getNewSudoku(Difficulty difficulty) async {
  var emptySquares = 2;

  switch (difficulty) {
    case Difficulty.test:
      emptySquares = 1;
      break;
    case Difficulty.beginner:
      emptySquares = 18;
      break;
    case Difficulty.easy:
      emptySquares = 27;
      break;
    case Difficulty.normal:
      emptySquares = 36;
      break;
    case Difficulty.advanced:
      emptySquares = 42;
      break;
    case Difficulty.expert:
      emptySquares = 54;
      break;
  }

  final generator = SudokuGenerator(emptySquares: emptySquares, uniqueSolution: true);
  return SudokuModel(board: generator.newSudoku, solution: generator.newSudokuSolved);
}
