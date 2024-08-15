import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/game/data/providers/providers.dart';
import 'package:sudoku/game/ui/blocs/sudoku/sudoku_cubit.dart';
import 'package:sudoku/game/ui/widgets/timer.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/app/domain/app_router.dart';
import 'package:sudoku/game/ui/widgets/board.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  late final _bloc = ref.read(sudokuCubitProvider);
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _buildNewGame();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: _bodyBuilder,
  );

  Widget get _bodyBuilder => BlocBuilder<SudokuCubit, SudokuState>(
    bloc: _bloc,
    builder: (context, state) => switch (state) {
      SudokuLoaded state => _body(state),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    }
  );

  Widget _body(SudokuLoaded state) => Stack(
    key: UniqueKey(), // needed to start new games
    children: [
      Align(
        alignment: Alignment.center,
        child: _board(state),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _leaderboardButton,
            _settingsButton,
          ],
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: _timerWidget(state),
      )
    ],
  );

  Widget _board(SudokuLoaded state) => SudokuBoard(
    model: state.model,
    onGameWon: () => _onGameWon(state),
  );

  Widget get _leaderboardButton => IconButton(
    onPressed: () => appRouter.push('/leaderboard'), 
    icon: const Icon(Icons.leaderboard),
  );

  Widget get _settingsButton => IconButton(
    onPressed: () => appRouter.push('/settings'), 
    icon: const Icon(Icons.settings),
  );

  Widget _timerWidget(SudokuLoaded state) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: SudokuTimer(
      startTime: state.timeStarted,
      onTimerCreated: (timer) {
        _timer = timer;
      },
    ),
  );

  void _buildNewGame() {
    _bloc.buildNewGame();
  }

  Future<void> _onGameWon(SudokuLoaded state) async {
    _timer?.cancel();
    await ref.read(onGameWonUseCaseProvider).execute(state.timeStarted, state.difficulty);

    if (!mounted) {
      return;
    }

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text(context.l10n.victoryDialogTitle),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
              _buildNewGame();
            }, 
            child: Text(context.l10n.victoryDialogDismiss),
          ),
        ],
      ),
    );
  }
}
