import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/game/data/models/difficulty.dart';
import 'package:sudoku/game/data/providers/providers.dart';
import 'package:sudoku/game/ui/blocs/sudoku/sudoku_cubit.dart';
import 'package:sudoku/game/ui/widgets/board.dart';
import 'package:sudoku/game/ui/widgets/timer.dart';
import 'package:sudoku/l10n/l10n.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends AppConsumerState<GamePage> {
  late final _bloc = SudokuCubit(
    getDifficultyUseCase: ref.watch(getDifficultyUseCaseProvider),
  );

  Timer? _timer;

  @override
  void onUIReady() {
    super.onUIReady();

    _buildNewGame();
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: _bodyBuilder);

  Widget get _bodyBuilder => BlocBuilder<SudokuCubit, SudokuState>(
    bloc: _bloc,
    builder: (context, state) => switch (state) {
      SudokuLoaded state => _body(state),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    },
  );

  Widget _body(SudokuLoaded state) => SafeArea(
    child: Stack(
      children: [
        Align(alignment: Alignment.center, child: _board(state)),
        Align(
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [_leaderboardButton, _settingsButton],
          ),
        ),
        Align(alignment: Alignment.topRight, child: _timerWidget(state)),
      ],
    ),
  );

  Widget _board(SudokuLoaded state) =>
      SudokuBoard(model: state.model, onGameWon: () => _onGameWon(state));

  Widget get _leaderboardButton => IconButton(
    onPressed: () => context.push('/leaderboard'),
    icon: const Icon(Icons.leaderboard),
  );

  Widget get _settingsButton => IconButton(
    onPressed: () async {
      final newDifficulty = await context.push<Difficulty?>('/settings');

      if (newDifficulty != null) {
        await _showDifficultyChangedDialog();
      }
    },
    icon: const Icon(Icons.settings),
  );

  Widget _timerWidget(SudokuLoaded state) => SudokuTimer(
    startTime: state.timeStarted,
    onTimerCreated: (timer) {
      _timer = timer;
    },
  ).paddingAll(8.0);

  void _buildNewGame() {
    _timer?.cancel(); // Cancel any existing timer
    _bloc.buildNewGame();
  }

  Future<void> _onGameWon(SudokuLoaded state) async {
    _timer?.cancel();

    final now = DateTime.now();
    final duration = now.difference(state.timeStarted).inSeconds;

    await showDialog(
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

    if (!mounted) {
      return;
    }

    final username = await showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController textController = TextEditingController();
        return AlertDialog(
          title: Text(context.l10n.enterYourNameDialogTitle),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: context.l10n.enterYourNameHint,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.l10n.cancelButton),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(textController.text),
              child: Text(context.l10n.submitButton),
            ),
          ],
        );
      },
    );

    if (username?.isEmpty ?? true) {
      return;
    }

    await ref
        .read(onGameWonUseCaseProvider)
        .execute(now, duration, state.difficulty, username!);
  }

  Future<void> _showDifficultyChangedDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.changedDifficultyDialogTitle),
        content: Text(context.l10n.changedDifficultyDialogBody),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(); // Dialog
              _buildNewGame();
            },
            child: Text(context.l10n.changedDifficultyDialogNew),
          ),
          TextButton(
            onPressed: () {
              context.pop(); // Dialog
            },
            child: Text(context.l10n.changedDifficultyDialogResume),
          ),
        ],
      ),
    );
  }
}
