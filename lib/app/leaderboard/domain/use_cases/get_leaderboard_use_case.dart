import 'package:flutter_core/flutter_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/app/data/repositories/app_prefs.dart';
import 'package:sudoku/game/data/models/leaderboard_entry_model.dart';

class GetLeaderboardUseCase {
  GetLeaderboardUseCase({required this.sharedPrefs});

  final SharedPreferencesAsync sharedPrefs;

  Future<List<LeaderboardEntryModel>> execute() async {
    final difficulty = await sharedPrefs.difficulty;

    logger.i('Getting leaderboard for difficulty: $difficulty');

    return await sharedPrefs.getLeaderboard(difficulty);
  }
}
