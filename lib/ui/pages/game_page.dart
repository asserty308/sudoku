import 'package:flutter/material.dart';
import 'package:sudoku/data/models/difficulty.dart';
import 'package:sudoku/data/models/sudoku_model.dart';
import 'package:sudoku/data/services/sudoku_service.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  SudokuModel? _currentGame;

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Placeholder(),
  );

  Future<void> _buildNewGame() async {
    final newGame = await getNewSudoku(Difficulty.normal);

    setState(() {
      _currentGame = newGame;
    });
  }
}
