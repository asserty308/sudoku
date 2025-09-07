import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:sudoku/app/domain/theme.dart';
import 'package:sudoku/app/ui/styles/colors.dart';
import 'package:sudoku/game/data/models/sudoku_model.dart';
import 'package:sudoku/game/domain/use_cases/handle_keyboad_input_use_case.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

class SudokuBoard extends StatefulWidget {
  const SudokuBoard({super.key, required this.model, required this.onGameWon});

  final SudokuModel model;
  final VoidCallback onGameWon;

  @override
  State<SudokuBoard> createState() => _SudokuBoardState();
}

class _SudokuBoardState extends State<SudokuBoard> {
  var _currentProgress = <List<int>>[];
  ({int x, int y})? _selectedField;

  final _focusNode = FocusNode();
  final handleKeyboadInputUseCase = HandleKeyboadInputUseCase();

  @override
  void initState() {
    super.initState();

    // Use a copy of the initial board to keep the initial state
    _currentProgress = widget.model.boardCopy;
  }

  @override
  void didUpdateWidget(SudokuBoard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reset the board when a new model is provided
    if (oldWidget.model != widget.model) {
      _currentProgress = widget.model.boardCopy;
      _selectedField = null; // Clear any selected field
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Focus(
    focusNode: _focusNode,
    autofocus: true,
    onKeyEvent: (focusNode, event) {
      final enterValue = handleKeyboadInputUseCase.execute(event);

      if (enterValue > 0) {
        _onInput(enterValue);
        return KeyEventResult.handled;
      } else if (enterValue == -1) {
        _onDelete();
        return KeyEventResult.handled;
      }

      return KeyEventResult.ignored;
    },
    child: _board,
  );

  Widget get _board => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ...List.generate(9, _row),
      if (_selectedField != null)
        Padding(padding: const EdgeInsets.only(top: 16), child: _inputRow),
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
      decoration: BoxDecoration(border: Border.all(), color: _tileColor(x, y)),
      child: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        onPressed: editable ? () => _onEdit(x, y) : null,
        child: Text(value, style: TextStyle(fontSize: 21)),
      ),
    );
  }

  Widget get _inputRow => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ...List.generate(9, _inputButton),
      _deleteButton,
    ],
  );

  Widget _inputButton(int index) {
    final value = index + 1;

    return Container(
      width: _buttonSize,
      height: _buttonSize,
      decoration: BoxDecoration(
        border: Border.all(
          color: context.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        onPressed: () => _onInput(value),
        child: Text('$value', style: TextStyle(fontSize: 21)),
      ),
    );
  }

  Widget get _deleteButton => Container(
    width: _buttonSize,
    height: _buttonSize,
    decoration: BoxDecoration(
      border: Border.all(
        color: context.isDarkMode ? Colors.white : Colors.black,
      ),
    ),
    child: TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: _onDelete,
      child: Icon(
        Icons.backspace,
        size: 20,
        color: context.isDarkMode ? Colors.white : Colors.black,
      ),
    ),
  );

  double get _buttonSize {
    final shortestSide = context.mediaSize.shortestSide;
    return shortestSide < 500 ? 38 : 50;
  }

  Color _tileColor(int x, int y) {
    if (_selectedField?.x == x && _selectedField?.y == y) {
      return AppColors.selectedField(context);
    }

    if ((y > 2 && y < 6) && (x > 2 && x < 6)) {
      return AppColors.fieldBg1(context);
    }

    if ((y > 2 && y < 6) || (x > 2 && x < 6)) {
      return AppColors.fieldBg2(context);
    }

    return AppColors.fieldBg1(context);
  }

  void _onEdit(int x, int y) => setState(() {
    _selectedField = (x: x, y: y);
  });

  void _onInput(int value) {
    if (_selectedField == null) {
      return;
    }

    setState(() {
      _currentProgress[_selectedField!.y][_selectedField!.x] = value;
      _selectedField = null;
    });

    try {
      if (SudokuUtilities.isSolved(_currentProgress)) {
        widget.onGameWon();
      }
    } on InvalidSudokuConfigurationException {
      logger.i('User entered a wrong number');
    }
  }

  void _onDelete() {
    if (_selectedField == null) {
      return;
    }

    setState(() {
      _currentProgress[_selectedField!.y][_selectedField!.x] = 0;
      _selectedField = null;
    });
  }
}
