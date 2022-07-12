import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionState {
  static Future<InternetConnected> checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.wifi) {
      return InternetConnected.connected;
    } else {
      return InternetConnected.notConnected;
    }
  }
}

enum InternetConnected {
  connected,
  notConnected,
}
