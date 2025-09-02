import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:sudoku/l10n/l10n.dart';

class EmptyLeaderboard extends StatelessWidget {
  const EmptyLeaderboard({super.key});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.leaderboard_outlined,
        size: 80,
        color: context.colorScheme.outline,
      ),
      vGap24,
      Text(
        context.l10n.leaderboardPageEmptyTitle,
        style: context.textTheme.headlineSmall?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
        ),
        textAlign: TextAlign.center,
      ),
      vGap16,
      Text(
        context.l10n.leaderboardPageEmptyDescription,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.outline,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  ).paddingAll(24).centered;
}
