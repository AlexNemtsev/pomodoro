import 'dart:async';

import 'package:pomodoro/src/blocs/app_states.dart';
import 'package:pomodoro/src/blocs/mixin_transformer.dart';
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

class CountDownManager extends Object with AppStateTransformer{
  final Time initState = Time.fromSeconds(25);
  late Time _state;
  late CountDown _countDown;

  final _controller = StreamController<Time>.broadcast();
  final _appStateController = StreamController<AppState>.broadcast();

  Time get state => _state;
  Stream<Time> get stream => _controller.stream;

  CountDownManager(Stream<AppState> appStateStream) {
    _init(initState);
    _appStateController.addStream(appStateStream.transform(transformer));
  }

  void _init(Time initTime) {
    _state = initTime;
    _controller.add(_state);
    _countDown = CountDown(initTime.timeInSeconds, duration: const Duration(milliseconds: 200));
  }

  void reInit() {
    if (_state != initState) {
      _init(initState);
    }
  }

  void start() {
    _countDown.start();

    _countDown.seconds.listen(
      (event) {
        // TODO: Добавить отслеживание окончания работы таймера
        _state = Time.fromSeconds(event);
        _controller.add(_state);
      },
    );
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
