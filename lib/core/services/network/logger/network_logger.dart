import 'package:flutter/foundation.dart';
import 'package:net_kit/net_kit.dart';

/// Implementation of the [INetKitLogger] interface
class NetworkLogger implements INetKitLogger {
  @override
  void trace(String message) {
    debugPrint("TRACE: $message");
  }

  @override
  void debug(String message) {
    debugPrint("DEBUG: $message");
  }

  @override
  void info(String message) {
    debugPrint("INFO: $message");
  }

  @override
  void warning(String message) {
    debugPrint("WARNING: $message");
  }

  @override
  void error(String? message) {
    debugPrint("ERROR: $message");
  }

  @override
  void fatal(String? message) {
    debugPrint("FATAL: $message");
  }
}
