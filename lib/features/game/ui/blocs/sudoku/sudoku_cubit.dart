import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:sudoku/features/game/data/models/difficulty.dart';
import 'package:sudoku/features/game/data/models/sudoku_model.dart';
import 'package:sudoku/features/game/domain/use_cases/get_difficulty_use_case.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

part 'sudoku_state.dart';

class SudokuCubit({required final GetDifficultyUseCase getDifficultyUseCase}) extends Cubit<SudokuState> {
  this : super(const SudokuInitial());

  Future<void> buildNewGame() async {
    emit(const SudokuLoading());

    final difficulty = await getDifficultyUseCase.execute();

    final generator = SudokuGenerator(
      emptySquares: difficulty.emptySquares,
      uniqueSolution: true,
    );

    final model = SudokuModel(
      board: generator.newSudoku,
      solution: generator.newSudokuSolved,
    );

    final timeStarted = DateTime.now();

    logger.i('Building new game with difficulty ${difficulty.name}');

    emit(
      SudokuLoaded(
        model: model,
        timeStarted: timeStarted,
        difficulty: difficulty,
      ),
    );
  }
}
