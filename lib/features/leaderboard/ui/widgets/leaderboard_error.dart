import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:sudoku/features/leaderboard/ui/blocs/leaderboard/leaderboard_cubit.dart';
import 'package:sudoku/l10n/l10n.dart';

class LeaderboardError extends StatelessWidget {
  const LeaderboardError({
    super.key,
    required this.onRetry,
    required this.errorType,
    this.message,
  });

  final VoidCallback onRetry;
  final LeaderboardErrorType errorType;
  final String? message;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const .all(24.0),
      child: Column(
        mainAxisSize: .min,
        children: [
          _buildErrorIcon(context),
          vGap16,
          Text(
            _getErrorTitle(context),
            style: context.textTheme.headlineSmall,
            textAlign: .center,
          ),
          vGap8,
          Text(
            _getErrorMessage(context),
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: .center,
          ),
          if (message != null) ...[
            vGap12,
            Container(
              padding: const .all(12),
              decoration: BoxDecoration(
                color: context.colorScheme.errorContainer.withValues(
                  alpha: 0.1,
                ),
                borderRadius: BorderRadius.circular(8),
                border: .all(
                  color: context.colorScheme.error.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                message!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.error,
                  fontFamily: 'monospace',
                ),
                textAlign: .center,
              ),
            ),
          ],
          vGap24,
          _buildRetryButton(context),
        ],
      ),
    ),
  );

  Widget _buildErrorIcon(BuildContext context) => Icon(
    switch (errorType) {
      .network => Icons.wifi_off_outlined,
      .storage => Icons.storage_outlined,
      .unknown => Icons.error_outline,
    },
    size: 64,
    color: context.colorScheme.error,
  );

  String _getErrorTitle(BuildContext context) => switch (errorType) {
    .network => context.l10n.connectionErrorTitle,
    .storage => context.l10n.storageErrorTitle,
    .unknown => context.l10n.unexpectedErrorTitle,
  };

  String _getErrorMessage(BuildContext context) => switch (errorType) {
    .network => context.l10n.leaderboardPageNetworkError,
    .storage => context.l10n.leaderboardPageStorageError,
    .unknown => context.l10n.leaderboardPageUnknownError,
  };

  Widget _buildRetryButton(BuildContext context) => FilledButton.icon(
    onPressed: onRetry,
    icon: const Icon(Icons.refresh),
    label: Text(context.l10n.leaderboardPageRetryButton),
    style: FilledButton.styleFrom(
      padding: const .symmetric(horizontal: 24, vertical: 12),
    ),
  );
}
