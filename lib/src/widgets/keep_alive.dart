import 'package:flutter/material.dart';
//import 'package:appdlp/src/utils/utils.dart';
import 'package:flutter/services.dart';
import 'dart:async';

const _inactivityTimeout = Duration(seconds: 300);
Timer? _keepAliveTimer;

void _keepAlive(bool visible) {
  _keepAliveTimer?.cancel();
  if (visible) {
    _keepAliveTimer = null;
  } else {
    _keepAliveTimer = Timer(_inactivityTimeout, () {
      SystemNavigator.pop();
    });
  }
}

class _KeepAliveObserver extends WidgetsBindingObserver {
  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _keepAlive(true);
        break;
      case AppLifecycleState.inactive:
        _keepAlive(false); // Conservatively set a timer on all three
        break;
      case AppLifecycleState.paused:
        _keepAlive(false); // Conservatively set a timer on all three
        break;
      case AppLifecycleState.detached:
        _keepAlive(false); // Conservatively set a timer on all three
        break;
    }
  }
}

void startKeepAlive() {
  assert(_keepAliveTimer == null);
  _keepAlive(true);
  WidgetsBinding.instance.addObserver(_KeepAliveObserver());
}
