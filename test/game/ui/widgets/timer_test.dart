import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/features/game/ui/widgets/timer.dart';

void main() {
  group('SudokuTimer Widget Tests', () {
    testWidgets('calls onTimerCreated callback after post-frame callback', (
      WidgetTester tester,
    ) async {
      Timer? capturedTimer;
      final startTime = DateTime.now();

      await tester.pumpWidget(
        MaterialApp(
          home: SudokuTimer(
            startTime: startTime,
            onTimerCreated: (timer) {
              capturedTimer = timer;
            },
          ),
        ),
      );

      // Trigger post-frame callback
      await tester.pumpAndSettle();

      // Verify that the timer was created and callback was called
      expect(capturedTimer, isNotNull);
      expect(capturedTimer!.isActive, isTrue);

      // Clean up
      capturedTimer?.cancel();
    });
  });

  group('DurationExt Tests', () {
    test('formats duration under 1 hour as mm:ss m', () {
      const duration30Seconds = Duration(seconds: 30);
      expect(duration30Seconds.format(), equals('00:30 m'));

      const duration2Minutes30Seconds = Duration(minutes: 2, seconds: 30);
      expect(duration2Minutes30Seconds.format(), equals('02:30 m'));

      const duration59Minutes59Seconds = Duration(minutes: 59, seconds: 59);
      expect(duration59Minutes59Seconds.format(), equals('59:59 m'));
    });

    test('formats duration over 1 hour as HH:mm:ss h', () {
      const duration1Hour = Duration(hours: 1);
      expect(duration1Hour.format(), equals('01:00:00 h'));

      const duration1Hour30Minutes45Seconds = Duration(
        hours: 1,
        minutes: 30,
        seconds: 45,
      );
      expect(duration1Hour30Minutes45Seconds.format(), equals('01:30:45 h'));

      const duration10Hours5Minutes30Seconds = Duration(
        hours: 10,
        minutes: 5,
        seconds: 30,
      );
      expect(duration10Hours5Minutes30Seconds.format(), equals('10:05:30 h'));
    });

    test('formats edge cases correctly', () {
      const durationZero = Duration.zero;
      expect(durationZero.format(), equals('00:00 m'));

      const duration1Second = Duration(seconds: 1);
      expect(duration1Second.format(), equals('00:01 m'));

      const duration1Minute = Duration(minutes: 1);
      expect(duration1Minute.format(), equals('01:00 m'));
    });
  });
}
