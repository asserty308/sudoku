import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class const LeaderboardLoading({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const .all(24.0),
      child: Column(
        mainAxisSize: .min,
        children: [
          const CircularProgressIndicator.adaptive(),
          vGap16,
          Text(
            'Loading leaderboard...',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    ),
  );
}
