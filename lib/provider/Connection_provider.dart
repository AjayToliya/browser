import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool isInternet = false;

  void checkInternet() {
    Stream<List<ConnectivityResult>> stream =
        Connectivity().onConnectivityChanged;

    stream.listen((List<ConnectivityResult> res) {
      if (res.contains(ConnectivityResult.mobile) ||
          res.contains(ConnectivityResult.wifi) ||
          res.contains(ConnectivityResult.vpn)) {
        isInternet = true;
      } else {
        isInternet = false;
      }

      notifyListeners();
    });
  }
}
