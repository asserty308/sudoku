import 'dart:async';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';

/// Service to handle web-specific lifecycle events using the Page Visibility API
class WebLifecycleService {
  WebLifecycleService._();
  static final WebLifecycleService _instance = WebLifecycleService._();
  static WebLifecycleService get instance => _instance;

  StreamSubscription<html.Event>? _visibilitySubscription;
  StreamSubscription<html.Event>? _focusSubscription;
  StreamSubscription<html.Event>? _blurSubscription;
  final _visibilityController = StreamController<bool>.broadcast();
  
  /// Stream that emits true when page becomes visible, false when hidden
  Stream<bool> get onVisibilityChanged => _visibilityController.stream;

  /// Initialize the web lifecycle service
  void initialize() {
    try {
      // Listen to visibility change events
      _visibilitySubscription = html.document.onVisibilityChange.listen((event) {
        final isVisible = !html.document.hidden!;
        _visibilityController.add(isVisible);
      });

      // Also listen to focus/blur events as backup
      _focusSubscription = html.window.onFocus.listen((event) {
        _visibilityController.add(true);
      });

      _blurSubscription = html.window.onBlur.listen((event) {
        _visibilityController.add(false);
      });
    } catch (e) {
      // Gracefully handle any initialization errors
      debugPrint('WebLifecycleService initialization failed: $e');
    }
  }

  /// Check if the page is currently visible
  bool get isVisible {
    try {
      return !html.document.hidden!;
    } catch (e) {
      return true; // Default to visible if check fails
    }
  }

  /// Dispose of the service
  void dispose() {
    _visibilitySubscription?.cancel();
    _focusSubscription?.cancel();
    _blurSubscription?.cancel();
    _visibilityController.close();
  }
}