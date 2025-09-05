#!/bin/bash

# Test runner script for SudokuTimer widget tests
# This script can be used to run the tests when Flutter is available

echo "Running SudokuTimer widget tests..."

# Check if Flutter is available
if ! command -v flutter &> /dev/null; then
    echo "Flutter is not installed or not in PATH"
    echo "Please install Flutter and ensure it's in your PATH"
    exit 1
fi

# Run the specific test file for SudokuTimer
flutter test test/game/ui/widgets/timer_test.dart

# Run all tests if specific test passes
if [ $? -eq 0 ]; then
    echo "SudokuTimer tests passed! Running all tests..."
    flutter test
else
    echo "SudokuTimer tests failed!"
    exit 1
fi