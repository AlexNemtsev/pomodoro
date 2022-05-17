import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/buttons/buttons.dart';
import 'package:pomodoro/src/blocs/countdown_manager.dart';

abstract class AppState {
  final StateManager stateManager;
  final List<Widget> buttons;
  final String title;

  AppState({
    required this.stateManager,
    required this.title,
    required this.buttons,
  });
}

class InitialState extends AppState {
  InitialState(StateManager stateManager)
      : super(
            stateManager: stateManager,
            title: 'Начальное состояние',
            buttons: [
              StartButton(
                onPressed: () => stateManager.add(WorkingState(stateManager)),
              )
            ]);
}

class WorkingState extends AppState {
  WorkingState(StateManager stateManager)
      : super(stateManager: stateManager, title: 'В работе', buttons: [
          PauseButton(
            onPressed: () => stateManager.add(WorkingPauseState(stateManager)),
          )
        ]);
}

class WorkingPauseState extends AppState {
  WorkingPauseState(StateManager stateManager)
      : super(stateManager: stateManager, title: 'Пауза', buttons: [
          StartButton(
              onPressed: () => stateManager.add(WorkingState(stateManager))),
          StopButton(
              onPressed: () => stateManager.add(InitialState(stateManager)))
        ]);
}

class StateManager {
  late AppState _state;
  final _countDownManager = CountDownManager();

  final _controller = StreamController<AppState>.broadcast();
  late final Stream<AppState> _stateStream;

  Stream<AppState> get stream => _stateStream;
  AppState get state => _state;

  Stream<Time> get timeStream => _countDownManager.stream;
  Time get time => _countDownManager.state;

  StateManager() {
    // Возможно, это дело можно преобразовывать через transformer
    _stateStream = _controller.stream
        .asyncExpand<AppState>(_mapEventToState)
        .asBroadcastStream();
    _stateStream.listen((event) {});
    add(InitialState(this));
  }

  void add(AppState state) {
    _controller.add(state);
    _state = state;
  }

  Stream<AppState> _mapEventToState(AppState event) async* {
    if (event is InitialState) {
      _countDownManager.reInit();
      yield InitialState(this);
    } else if (event is WorkingState) {
      _countDownManager.start();
      yield WorkingState(this);
    } else if (event is WorkingPauseState) {
      _countDownManager.stop();
      yield WorkingPauseState(this);
    }
  }

  void close() {
    _controller.close();
    _countDownManager.close();
  }
}
