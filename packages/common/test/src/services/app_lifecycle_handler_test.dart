import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnAppClosing extends Mock {
  void call();
}

void main() {
  late AppLifecycleHandler appLifecycleHandler;
  late MockOnAppClosing mockOnAppClosing;

  setUp(() {
    mockOnAppClosing = MockOnAppClosing();
    appLifecycleHandler = AppLifecycleHandler(onAppClosing: mockOnAppClosing);
  });

  test('Given an app lifecycle, when AppLifecycleState is detached, then calls its callback', () {
    appLifecycleHandler.didChangeAppLifecycleState(AppLifecycleState.detached);

    verify(() => mockOnAppClosing()).called(1);
  });

  test('Given a AppLifecycleStates, when it is not detached, then the callback is never called', () {
    appLifecycleHandler.didChangeAppLifecycleState(AppLifecycleState.resumed);
    appLifecycleHandler.didChangeAppLifecycleState(AppLifecycleState.paused);
    appLifecycleHandler.didChangeAppLifecycleState(AppLifecycleState.inactive);

    verifyNever(() => mockOnAppClosing());
  });
}
