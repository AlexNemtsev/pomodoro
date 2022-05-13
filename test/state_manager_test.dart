import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/src/state_manager.dart';

void main() {
  test('State manager should change state when timer finishes', () async {
    StateManager stateManager = StateManager();
    late State actual;
    
    await for (var item in stateManager.stream) {
      actual = item;
      if(actual == State.initState) break;
    }

    expectLater(actual, equals(State.initState));
  });
}
