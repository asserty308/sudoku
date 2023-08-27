import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sudoku/data/models/sudoku_model.dart';
import 'package:sudoku/utility/context_ext.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

class SudokuBoard extends StatefulWidget {
  const SudokuBoard({
    super.key, 
    required this.model, 
    required this.onGameWon,
  });

  final SudokuModel model;
  final VoidCallback onGameWon;

  @override
  State<SudokuBoard> createState() => _SudokuBoardState();
}

class _SudokuBoardState extends State<SudokuBoard> {
  var _currentProgress = <List<int>>[];
  ({int x,int y})? _selectedField;

  @override
  void initState() {
    super.initState();

    // Use a copy of the initial board to keep the initial state
    _currentProgress = widget.model.boardCopy;
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ...List.generate(9, _row),
      if (_selectedField != null)
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: _inputRow,
        ),
    ],
  );

  Widget _row(int y) => Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(9, (x) => _tile(x, y)),
  );

  Widget _tile(int x, int y) {
    final editable = widget.model.board[y][x] == 0;
    final item = _currentProgress[y][x];
    final value = item == 0 ? '' : '$item';

    return Container(
      width: _buttonSize,
      height: _buttonSize,
      decoration: BoxDecoration(
        border: Border.all(),
        color: _tileColor(x, y),
      ),
      child: TextButton(
        onPressed: editable ? () => _onEdit(x, y)  : null, 
        child: Text(value),
      ),
    );
  }

  Widget get _inputRow => Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(9, _inputButton),
  );

  Widget _inputButton(int index) {
    final value = index + 1;

    return Container(
      width: _buttonSize,
      height: _buttonSize,
      decoration: BoxDecoration(
        border: Border.all(
          color: context.isDarkMode ? Colors.white : Colors.black
        ),
      ),
      child: TextButton(
        onPressed: () => _onInput(value), 
        child: Text('$value'),
      ),
    );
  }

  double get _buttonSize {
    final shortestSide = context.mediaSize.shortestSide;
    return shortestSide < 500 ? 38 : 50;
  }

  Color _tileColor(int x, int y) {
    final color1 = context.isDarkMode ? Colors.blueGrey.shade800 : Colors.amber.shade100;
    final color2 = context.isDarkMode ? Colors.blueGrey.shade700 : Colors.amber.shade50;
    final selectedColor = context.isDarkMode ? Colors.blueGrey : Colors.amber;

    if (_selectedField?.x == x && _selectedField?.y == y) {
      return selectedColor;
    }

    if ((y > 2 && y < 6) && (x > 2 && x < 6)) {
      return color1;
    }

    if ((y > 2 && y < 6) || (x > 2 && x < 6)) {
      return color2;
    }

    return color1;
  }

  void _onEdit(int x, int y) => setState(() {
    _selectedField = (x:x,y:y);
  });

  void _onInput(int value) {
    setState(() {
      _currentProgress[_selectedField!.y][_selectedField!.x] = value;
      _selectedField = null;
    });

    try {
      if (SudokuUtilities.isSolved(_currentProgress)) {
        widget.onGameWon();
      }
    } on InvalidSudokuConfigurationException {
      log('Invalid input');
    }
  }
}