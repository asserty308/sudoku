import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/core/config/keys.dart';
import 'package:sudoku/features/game/data/models/difficulty.dart';
import 'package:sudoku/features/game/data/models/leaderboard_entry_model.dart';

extension AppPreferences on SharedPreferencesAsync {
  Future<void> setDifficulty(Difficulty difficulty) =>
      setString(keyDifficulty, difficulty.name);

  Future<Difficulty> get difficulty async {
    final cachedDifficulty = await getString(keyDifficulty) ?? '';
    return DifficultyExt.fromString(cachedDifficulty);
  }

  Future<void> setPreferredTheme(ThemeMode theme) => switch (theme) {
    ThemeMode.system => setInt(keyPreferredTheme, 0),
    ThemeMode.light => setInt(keyPreferredTheme, 1),
    ThemeMode.dark => setInt(keyPreferredTheme, 2),
  };

  Future<ThemeMode> get preferredTheme async =>
      switch (await getInt(keyPreferredTheme)) {
        1 => ThemeMode.light,
        2 => ThemeMode.dark,
        _ => ThemeMode.system,
      };

  Future<void> addTimeToLeaderboard(
    Difficulty difficulty,
    LeaderboardEntryModel entry,
  ) async {
    final currentLeaderboard = await getLeaderboard(difficulty);
    currentLeaderboard.add(entry);
    await setStringList(
      leaderboardDifficultyKey(difficulty),
      currentLeaderboard.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  Future<List<LeaderboardEntryModel>> getLeaderboard(
    Difficulty difficulty,
  ) async {
    final values =
        await getStringList('leaderboard_${difficulty.name}') ?? <String>[];
    return values
        .map((e) => LeaderboardEntryModel.fromJson(jsonDecode(e)))
        .toList()
      ..sort((a, b) => a.durationInSeconds.compareTo(b.durationInSeconds));
  }
}
