import 'package:flutter/material.dart';
import 'package:sudoku/data/models/sudoku_model.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

class SudokuBoard extends StatefulWidget {
  const SudokuBoard({
    super.key, 
    required this.model, 
    required this.onSuccess,
  });

  final SudokuModel model;
  final VoidCallback onSuccess;

  @override
  State<SudokuBoard> createState() => _SudokuBoardState();
}

class _SudokuBoardState extends State<SudokuBoard> {
  var _currentProgress = <List<int>>[];
  ({int x,int y})? _selectedField;

  @override
  void initState() {
    super.initState();

    _currentProgress = widget.model.board.map((row) => [...row]).toList();
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ...List.generate(9, _row),
      if (_selectedField != null) ...[
        const SizedBox(height: 16,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(9, _inputButton),
        ),
      ]
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
        onPressed: editable ? () => setState(() {
          _selectedField = (x:x,y:y);
        }) : null, 
        child: Text(value),
      ),
    );
  }

  Widget _inputButton(int index) {
    final value = index + 1;

    return Container(
      width: _buttonSize,
      height: _buttonSize,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            _currentProgress[_selectedField!.y][_selectedField!.x] = value;
            _selectedField = null;
          });

          if (SudokuUtilities.isSolved(_currentProgress)) {
            widget.onSuccess();
          }
        }, 
        child: Text('$value'),
      ),
    );
  }

  double get _buttonSize {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide < 500 ? 38 : 50;
  }

  Color _tileColor(int x, int y) {
    final color1 = Colors.amber.shade100;
    final color2 = Colors.amber.shade50;

    if (_selectedField?.x == x && _selectedField?.y == y) {
      return Colors.amber;
    }

    if ((y > 2 && y < 6) && (x > 2 && x < 6)) {
      return color1;
    }

    if ((y > 2 && y < 6) || (x > 2 && x < 6)) {
      return color2;
    }

    return color1;
  }
}