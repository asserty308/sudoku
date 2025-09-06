import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/game/data/models/sudoku_model.dart';
import 'package:sudoku/game/domain/use_cases/get_difficulty_use_case.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

part 'sudoku_state.dart';

class SudokuCubit extends Cubit<SudokuState> {
  SudokuCubit({required this.getDifficultyUseCase}) : super(SudokuInitial());

  final GetDifficultyUseCase getDifficultyUseCase;

  Future<void> buildNewGame() async {
    emit(SudokuLoading());

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
