import 'package:flutter/material.dart';
import 'package:pomodoro/src/blocs/state_manager.dart';

import '../../buttons/buttons.dart';

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
      : super(stateManager: stateManager, title: 'В работе (Пауза)', buttons: [
          StartButton(
              onPressed: () => stateManager.add(WorkingState(stateManager))),
          StopButton(
              onPressed: () => stateManager.add(InitialState(stateManager)))
        ]);
}

class BreakingState extends AppState {
  BreakingState(StateManager stateManager)
      : super(stateManager: stateManager, title: 'Перерыв', buttons: [
          PauseButton(
              onPressed: () =>
                  stateManager.add(BreakingPauseState(stateManager)))
        ]);
}

class BreakingPauseState extends AppState {
  BreakingPauseState(StateManager stateManager)
      : super(stateManager: stateManager, title: 'Перерыв (пауза)', buttons: [
          StartButton(
              onPressed: () => stateManager.add(BreakingState(stateManager))),
          StopButton(
              onPressed: () => stateManager.add(InitialState(stateManager))),
          SkipPauseButton(
              onPressed: () =>
                  stateManager.add(WorkingPauseState(stateManager)))
        ]);
}
