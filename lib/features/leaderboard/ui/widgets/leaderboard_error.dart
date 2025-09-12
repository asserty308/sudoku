import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildErrorIcon(context),
            const SizedBox(height: 16),
            Text(
              _getErrorTitle(context),
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _getErrorMessage(context),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.errorContainer.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.error.withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  message!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                    fontFamily: 'monospace',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            const SizedBox(height: 24),
            _buildRetryButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorIcon(BuildContext context) {
    IconData iconData;
    Color iconColor;

    switch (errorType) {
      case LeaderboardErrorType.network:
        iconData = Icons.wifi_off_outlined;
        iconColor = Theme.of(context).colorScheme.error;
        break;
      case LeaderboardErrorType.storage:
        iconData = Icons.storage_outlined;
        iconColor = Theme.of(context).colorScheme.error;
        break;
      case LeaderboardErrorType.unknown:
        iconData = Icons.error_outline;
        iconColor = Theme.of(context).colorScheme.error;
        break;
    }

    return Icon(iconData, size: 64, color: iconColor);
  }

  String _getErrorTitle(BuildContext context) {
    switch (errorType) {
      case LeaderboardErrorType.network:
        return context.l10n.connectionErrorTitle;
      case LeaderboardErrorType.storage:
        return context.l10n.storageErrorTitle;
      case LeaderboardErrorType.unknown:
        return context.l10n.unexpectedErrorTitle;
    }
  }

  String _getErrorMessage(BuildContext context) {
    switch (errorType) {
      case LeaderboardErrorType.network:
        return context.l10n.leaderboardPageNetworkError;
      case LeaderboardErrorType.storage:
        return context.l10n.leaderboardPageStorageError;
      case LeaderboardErrorType.unknown:
        return context.l10n.leaderboardPageUnknownError;
    }
  }

  Widget _buildRetryButton(BuildContext context) {
    return FilledButton.icon(
      onPressed: onRetry,
      icon: const Icon(Icons.refresh),
      label: Text(context.l10n.leaderboardPageRetryButton),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }
}
