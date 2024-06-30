import 'dart:async';

import 'package:flutter/services.dart';

class ConnectivityChannel {
  static const MethodChannel _channel = MethodChannel('connectivity_channel');

  static final StreamController<bool> _connectionStatusController =
      StreamController<bool>.broadcast();

  static Stream<bool> get connectionStatusStream =>
      _connectionStatusController.stream;

  static void initialize() {
    _channel.setMethodCallHandler((MethodCall call) async {
      if (call.method == 'updateConnectionStatus') {
        final bool isConnected = call.arguments;
        _connectionStatusController.add(isConnected);
      }
    });
  }

  static void dispose() {
    _connectionStatusController.close();
  }
}
