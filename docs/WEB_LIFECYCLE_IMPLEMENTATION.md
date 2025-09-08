# Web App Lifecycle Management Implementation

This document describes the implementation to prevent full page reloads when users switch back to the browser tab after the app was in the background for a long time.

## Problem

Flutter web apps can be disposed by the browser when memory is needed, especially when the tab has been in the background for extended periods. This results in a full page reload when the user switches back to the tab, losing all application state and current game progress.

## Solution

The implementation uses multiple strategies to preserve application state:

### 1. App Lifecycle Management (`lib/app/ui/app.dart`)

- Implements `WidgetsBindingObserver` to detect app lifecycle changes
- Uses `didChangeAppLifecycleState` to handle app becoming active/inactive
- Reloads settings when app becomes active to ensure consistency

### 2. Web-Specific Page Visibility API (`lib/app/data/services/web_lifecycle_service.dart`)

- Uses conditional exports to provide web-specific implementation
- Listens to browser Page Visibility API events (visibility change, focus, blur)
- Provides a stream of visibility changes for the app to react to
- Gracefully handles initialization errors and provides fallbacks

### 3. Game State Persistence (`lib/app/data/repositories/app_prefs.dart`)

Extended SharedPreferences with game state persistence:
- `saveCurrentGameState()` - Saves current Sudoku board, solution, start time, and difficulty
- `loadCurrentGameState()` - Restores saved game state if available
- `clearCurrentGameState()` - Clears saved state when game is completed
- `hasCurrentGameState()` - Checks if there's a saved game

### 4. Enhanced SudokuCubit (`lib/game/ui/blocs/sudoku/sudoku_cubit.dart`)

Added state management for persistence:
- `restoreGameIfAvailable()` - Tries to restore saved game on app start
- `updateBoard()` - Updates board state and automatically saves to persistence
- `completeGame()` - Clears saved state when game is won
- `saveStateForLifecycleChange()` - Saves current state during app lifecycle changes

### 5. GamePage Lifecycle Management (`lib/game/ui/pages/game_page.dart`)

- Implements `WidgetsBindingObserver` to handle app lifecycle
- Automatically saves game state when app goes to background
- Tries to restore saved game on app initialization
- Shows appropriate loading states during restoration

### 6. Board Change Detection (`lib/game/ui/widgets/board.dart`)

- Added `onBoardChanged` callback to notify when board state changes
- Automatically triggers state saving on every board update
- Ensures real-time persistence of user progress

### 7. Enhanced Web Manifest (`web/manifest.json`)

Improved PWA capabilities:
- Added proper categorization (`games`)
- Enhanced scope and language settings
- Better browser caching behavior

## How It Works

1. **App Initialization**: When the app starts, it tries to restore any saved game state
2. **Real-time Saving**: Every board change is automatically saved to SharedPreferences
3. **Lifecycle Monitoring**: App lifecycle changes trigger state saving
4. **Web Visibility**: Page Visibility API detects tab switching and preserves state
5. **Seamless Restoration**: When returning to the app, saved state is automatically restored

## Benefits

- **No Data Loss**: Current game progress is preserved even during page reloads
- **Seamless UX**: Users can switch tabs and return without losing their place
- **Cross-Platform**: Works on web, mobile, and desktop platforms
- **Automatic**: No user intervention required - everything happens transparently
- **Performance**: Minimal overhead - only saves when state actually changes

## Testing

To test the implementation:

1. Start a new Sudoku game
2. Make some moves on the board
3. Switch to another browser tab for an extended period
4. Return to the Sudoku tab
5. The game should resume exactly where you left off

The implementation handles various scenarios:
- Tab switching
- Browser backgrounding
- Memory pressure situations
- App lifecycle changes on mobile devices