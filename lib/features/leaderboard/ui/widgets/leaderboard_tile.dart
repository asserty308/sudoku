import 'package:flutter/material.dart';
import 'package:sudoku/features/game/data/models/leaderboard_entry_model.dart';
import 'package:sudoku/l10n/l10n.dart';

class LeaderboardTile extends StatelessWidget {
  const LeaderboardTile({super.key, required this.entry, required this.rank});

  final LeaderboardEntryModel entry;
  final int rank;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 50,
        child: Center(
          child: Text(
            context.l10n.leaderboardPageRankingFormat(rank),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      title: Text(entry.username, style: Theme.of(context).textTheme.bodyLarge),
      trailing: Text(
        context.l10n.leaderboardPageTimeFormat(entry.formattedDuration),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
