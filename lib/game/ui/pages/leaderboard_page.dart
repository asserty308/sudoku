import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/app/data/providers/providers.dart';
import 'package:sudoku/game/data/models/leaderboard_entry_model.dart';
import 'package:sudoku/game/ui/blocs/leaderboard/leaderboard_cubit.dart';

class LeaderboardPage extends ConsumerStatefulWidget {
  const LeaderboardPage({super.key});

  @override
  ConsumerState<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends ConsumerState<LeaderboardPage> {
  late final _bloc = LeaderboardCubit(
    sharedPreferences: ref.read(sharedPrefsProvider),
  );

  @override
  void initState() {
    super.initState();

    _bloc.getLeaderboard();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
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

  Widget _leaderboardList(List<LeaderboardEntryModel> results) => ListView.separated(
    itemCount: results.length,
    itemBuilder: (context, index) => _leaderboardTile(results[index], index), 
    separatorBuilder: (context, index) => Divider(), 
  );

  Widget _leaderboardTile(LeaderboardEntryModel entry, int index) => ListTile(
    leading: SizedBox(
      width: 50, 
      child: Center(
        child: Text('${index+1}.'),
      ),
    ),
    title: Text(entry.username),
    trailing: Text('${entry.formattedDuration} min'),
  );

  Widget get _progressIndicator => Center(
    child: CircularProgressIndicator.adaptive(),
  );

  Widget get _errorHint => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'An unexpected error occured. Please try again.'
      ),
      const SizedBox(height: 32,),
      TextButton(
        onPressed: () => _bloc.getLeaderboard(), 
        child: Text('Reload leaderboard'),
      )
    ],
  );
}
