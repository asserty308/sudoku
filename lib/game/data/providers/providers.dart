import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/app/data/providers/providers.dart';
import 'package:sudoku/game/data/repositories/sudoku_repo.dart';
import 'package:sudoku/game/domain/use_cases/get_difficulty_use_case.dart';
import 'package:sudoku/game/domain/use_cases/on_game_won_use_case.dart';
import 'package:sudoku/game/domain/use_cases/set_difficulty_use_case.dart';

final sudokuRepoProvider = Provider(
  (ref) => SudokuRepo(sharedPrefs: ref.watch(sharedPrefsProvider)),
);

final getDifficultyUseCaseProvider = Provider(
  (ref) => GetDifficultyUseCase(sudokuRepo: ref.watch(sudokuRepoProvider)),
);

final setDifficultyUseCaseProvider = Provider(
  (ref) => SetDifficultyUseCase(sudokuRepo: ref.watch(sudokuRepoProvider)),
);

final onGameWonUseCaseProvider = Provider(
  (ref) => OnGameWonUseCase(sharedPrefs: ref.watch(sharedPrefsProvider)),
);
