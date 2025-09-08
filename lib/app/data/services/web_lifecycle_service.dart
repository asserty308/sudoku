// Conditional exports based on platform
export 'web_lifecycle_service_stub.dart'
    if (dart.library.html) 'web_lifecycle_service_web.dart';