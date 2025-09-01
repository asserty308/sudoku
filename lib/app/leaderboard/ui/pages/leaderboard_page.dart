import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/app/leaderboard/data/providers/providers.dart';
import 'package:sudoku/app/leaderboard/ui/blocs/leaderboard/leaderboard_cubit.dart';
import 'package:sudoku/game/data/models/leaderboard_entry_model.dart';
import 'package:sudoku/l10n/l10n.dart';

class LeaderboardPage extends ConsumerStatefulWidget {
  const LeaderboardPage({super.key});

  @override
  ConsumerState<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends ConsumerState<LeaderboardPage> {
  late final _bloc = LeaderboardCubit(
    getLeaderboardUseCase: ref.read(getLeaderboardProvider),
  );

  @override
  void initState() {
    super.initState();

    _bloc.getLeaderboard();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Leaderboard')),
    body: _bodyBuilder,
  );

  Widget get _bodyBuilder => BlocBuilder<LeaderboardCubit, LeaderboardState>(
    bloc: _bloc,
    builder: (context, state) => switch (state) {
      LeaderboardLoaded l => _leaderboardList(l.results),
      LeaderboardError _ => _errorHint,
      _ => _progressIndicator,
    },
  );

  Widget _leaderboardList(List<LeaderboardEntryModel> results) =>
      results.isEmpty
      ? Center(child: Text('No entries available'))
      : ListView.separated(
          itemCount: results.length,
          itemBuilder: (context, index) =>
              _leaderboardTile(results[index], index),
          separatorBuilder: (context, index) => Divider(),
        );

  Widget _leaderboardTile(LeaderboardEntryModel entry, int index) => ListTile(
    leading: SizedBox(width: 50, child: Center(child: Text('${index + 1}.'))),
    title: Text(entry.username),
    trailing: Text('${entry.formattedDuration} min'),
  );

  Widget get _progressIndicator =>
      Center(child: CircularProgressIndicator.adaptive());

  Widget get _errorHint => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(context.l10n.leaderboardPageErrorMessage),
        const SizedBox(height: 32),
        TextButton(
          onPressed: () => _bloc.getLeaderboard(),
          child: Text(context.l10n.leaderboardPageErrorButton),
        ),
      ],
    ),
  );
}
