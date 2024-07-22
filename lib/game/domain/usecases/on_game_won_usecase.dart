import 'dart:developer';

import 'package:sudoku/app/domain/setup.dart';
import 'package:sudoku/app/data/repositories/shared_prefs.dart';
import 'package:sudoku/game/data/models/leaderboard_entry_model.dart';
import 'package:sudoku/game/ui/blocs/sudoku/sudoku_cubit.dart';

class OnGameWonUseCase {
  OnGameWonUseCase({required this.bloc});

  final SudokuCubit bloc;

  Future<bool> execute() async {
    try {
      final now = DateTime.now();
      final duration = now.difference(bloc.timeStarted!).inSeconds;
      final entry = LeaderboardEntryModel(
        timestamp:  now, 
        durationInSeconds: duration, 
        username: 'dev',
      );
      await sharedPrefs.addTimeToLeaderboard(bloc.difficulty!, entry);
      return true;
    } catch (e) {
      log('Error adding time to leaderboard', error: e);
      return false;
    }
  }
}
