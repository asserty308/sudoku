import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/app/config/keys.dart';
import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/game/data/models/leaderboard_entry_model.dart';

extension AppPreferences on SharedPreferencesAsync {
  Future<void> setDifficulty(Difficulty difficulty) => setString(kDifficultyKey, difficulty.name);

  Future<Difficulty> get difficulty async {
    final cachedDifficulty = await getString(kDifficultyKey) ?? '';
    return DifficultyExt.fromString(cachedDifficulty);
  }

  Future<void> setPreferredTheme(ThemeMode theme) => switch (theme) {
    ThemeMode.system => setInt(kPreferredThemeKey, 0),
    ThemeMode.light => setInt(kPreferredThemeKey, 1),
    ThemeMode.dark => setInt(kPreferredThemeKey, 2),
  };

  Future<ThemeMode> get preferredTheme async => switch (await getInt(kPreferredThemeKey)) {
    1 => ThemeMode.light,
    2 => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  Future<void> addTimeToLeaderboard(Difficulty difficulty, LeaderboardEntryModel entry) async {
    final currentLeaderboard = await getLeaderboard(difficulty);
    currentLeaderboard.add(entry);
    await setStringList(leaderboardDifficultyKey(difficulty), currentLeaderboard.map((e) => jsonEncode(e.toJson())).toList());
  }

  Future<List<LeaderboardEntryModel>> getLeaderboard(Difficulty difficulty) async {
    final values = await getStringList('leaderboard_${difficulty.name}') ?? <String>[];
    return values
      .map((e) => LeaderboardEntryModel.fromJson(jsonDecode(e)))
      .toList();
  }
}
