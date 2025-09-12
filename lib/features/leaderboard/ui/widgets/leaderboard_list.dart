import 'package:flutter/material.dart';
import 'package:sudoku/features/leaderboard/ui/widgets/empty_leaderboard.dart';
import 'package:sudoku/features/leaderboard/ui/widgets/leaderboard_tile.dart';
import 'package:sudoku/features/game/data/models/leaderboard_entry_model.dart';

class LeaderboardList extends StatelessWidget {
  const LeaderboardList({super.key, required this.entries, this.onRefresh});

  final List<LeaderboardEntryModel> entries;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return onRefresh != null
          ? RefreshIndicator(
              onRefresh: onRefresh!,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: const EmptyLeaderboard(),
                ),
              ),
            )
          : const EmptyLeaderboard();
    }

    final listView = ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: entries.length,
      itemBuilder: (context, index) =>
          LeaderboardTile(entry: entries[index], rank: index + 1),
      separatorBuilder: (context, index) =>
          const Divider(height: 1, indent: 16, endIndent: 16),
    );

    return onRefresh != null
        ? RefreshIndicator(onRefresh: onRefresh!, child: listView)
        : listView;
  }
}
