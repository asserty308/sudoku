# SudokuTimer Widget Test

This directory contains widget tests for the SudokuTimer component.

## Test Structure

### `test/game/ui/widgets/timer_test.dart`

This file contains comprehensive tests for the SudokuTimer widget and the DurationExt extension.

#### SudokuTimer Widget Tests

1. **Initial Display Test**: Verifies that the timer initially displays "00:00 m" when no time has passed.

2. **Timer Callback Test**: Ensures that the `onTimerCreated` callback is properly invoked after the post-frame callback.

3. **Time Update Test**: Validates that the widget correctly updates its display when time passes.

4. **Widget Disposal Test**: Checks that the widget handles disposal correctly without breaking the externally managed timer.

#### DurationExt Tests

1. **Short Duration Format**: Tests the mm:ss format for durations under 1 hour.

2. **Long Duration Format**: Tests the HH:mm:ss format for durations over 1 hour.

3. **Edge Cases**: Validates formatting for zero duration, 1 second, 1 minute, etc.

## Running Tests

To run the tests, use the provided test runner script:

```bash
./test_runner.sh
```

Or run Flutter tests directly:

```bash
# Run specific test file
flutter test test/game/ui/widgets/timer_test.dart

# Run all tests
flutter test
```

## Test Coverage

The tests cover:
- Widget rendering
- Timer lifecycle management
- Duration formatting
- Callback invocation
- Edge cases and error handling

## Dependencies

The tests use:
- `flutter_test` for widget testing
- `dart:async` for Timer functionality
- Standard Flutter testing patterns