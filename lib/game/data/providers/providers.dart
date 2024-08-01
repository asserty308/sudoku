import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/game/data/repositories/sudoku_repo.dart';
import 'package:sudoku/game/domain/usecases/get_difficulty_usecase.dart';
import 'package:sudoku/game/domain/usecases/on_game_won_usecase.dart';
import 'package:sudoku/game/domain/usecases/set_difficulty_usecase.dart';
import 'package:sudoku/game/ui/blocs/sudoku/sudoku_cubit.dart';

final sudokuRepoProvider = Provider((ref) => SudokuRepo());

final getDifficultyUseCaseProvider = Provider((ref) => GetDifficultyUseCase(
  sudokuRepo: ref.watch(sudokuRepoProvider),
));

final setDifficultyUseCaseProvider = Provider((ref) => SetDifficultyUseCase(
  sudokuRepo: ref.watch(sudokuRepoProvider),
));

final sudokuCubitProvider = Provider((ref) => SudokuCubit(
  getDifficultyUseCase: ref.watch(getDifficultyUseCaseProvider)),
);

final onGameWoneUseCaseProvider = Provider((ref) => OnGameWonUseCase());
