import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/data/models/difficulty.dart';
import 'package:sudoku/data/models/sudoku_model.dart';
import 'package:sudoku/data/repositories/sudoku_repo.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

part 'sudoku_state.dart';

class SudokuCubit extends Cubit<SudokuState> {
  SudokuCubit() : super(SudokuInitial());

  Future<void> buildNewGame() async {
    emit(SudokuLoading());

    final difficulty = sudokuRepo.getDifficulty();

    final generator = SudokuGenerator(
      emptySquares: difficulty.emptySquares, 
      uniqueSolution: true,
    );

    final model = SudokuModel(
      board: generator.newSudoku, 
      solution: generator.newSudokuSolved
    );

    emit(SudokuLoaded(model: model));
  }
}
