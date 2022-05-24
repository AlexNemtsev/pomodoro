import 'dart:async';

import 'package:pomodoro/src/blocs/app_states.dart';
import 'package:pomodoro/src/blocs/state_manager.dart';
import 'package:pomodoro/src/count_down.dart';

class Time {
  final int minutes;
  final int seconds;
  late int timeInSeconds;
  Time({
    required this.minutes,
    required this.seconds,
  }) : timeInSeconds = minutes * 60 + seconds;

  factory Time.fromSeconds(int seconds) {
    return Time(minutes: seconds ~/ 60, seconds: seconds % 60);
  }

  Time copyWith({
    int? minutes,
    int? seconds,
  }) {
    return Time(
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
    );
  }

  @override
  String toString() => 'Time(minutes: $minutes, seconds: $seconds)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Time &&
        other.minutes == minutes &&
        other.seconds == seconds;
  }

  @override
  int get hashCode => minutes.hashCode ^ seconds.hashCode;
}

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
      reInit();
    } else if (state is WorkingState) {
      start();
    } else if (state is WorkingPauseState) {
      stop();
    }
  }

  void _init(Time initTime) {
    _state = initTime;
    _controller.add(_state);
    _countDown = CountDown(initTime.timeInSeconds,
        duration: const Duration(milliseconds: 200));
  }

  void reInit() {
    if (_state != initState) {
      _init(initState);
    }
  }

  void start() {
    _countDown.start();

    _countDown.seconds.listen(
      _finishCheck,
    );
  }

  void _finishCheck(int event) {
    if (event == 0) {
      print('timer is finished');
      _sm.add(InitialState(_sm));
    }
    // TODO: Добавить отслеживание окончания работы таймера
    _state = Time.fromSeconds(event);
    _controller.add(_state);
  }

  void stop() {
    _countDown.stop();
    _countDown = CountDown(_state.timeInSeconds);
    _init(_state);
  }

  void close() {
    _controller.close();
    _countDown.stop();
  }
}
