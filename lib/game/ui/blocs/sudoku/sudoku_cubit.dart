import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/app/data/repositories/app_prefs.dart';
import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/game/data/models/sudoku_model.dart';
import 'package:sudoku/game/domain/use_cases/get_difficulty_use_case.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

part 'sudoku_state.dart';

class SudokuCubit extends Cubit<SudokuState> {
  SudokuCubit({
    required this.getDifficultyUseCase,
    required this.sharedPrefs,
  }) : super(SudokuInitial());

  final GetDifficultyUseCase getDifficultyUseCase;
  final SharedPreferencesAsync sharedPrefs;

  /// Try to restore a previously saved game state
  Future<void> restoreGameIfAvailable() async {
    emit(SudokuRestoring());

    final savedState = await sharedPrefs.loadCurrentGameState();
    if (savedState != null) {
      logger.i('Restoring saved game state');
      emit(
        SudokuLoaded(
          model: savedState.model!,
          timeStarted: savedState.timeStarted!,
          difficulty: savedState.difficulty!,
        ),
      );
    } else {
      // No saved state, start fresh
      emit(SudokuInitial());
    }
  }

  Future<void> buildNewGame() async {
    emit(SudokuLoading());

    // Clear any existing saved game state
    await sharedPrefs.clearCurrentGameState();

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

    final newState = SudokuLoaded(
      model: model,
      timeStarted: timeStarted,
      difficulty: difficulty,
    );

    emit(newState);

    // Save the new game state
    await _saveCurrentState(newState);
  }

  /// Update the board state and persist it
  Future<void> updateBoard(List<List<int>> newBoard) async {
    final currentState = state;
    if (currentState is SudokuLoaded) {
      final updatedModel = SudokuModel(
        board: newBoard,
        solution: currentState.model.solution,
      );

      final newState = SudokuLoaded(
        model: updatedModel,
        timeStarted: currentState.timeStarted,
        difficulty: currentState.difficulty,
      );

      emit(newState);

      // Save the updated state
      await _saveCurrentState(newState);
    }
  }

  /// Clear saved game state when game is completed
  Future<void> completeGame() async {
    await sharedPrefs.clearCurrentGameState();
  }

  /// Save current game state to persistence
  Future<void> _saveCurrentState(SudokuLoaded state) async {
    try {
      await sharedPrefs.saveCurrentGameState(
        model: state.model,
        timeStarted: state.timeStarted,
        difficulty: state.difficulty,
      );
    } catch (e) {
      logger.e('Failed to save game state: $e');
    }
  }

  /// Save state when app lifecycle changes
  Future<void> saveStateForLifecycleChange() async {
    final currentState = state;
    if (currentState is SudokuLoaded) {
      await _saveCurrentState(currentState);
    }
  }
}
