import 'package:flutter/material.dart';

class AppLifecycleHandler with WidgetsBindingObserver {
  final VoidCallback onAppClosing;

  AppLifecycleHandler({required this.onAppClosing});

  void startObserving() {
    WidgetsBinding.instance.addObserver(this);
  }

  void stopObserving() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      onAppClosing();
    }
  }
}
