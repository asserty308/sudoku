import 'package:flutter_core/flutter_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sudoku/features/game/data/models/leaderboard_entry_model.dart';
import 'package:sudoku/l10n/l10n.dart';

class const LeaderboardTile({super.key, required final LeaderboardEntryModel entry, required final int rank}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListTile(
    leading: SizedBox(
      width: 50,
      child: Center(
        child: Text(
          context.l10n.leaderboardPageRankingFormat(rank),
          style: context.textTheme.bodyMedium?.copyWith(fontWeight: .bold),
        ),
      ),
    ),
    title: Text(entry.username, style: context.textTheme.bodyLarge),
    trailing: Text(
      context.l10n.leaderboardPageTimeFormat(entry.formattedDuration),
      style: context.textTheme.bodyMedium?.copyWith(
        color: context.colorScheme.secondary,
      ),
    ),
  );
}
