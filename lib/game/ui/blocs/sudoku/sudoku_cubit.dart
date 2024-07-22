import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/game/data/models/sudoku_model.dart';
import 'package:sudoku/game/domain/usecases/get_difficulty_usecase.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

part 'sudoku_state.dart';

class SudokuCubit extends Cubit<SudokuState> {
  SudokuCubit({
    required this.getDifficultyUseCase,
  }) : super(SudokuInitial());

  final GetDifficultyUseCase getDifficultyUseCase;

  DateTime? _timeStarted;
  DateTime? get timeStarted => _timeStarted;

  Difficulty? difficulty;

  Future<void> buildNewGame() async {
    emit(SudokuLoading());

    difficulty = getDifficultyUseCase.execute();

    final generator = SudokuGenerator(
      emptySquares: difficulty!.emptySquares, 
      uniqueSolution: true,
    );

    final model = SudokuModel(
      board: generator.newSudoku, 
      solution: generator.newSudokuSolved
    );

    _timeStarted = DateTime.now();

    emit(SudokuLoaded(model: model));
  }
}
