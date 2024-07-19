import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/game/data/models/sudoku_model.dart';
import 'package:sudoku/game/data/providers/providers.dart';
import 'package:sudoku/game/ui/blocs/sudoku/sudoku_cubit.dart';
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
    body: _body,
  );

  Widget get _body => BlocBuilder(
    bloc: _bloc,
    builder: (context, state) {
      if (state is SudokuLoaded) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: _board(state.model),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(onPressed: () => appRouter.push('/settings'), icon: const Icon(Icons.settings)),
            )
          ],
        );
      }
      
      return const Center(child: CircularProgressIndicator.adaptive());
    }
  );

  Widget _board(SudokuModel model) => SudokuBoard(
    key: UniqueKey(),
    model: model,
    onGameWon: _onGameWon,
  );

  Future<void> _buildNewGame() async {
    await _bloc.buildNewGame();
  }

  void _onGameWon() => showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text(context.l10n.victoryDialogTitle),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
            _buildNewGame();
          }, 
          child: Text(context.l10n.victoryDialogDismiss)
        ),
      ],
    ),
  );
}
