import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sudoku/app/domain/duration.dart';

class SudokuTimer extends StatefulWidget {
  const SudokuTimer({
    super.key, 
    required this.startTime,
    required this.onTimerCreated,
  });

  final DateTime startTime;
  final void Function(Timer timer) onTimerCreated;

  @override
  State<SudokuTimer> createState() => _SudokuTimerState();
}

class _SudokuTimerState extends State<SudokuTimer> {
  var _duration = Duration.zero;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) {
          return;
        }

        setState(() {
          _duration = DateTime.now().difference(widget.startTime);
        });
      });

      widget.onTimerCreated(timer);
    });
  }

  @override
  Widget build(BuildContext context) => Text(_duration.format);
}
