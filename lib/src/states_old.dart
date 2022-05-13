import 'package:flutter/material.dart';
import 'buttons_old/buttons.dart';
import 'blocs/controller.dart';

class AppState {
  late String header;
  late List<Widget> buttons;
  // late Controller _controller;
}

class InitialState implements AppState {
  @override
  late List<Widget> buttons;

  @override
  String header = 'Начальное состояние';

  InitialState(this._controller) {
    buttons = [
      StartButton(
        onPressed: () {
          _controller.changeState(_controller.workingState);
          _controller.start();
        },
      ),
    ];
  }

  @override
  Controller _controller;
}

class WorkingState implements AppState {
  @override
  late List<Widget> buttons;

  @override
  late String header;

  WorkingState(this._controller) {
    buttons = [
      PauseButton(
        onPressed: () {
          _controller.changeState(_controller.workingPauseState);
          _controller.pause();
        },
      ),
    ];
    header = 'В работе, ${_controller.counter}-й помо';
  }

  @override
  Controller _controller;
}

class WorkingPauseState implements AppState {
  @override
  late List<Widget> buttons;

  @override
  late String header;

  WorkingPauseState(this._controller) {
    buttons = [
      StartButton(
        onPressed: () {
          _controller.changeState(_controller.workingState);
          _controller.start();
        },
      ),
      StopButton(
        onPressed: () {
          _controller.changeState(_controller.initialState);
          _controller.stop();
        },
      ),
    ];
    header = 'В работе, ${_controller.counter}-й помо';
  }

  @override
  Controller _controller;
}

class BreakingPauseState implements AppState {
  @override
  late List<Widget> buttons;

  @override
  String header = 'Перерыв';

  BreakingPauseState(this._controller) {
    buttons = [
      StartButton(
        onPressed: () {
          _controller.changeState(_controller.breakingState);
          _controller.start();
        },
      ),
      SkipPauseButton(
        onPressed: () {
          _controller.changeState(_controller.workingPauseState);
          _controller.next();
        },
      ),
      StopButton(
        onPressed: () {
          _controller.changeState(_controller.initialState);
          _controller.stop();
        },
      ),
    ];
  }

  @override
  Controller _controller;
}

class BreakingState implements AppState {
  @override
  late List<Widget> buttons;

  @override
  String header = 'Перерыв';

  BreakingState(this._controller) {
    buttons = [
      PauseButton(
        onPressed: () {
          _controller.changeState(_controller.breakingPauseState);
          _controller.pause();
        },
      ),
    ];
  }

  @override
  Controller _controller;
}
