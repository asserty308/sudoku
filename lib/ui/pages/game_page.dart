import 'package:flutter/material.dart';
import 'package:sudoku/data/models/difficulty.dart';
import 'package:sudoku/data/models/sudoku_model.dart';
import 'package:sudoku/data/services/sudoku_service.dart';
import 'package:sudoku/ui/widgets/board.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  SudokuModel? _currentGame;

  var _boardKey = UniqueKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _buildNewGame());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Builder(
      builder: (context) {
        if (_currentGame == null) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        return Center(
          child: SudokuBoard(
            key: _boardKey,
            model: _currentGame!,
            onSuccess: () => showDialog(
              context: context, 
              builder: (context) => AlertDialog(
                title: const Text('You won'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _buildNewGame();
                    }, 
                    child: const Text('Okay')
                  ),
                ],
              )
            ),
          ),
        );
      }
    ),
  );

  Future<void> _buildNewGame() async {
    final newGame = await getNewSudoku(Difficulty.normal);

    setState(() {
      _boardKey = UniqueKey();
      _currentGame = newGame;
    });
  }
}
