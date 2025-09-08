import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/app/data/providers/providers.dart';
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

class _GamePageState extends AppConsumerState<GamePage> with WidgetsBindingObserver {
  late final _bloc = SudokuCubit(
    getDifficultyUseCase: ref.watch(getDifficultyUseCaseProvider),
    sharedPrefs: ref.watch(sharedPrefsProvider),
  );

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onUIReady() {
    super.onUIReady();

    _restoreOrBuildNewGame();
  }

  /// Try to restore a saved game, otherwise build a new one
  void _restoreOrBuildNewGame() async {
    _timer?.cancel();
    await _bloc.restoreGameIfAvailable();
    
    // If no saved game was restored, build a new game
    if (_bloc.state is SudokuInitial) {
      _bloc.buildNewGame();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _bloc.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // Save game state when app goes to background
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _bloc.saveStateForLifecycleChange();
        break;
      case AppLifecycleState.resumed:
        // App resumed - state is already loaded
        break;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: _bodyBuilder);

  Widget get _bodyBuilder => BlocBuilder<SudokuCubit, SudokuState>(
    bloc: _bloc,
    builder: (context, state) => switch (state) {
      SudokuLoaded state => _body(state),
      SudokuRestoring() => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator.adaptive(),
            SizedBox(height: 16),
            Text('Restoring game...'),
          ],
        ),
      ),
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

  Widget _board(SudokuLoaded state) => SudokuBoard(
        model: state.model,
        onGameWon: () => _onGameWon(state),
        onBoardChanged: (board) => _bloc.updateBoard(board),
      );

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
    _timer?.cancel();
    _bloc.buildNewGame();
  }

  Future<void> _onGameWon(SudokuLoaded state) async {
    _timer?.cancel();

    // Clear saved game state since the game is completed
    await _bloc.completeGame();

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
      _buildNewGame();
      return;
    }

    await ref
        .read(onGameWonUseCaseProvider)
        .execute(now, duration, state.difficulty, username!);

    _buildNewGame();
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
