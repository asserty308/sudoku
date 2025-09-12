import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:sudoku/features/game/data/models/difficulty.dart';
import 'package:sudoku/features/game/domain/use_cases/get_difficulty_use_case.dart';
import 'package:sudoku/features/game/domain/use_cases/set_difficulty_use_case.dart';

part 'difficulty_state.dart';

class DifficultyCubit extends Cubit<DifficultyState> {
  DifficultyCubit({
    required this.getDifficultyUseCase,
    required this.setDifficultyUseCase,
  }) : super(DifficultyInitial());

  final GetDifficultyUseCase getDifficultyUseCase;
  final SetDifficultyUseCase setDifficultyUseCase;

  var difficulty = Difficulty.normal;

  Future<void> getDifficulty() async {
    emit(DifficultyLoading());

    try {
      difficulty = await getDifficultyUseCase.execute();
      emit(DifficultyLoaded(difficulty: difficulty));
    } catch (e) {
      logger.e('Error loading difficulty', error: e);
      emit(DifficultyError());
    }
  }

  Future<void> changeDifficulty(Difficulty newDifficulty) async {
    try {
      await setDifficultyUseCase.execute(newDifficulty);
      difficulty = newDifficulty;
      emit(DifficultyChanged(difficulty: difficulty));
    } on Exception catch (e) {
      logger.e('Error changing difficulty', error: e);
      emit(DifficultyError());
    }
  }
}
