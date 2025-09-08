import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/app/config/keys.dart';
import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/game/data/models/leaderboard_entry_model.dart';
import 'package:sudoku/game/data/models/sudoku_model.dart';

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

  // Game state persistence for preventing data loss on tab switches
  static const String _keyCurrentGameBoard = 'current_game_board';
  static const String _keyCurrentGameSolution = 'current_game_solution';
  static const String _keyCurrentGameStartTime = 'current_game_start_time';
  static const String _keyCurrentGameDifficulty = 'current_game_difficulty';

  /// Save current game state to persist during app lifecycle changes
  Future<void> saveCurrentGameState({
    required SudokuModel model,
    required DateTime timeStarted,
    required Difficulty difficulty,
  }) async {
    await setString(_keyCurrentGameBoard, jsonEncode(model.board));
    await setString(_keyCurrentGameSolution, jsonEncode(model.solution));
    await setString(_keyCurrentGameStartTime, timeStarted.toIso8601String());
    await setString(_keyCurrentGameDifficulty, difficulty.name);
  }

  /// Load saved game state if available
  Future<({
    SudokuModel? model,
    DateTime? timeStarted,
    Difficulty? difficulty,
  })?> loadCurrentGameState() async {
    final boardJson = await getString(_keyCurrentGameBoard);
    final solutionJson = await getString(_keyCurrentGameSolution);
    final timeStartedString = await getString(_keyCurrentGameStartTime);
    final difficultyString = await getString(_keyCurrentGameDifficulty);

    if (boardJson != null && 
        solutionJson != null && 
        timeStartedString != null && 
        difficultyString != null) {
      try {
        final board = List<List<int>>.from(
          (jsonDecode(boardJson) as List).map(
            (row) => List<int>.from(row),
          ),
        );
        final solution = List<List<int>>.from(
          (jsonDecode(solutionJson) as List).map(
            (row) => List<int>.from(row),
          ),
        );
        final timeStarted = DateTime.parse(timeStartedString);
        final difficulty = DifficultyExt.fromString(difficultyString);

        return (
          model: SudokuModel(board: board, solution: solution),
          timeStarted: timeStarted,
          difficulty: difficulty,
        );
      } catch (e) {
        // If parsing fails, clear the corrupted data
        await clearCurrentGameState();
        return null;
      }
    }
    return null;
  }

  /// Clear saved game state (when game is completed or reset)
  Future<void> clearCurrentGameState() async {
    await remove(_keyCurrentGameBoard);
    await remove(_keyCurrentGameSolution);
    await remove(_keyCurrentGameStartTime);
    await remove(_keyCurrentGameDifficulty);
  }

  /// Check if there's a saved game state
  Future<bool> hasCurrentGameState() async {
    final boardJson = await getString(_keyCurrentGameBoard);
    return boardJson != null;
  }
}
