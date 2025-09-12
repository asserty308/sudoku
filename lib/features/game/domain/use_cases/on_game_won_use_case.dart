import 'package:flutter_core/flutter_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/core/storage/app_prefs.dart';
import 'package:sudoku/features/game/data/models/difficulty.dart';
import 'package:sudoku/features/game/data/models/leaderboard_entry_model.dart';

class OnGameWonUseCase {
  OnGameWonUseCase({required this.sharedPrefs});

  final SharedPreferencesAsync sharedPrefs;

  Future<bool> execute(
    DateTime now,
    int durationInSeconds,
    Difficulty difficulty,
    String username,
  ) async {
    try {
      final entry = LeaderboardEntryModel(
        timestamp: now,
        durationInSeconds: durationInSeconds,
        username: username,
      );
      await sharedPrefs.addTimeToLeaderboard(difficulty, entry);
      return true;
    } catch (e) {
      logger.e('Error adding time to leaderboard', error: e);
      return false;
    }
  }
}
