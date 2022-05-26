import 'dart:async';

import 'package:pomodoro/src/blocs/app_states.dart';
import 'package:pomodoro/src/blocs/state_manager.dart';
import 'package:pomodoro/src/count_down.dart';
import 'package:pomodoro/src/dataclasses/time.dart';

class CountDownManager {
  final workingTime = Time.fromSeconds(25);
  final breakingTime = Time.fromSeconds(25);

  late Time _state;
  final StateManager _sm;
  late CountDown _countDown;

  final _controller = StreamController<Time>.broadcast();
  late StreamTransformer<AppState, AppState> transformer;

  Time get state => _state;
  Stream<Time> get stream => _controller.stream;

  CountDownManager(this._sm) {
    _init(workingTime);

    transformer = StreamTransformer<AppState, AppState>.fromHandlers(
      handleData: _setTransformer,
    );

    final appStateStream = _sm.stream.transform(transformer);
    appStateStream.listen((event) {});
  }

  void _setTransformer(state, sink) {
    if (state is InitialState) {
      _reInit(workingTime);
    } else if (state is WorkingState) {
      _start();
    } else if (state is WorkingPauseState) {
      _countDown.stop();
      _init(_state == Time.fromSeconds(0)? workingTime : _state);
    } else if (state is BreakingPauseState) {
      _countDown.stop();
      _init(_state == Time.fromSeconds(0)? breakingTime : _state);
    } else if (state is BreakingState) {
      _start();
    }
  }

  void _init(Time initTime) {
    _state = initTime;
    _controller.add(_state);
    _countDown = CountDown(initTime.timeInSeconds,
        duration: const Duration(milliseconds: 200));
  }

  void _reInit(Time state) {
    if (_state != state) {
      _init(state);
    }
  }

  void _start() {
    _countDown.start();

    _countDown.seconds.listen(
      _finishCheck,
    );
  }

  void _finishCheck(int event) {
    final state = _sm.state;
    if (event == 0) {
      if (state is WorkingState) {
        _sm.add(BreakingPauseState(_sm));
      } else {
        _sm.add(WorkingPauseState(_sm));
      }
    }
    _state = Time.fromSeconds(event);
    _controller.add(_state);
  }

  void close() {
    _controller.close();
    _countDown.stop();
  }
}
