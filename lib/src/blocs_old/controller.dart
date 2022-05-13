import 'dart:async';
import '../count_down_old.dart';
import '../pomodoro_timers_old.dart';
import '../states_old.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Controller {
  Controller(this._timers) {
    _initTime = _timers.pomodoroTimer;
    _timer = CountDown(_initTime, this);

    _initialState = InitialState(this);
    _workingState = WorkingState(this);
    _breakingState = BreakingState(this);
    _workingPauseState = WorkingPauseState(this);
    _breakingPauseState = BreakingPauseState(this);
    _appState = initialState;

    _interfaceTransformer = StreamTransformer<AppState, AppState>.fromHandlers(
      handleData: (state, sink) {
        setState(state);
        sink.add(_appState);
      },
    );

    _timerTransformer =
        StreamTransformer<int, Map<String, String>>.fromHandlers(
            handleData: (seconds, sink) {
      int _min = seconds ~/ 60;
      int _sec = seconds % 60;
      
      Map<String, String> time = {
        'min': (_min > 9 ? '$_min' : '0$_min'),
        'sec': (_sec > 9 ? '$_sec' : '0$_sec'),
      };
      sink.add(time);
      if (seconds == 0) {
        // TODO: Добавить вызов уведомления
        player.play('alarm.wav');
        next();
      }
    });

    _percentTransformer = StreamTransformer<int, double>.fromHandlers(
      handleData: (time, sink) {
        sink.add(time / _initTime * 100);
      },
    );
  }
  
  final player = AudioCache();

  late AppState _initialState;
  late AppState _workingState;
  late AppState _breakingState;
  late AppState _workingPauseState;
  late AppState _breakingPauseState;
  late AppState _appState;

  void setState(AppState state) => _appState = state;

  void start() => _timer.start();

  void pause() => _timer.stop();

  void stop() {
    _initTime = _timers.pomodoroTimer;
    _timer = CountDown(_initTime, this);
    _counter = 1;
  }

  void update(Timers timers) {
    _timers = timers;
    _initTime = _timers.pomodoroTimer;
    _timer = CountDown(_initTime, this);
  }

  void next() {
    if (_appState == workingState) {
      changeState(breakingPauseState);
      if (_counter % _timers.setSize == 0) {
        _initTime = _timers.longBreakTimer;
        _timer = CountDown(_initTime, this);
      } else {
        _initTime = _timers.shortBreakTimer;
        _timer = CountDown(_initTime, this);
      }
    } else if (_appState == breakingState || _appState == breakingPauseState) {
      changeState(workingPauseState);
      _initTime = _timers.pomodoroTimer;
      _timer = CountDown(_initTime, this);
      _counter++;
    }
  }

  String get header => _appState.header;
  List<Widget> get buttons => _appState.buttons;

  late StreamTransformer<AppState, AppState> _interfaceTransformer;
  late StreamTransformer<int, Map<String, String>> _timerTransformer;
  late StreamTransformer<int, double> _percentTransformer;
  final _interfaceController = StreamController<AppState>.broadcast();
  final _timerController = StreamController<int>.broadcast();

  late CountDown _timer;
  late Timers _timers;
  int _counter = 1;
  late int _initTime;
  Function(AppState) get changeState => _interfaceController.sink.add;
  Stream<AppState> get newState {
    return _interfaceController.stream.transform(_interfaceTransformer);
  }

  Function(int) get getTime => _timerController.sink.add;
  Stream<Map<String, String>> get timeString =>
      _timerController.stream.transform(_timerTransformer);

  Stream<double> get percent => _timerController.stream.transform(_percentTransformer);

  AppState get initialState => _initialState;
  AppState get workingState => _workingState;
  AppState get breakingState => _breakingState;
  AppState get workingPauseState => _workingPauseState;
  AppState get breakingPauseState => _breakingPauseState;
  AppState get appState => _appState;
  int get counter => _counter;

  dispose() {
    _interfaceController.close();
    _timerController.close();
  }
}
