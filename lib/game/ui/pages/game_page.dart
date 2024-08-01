import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/game/data/models/sudoku_model.dart';
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
      SudokuLoaded state => _body(state.model),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    }
  );

  Widget _body(SudokuModel model) => Stack(
    children: [
      Align(
        alignment: Alignment.center,
        child: _board(model),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: _settingsButton,
      ),
      Align(
        alignment: Alignment.topRight,
        child: SudokuTimer(startTime: _bloc.timeStarted ?? DateTime.now()),
      )
    ],
  );

  Widget _board(SudokuModel model) => SudokuBoard(
    key: UniqueKey(),
    model: model,
    onGameWon: _onGameWon,
  );

  Widget get _settingsButton => IconButton(
    onPressed: () => appRouter.push('/settings'), 
    icon: const Icon(Icons.settings),
  );

  Future<void> _buildNewGame() async {
    _bloc.buildNewGame();
  }

  Future<void> _onGameWon() async {
    await ref.read(onGameWoneUseCaseProvider).execute(_bloc.timeStarted!, _bloc.difficulty!);

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
