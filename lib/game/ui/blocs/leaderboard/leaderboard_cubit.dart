import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/app/data/repositories/app_prefs.dart';
import 'package:sudoku/game/data/models/leaderboard_entry_model.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit({
    required this.sharedPreferences,
  }) : super(LeaderboardInitial());

  final SharedPreferencesAsync sharedPreferences;

  Future<void> getLeaderboard() async {
    emit(LeaderboardLoading());

    try {
      final results = await sharedPreferences.getLeaderboard(await sharedPreferences.difficulty);
      emit(LeaderboardLoaded(results: results));
    } catch (e) {
      log('Error loading leaderborad', error: e);
      emit(LeaderboardError());
    }
  }
}
