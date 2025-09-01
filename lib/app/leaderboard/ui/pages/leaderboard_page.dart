import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/app/leaderboard/data/providers/providers.dart';
import 'package:sudoku/app/leaderboard/ui/blocs/leaderboard/leaderboard_cubit.dart';
import 'package:sudoku/app/leaderboard/ui/widgets/leaderboard_error.dart';
import 'package:sudoku/app/leaderboard/ui/widgets/leaderboard_list.dart';
import 'package:sudoku/app/leaderboard/ui/widgets/leaderboard_loading.dart';
import 'package:sudoku/l10n/l10n.dart';

class LeaderboardPage extends ConsumerStatefulWidget {
  const LeaderboardPage({super.key});

  @override
  ConsumerState<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends AppConsumerState<LeaderboardPage> {
  late final _bloc = LeaderboardCubit(
    getLeaderboardUseCase: ref.read(getLeaderboardProvider),
  );

  @override
  void onUIReady() {
    super.onUIReady();

    _bloc.getLeaderboard();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.l10n.leaderboardPageTitle)),
    body: _bodyBuilder,
  );

  Widget get _bodyBuilder => BlocBuilder<LeaderboardCubit, LeaderboardState>(
    bloc: _bloc,
    builder: (context, state) => switch (state) {
      LeaderboardStateLoaded l => LeaderboardList(entries: l.results),
      LeaderboardStateError _ => LeaderboardError(
        onRetry: _bloc.getLeaderboard,
      ),
      _ => const LeaderboardLoading(),
    },
  );
}
