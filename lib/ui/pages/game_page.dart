import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku/business/sudoku/sudoku_cubit.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/router/app_router.dart';
import 'package:sudoku/ui/widgets/board.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _bloc = SudokuCubit();

  @override
  void initState() {
    super.initState();

    _buildNewGame();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [
        IconButton(onPressed: () => appRouter.push('/settings'), icon: const Icon(Icons.settings))
      ],
    ),
    body: BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        if (state is SudokuLoaded) {
          return Center(
            child: SudokuBoard(
              key: UniqueKey(),
              model: state.model,
              onGameWon: _onGameWon,
            ),
          );
        }
        
        return const Center(child: CircularProgressIndicator.adaptive());
      }
    ),
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
    )
  );
}
