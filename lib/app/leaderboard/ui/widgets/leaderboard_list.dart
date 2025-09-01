import 'package:flutter/material.dart';
import 'package:sudoku/app/leaderboard/ui/widgets/empty_leaderboard.dart';
import 'package:sudoku/app/leaderboard/ui/widgets/leaderboard_tile.dart';
import 'package:sudoku/game/data/models/leaderboard_entry_model.dart';

class LeaderboardList extends StatelessWidget {
  const LeaderboardList({super.key, required this.entries});

  final List<LeaderboardEntryModel> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const EmptyLeaderboard();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: entries.length,
      itemBuilder: (context, index) =>
          LeaderboardTile(entry: entries[index], rank: index + 1),
      separatorBuilder: (context, index) =>
          const Divider(height: 1, indent: 16, endIndent: 16),
    );
  }
}
