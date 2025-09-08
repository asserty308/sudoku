import 'dart:async';
import 'package:flutter/foundation.dart';

/// Service to handle web-specific lifecycle events using the Page Visibility API
class WebLifecycleService {
  WebLifecycleService._();
  static final WebLifecycleService _instance = WebLifecycleService._();
  static WebLifecycleService get instance => _instance;

  final _visibilityController = StreamController<bool>.broadcast();
  
  /// Stream that emits true when page becomes visible, false when hidden
  Stream<bool> get onVisibilityChanged => _visibilityController.stream;

  /// Initialize the web lifecycle service (stub for non-web platforms)
  void initialize() {
    // No-op for non-web platforms
  }

  /// Check if the page is currently visible (always true for non-web)
  bool get isVisible => true;

  /// Dispose of the service
  void dispose() {
    _visibilityController.close();
  }
}