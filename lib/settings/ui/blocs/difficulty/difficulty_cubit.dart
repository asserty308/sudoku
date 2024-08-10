import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/game/domain/use_cases/get_difficulty_use_case.dart';
import 'package:sudoku/game/domain/use_cases/set_difficulty_use_case.dart';

part 'difficulty_state.dart';

class DifficultyCubit extends Cubit<DifficultyState> {
  DifficultyCubit({
    required this.getDifficultyUseCase,
    required this.setDifficultyUseCase,
  }) : super(DifficultyInitial());

  final GetDifficultyUseCase getDifficultyUseCase;
  final SetDifficultyUseCase setDifficultyUseCase;

  var difficulty = Difficulty.normal;
  var difficultyChanged = false;

  Future<void> getDifficulty() async {
    emit(DifficultyLoading());

    try {
      difficulty = await getDifficultyUseCase.execute();
      emit(DifficultyLoaded(difficulty: difficulty));
    } catch (e) {
      log('Error loading difficulty', error: e);
      emit(DifficultyError());
    }
  }

  Future<void> changeDifficulty(Difficulty difficulty) async {
    await setDifficultyUseCase.execute(difficulty);
    difficultyChanged = true;
    await getDifficulty();
  }
}
