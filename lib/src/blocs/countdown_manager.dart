import 'dart:async';

import 'package:pomodoro/src/blocs/app_states.dart';
import 'package:pomodoro/src/blocs/state_manager.dart';
import 'package:pomodoro/src/count_down.dart';
import 'package:pomodoro/src/dataclasses/time.dart';

class CountDownManager {
  final Time initState = Time.fromSeconds(25);
  late Time _state;
  final StateManager _sm;
  late CountDown _countDown;

  final _controller = StreamController<Time>.broadcast();
  late StreamTransformer<AppState, AppState> transformer;

  Time get state => _state;
  Stream<Time> get stream => _controller.stream;

  CountDownManager(this._sm) {
    _init(initState);

    transformer = StreamTransformer<AppState, AppState>.fromHandlers(
      handleData: _setTransformer,
    );

    final appStateStream = _sm.stream.transform(transformer);
    appStateStream.listen((event) {});
  }

  void _setTransformer(state, sink) {
    if (state is InitialState) {
      _reInit();
    } else if (state is WorkingState) {
      _start();
    } else if (state is WorkingPauseState) {
      _stop();
    }
    // TODO: Добавить обработку оставшихся событий
  }

  void _init(Time initTime) {
    _state = initTime;
    _controller.add(_state);
    _countDown = CountDown(initTime.timeInSeconds,
        duration: const Duration(milliseconds: 200));
  }

  void _reInit() {
    if (_state != initState) {
      _init(initState);
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
      print('timer is finished');
      if (state is WorkingState) {
        _sm.add(BreakingPauseState(_sm));
      } else {
        _sm.add(InitialState(_sm));
      }
      
    }
    _state = Time.fromSeconds(event);
    _controller.add(_state);
  }

  void _stop() {
    _countDown.stop();
    _countDown = CountDown(_state.timeInSeconds);
    _init(_state);
  }

  void close() {
    _controller.close();
    _countDown.stop();
  }
}
