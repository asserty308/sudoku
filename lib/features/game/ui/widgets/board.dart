import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:sudoku/core/theme/colors.dart';
import 'package:sudoku/features/game/data/models/sudoku_model.dart';
import 'package:sudoku/features/game/domain/use_cases/handle_keyboad_input_use_case.dart';
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
  bool _forbidMode = false;
  late List<List<Set<int>>> _forbiddenMarks;

  final _focusNode = FocusNode();
  final handleKeyboadInputUseCase = HandleKeyboadInputUseCase();

  static List<List<Set<int>>> _emptyForbiddenGrid() =>
      List.generate(9, (_) => List.generate(9, (_) => <int>{}));

  @override
  void initState() {
    super.initState();

    // Use a copy of the initial board to keep the initial state
    _currentProgress = widget.model.boardCopy;
    _forbiddenMarks = _emptyForbiddenGrid();
  }

  @override
  void didUpdateWidget(SudokuBoard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reset the board when a new model is provided
    if (oldWidget.model != widget.model) {
      _currentProgress = widget.model.boardCopy;
      _selectedField = null; // Clear any selected field
      _forbidMode = false;
      _forbiddenMarks = _emptyForbiddenGrid();
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
        return .handled;
      } else if (enterValue == -1) {
        _onDelete();
        return .handled;
      }

      return .ignored;
    },
    child: _board,
  );

  Widget get _board {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.12),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: scheme.outline.withValues(alpha: 0.45), width: 1.5),
                color: scheme.surfaceContainerLow,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(9, _row),
              ),
            ),
          ),
        ),
        if (_selectedField != null)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: _inputPanelFitted,
          ),
      ],
    );
  }

  Widget _row(int y) =>
      Row(mainAxisSize: MainAxisSize.min, children: List.generate(9, (x) => _tile(x, y)));

  Widget _tile(int x, int y) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final editable = widget.model.board[y][x] == 0;
    final item = _currentProgress[y][x];
    final forbidden = _forbiddenMarks[y][x];
    final isClue = widget.model.board[y][x] != 0;

    final line = scheme.outlineVariant.withValues(alpha: 0.65);
    final blockLine = scheme.outline;

    return Container(
      width: _buttonSize,
      height: _buttonSize,
      decoration: BoxDecoration(
        color: _tileColor(x, y),
        border: Border(
          right: x < 8
              ? BorderSide(
                  color: (x == 2 || x == 5) ? blockLine : line,
                  width: (x == 2 || x == 5) ? 2.5 : 1,
                )
              : BorderSide.none,
          bottom: y < 8
              ? BorderSide(
                  color: (y == 2 || y == 5) ? blockLine : line,
                  width: (y == 2 || y == 5) ? 2.5 : 1,
                )
              : BorderSide.none,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: editable ? () => _onEdit(x, y) : null,
          splashColor: scheme.primary.withValues(alpha: 0.14),
          highlightColor: scheme.primary.withValues(alpha: 0.06),
          child: Center(
            child: item != 0
                ? Text(
                    '$item',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 22,
                      fontWeight: isClue ? FontWeight.w800 : FontWeight.w600,
                      height: 1,
                      color: isClue ? scheme.onSurface : scheme.primary,
                    ),
                  )
                : forbidden.isEmpty
                ? const SizedBox.shrink()
                : _forbiddenPencilGrid(forbidden, scheme),
          ),
        ),
      ),
    );
  }

  Widget _forbiddenPencilGrid(Set<int> forbidden, ColorScheme scheme) {
    final err = scheme.error;
    return SizedBox(
      width: _buttonSize * 0.88,
      height: _buttonSize * 0.88,
      child: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(9, (i) {
          final n = i + 1;
          if (!forbidden.contains(n)) {
            return const SizedBox.shrink();
          }
          return Center(
            child: Text(
              '$n',
              style: TextStyle(
                fontSize: _buttonSize < 42 ? 8.5 : 10,
                height: 1,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.lineThrough,
                decorationThickness: 1.4,
                color: err,
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Keeps the digit bar within screen width on narrow devices (avoids right overflow).
  Widget get _inputPanelFitted {
    final maxW = math.max(0.0, context.mediaSize.width - 24);
    return SizedBox(
      width: maxW,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: _inputPanel,
      ),
    );
  }

  Widget get _inputPanel {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerHighest,
      elevation: 2,
      shadowColor: scheme.shadow.withValues(alpha: 0.2),
      borderRadius: const BorderRadius.all(Radius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(9, _inputButton),
            const SizedBox(width: 10),
            Container(
              width: 1,
              height: _buttonSize * 0.72,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(1)),
                color: scheme.outlineVariant.withValues(alpha: 0.55),
              ),
            ),
            const SizedBox(width: 10),
            _forbidToggleButton,
            const SizedBox(width: 6),
            _deleteButton,
          ],
        ),
      ),
    );
  }

  Widget _inputButton(int index) {
    final value = index + 1;
    final scheme = Theme.of(context).colorScheme;
    final selected = _selectedField;
    final isForbidden =
        _forbidMode &&
        selected != null &&
        _forbiddenMarks[selected.y][selected.x].contains(value);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: scheme.surfaceContainer,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: InkWell(
          onTap: () => _onInput(value),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          splashColor: scheme.primary.withValues(alpha: 0.12),
          child: SizedBox(
            width: _buttonSize,
            height: _buttonSize,
            child: Center(
              child: Text(
                '$value',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                  decoration: isForbidden ? TextDecoration.lineThrough : null,
                  decorationThickness: isForbidden ? 2.2 : null,
                  decorationColor: scheme.error,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _forbidToggleButton {
    final scheme = Theme.of(context).colorScheme;
    final active = _forbidMode;
    return Material(
      color: active ? scheme.errorContainer : scheme.surfaceContainer,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: InkWell(
        onTap: () => setState(() => _forbidMode = !_forbidMode),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        splashColor: scheme.error.withValues(alpha: 0.12),
        child: SizedBox(
          width: _buttonSize,
          height: _buttonSize,
          child: Icon(
            Icons.do_not_disturb_on_outlined,
            size: 22,
            color: active ? scheme.onErrorContainer : scheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget get _deleteButton {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainer,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: InkWell(
        onTap: _onDelete,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        splashColor: scheme.primary.withValues(alpha: 0.12),
        child: SizedBox(
          width: _buttonSize,
          height: _buttonSize,
          child: Icon(
            Icons.backspace_outlined,
            size: 21,
            color: scheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  double get _buttonSize {
    final mq = context.mediaSize;
    final shortestSide = mq.shortestSide;
    final base = shortestSide < 500 ? 38.0 : 50.0;
    final maxFromWidth = (mq.width - 24) / 9;
    return math.min(base, maxFromWidth).clamp(26.0, 50.0);
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
    final field = _selectedField;
    if (field == null) {
      return;
    }

    if (_forbidMode) {
      setState(() {
        final set = _forbiddenMarks[field.y][field.x];
        if (set.contains(value)) {
          set.remove(value);
        } else {
          set.add(value);
        }
      });
      return;
    }

    setState(() {
      _currentProgress[field.y][field.x] = value;
      _forbiddenMarks[field.y][field.x].clear();
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
    final field = _selectedField;
    if (field == null) {
      return;
    }

    if (_forbidMode) {
      setState(() {
        _forbiddenMarks[field.y][field.x].clear();
      });
      return;
    }

    setState(() {
      _currentProgress[field.y][field.x] = 0;
      _selectedField = null;
    });
  }
}
