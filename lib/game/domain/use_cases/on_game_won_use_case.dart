import 'dart:developer';

import 'package:sudoku/app/domain/setup.dart';
import 'package:sudoku/app/data/repositories/app_prefs.dart';
import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/game/data/models/leaderboard_entry_model.dart';

class OnGameWonUseCase {
  Future<bool> execute(DateTime timeStarted, Difficulty difficulty) async {
    try {
      final now = DateTime.now();
      final duration = now.difference(timeStarted).inSeconds;
      final entry = LeaderboardEntryModel(
        timestamp:  now, 
        durationInSeconds: duration, 
        username: 'dev',
      );
      await sharedPrefs.addTimeToLeaderboard(difficulty, entry);
      return true;
    } catch (e) {
      log('Error adding time to leaderboard', error: e);
      return false;
    }
  }
}
