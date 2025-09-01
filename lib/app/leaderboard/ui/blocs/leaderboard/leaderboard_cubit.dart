import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/app/leaderboard/domain/use_cases/get_leaderboard_use_case.dart';
import 'package:sudoku/game/data/models/leaderboard_entry_model.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit({required this.getLeaderboardUseCase})
    : super(LeaderboardStateInitial());

  final GetLeaderboardUseCase getLeaderboardUseCase;

  /// Loads the leaderboard of the currently selected diffictulty.
  /// Emits a [LeaderboardError] when an error occurs.
  Future<void> getLeaderboard() async {
    emit(LeaderboardStateLoading());

    try {
      final results = await getLeaderboardUseCase.execute();
      emit(LeaderboardStateLoaded(results: results));
    } catch (e) {
      log('Error loading leaderboard', error: e);
      emit(LeaderboardStateError());
    }
  }
}
