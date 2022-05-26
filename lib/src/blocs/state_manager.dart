import 'dart:async';

import 'package:pomodoro/src/blocs/countdown_manager.dart';

import '../dataclasses/time.dart';
import 'app_states.dart';



class StateManager {
  late AppState _state;
  late final CountDownManager countDownManager;

  final _controller = StreamController<AppState>.broadcast();

  Stream<AppState> get stream => _controller.stream;
  AppState get state => _state;

  Stream<Time> get timeStream => countDownManager.stream;
  Time get time => countDownManager.state;

  StateManager() {
    countDownManager = CountDownManager(this);
    add(InitialState(this));
  }

  void add(AppState state) {
    _controller.add(state);
    _state = state;
  }

  void close() {
    _controller.close();
    countDownManager.close();
  }
}
