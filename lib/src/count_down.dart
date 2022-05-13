import 'dart:async';

class CountDown {
  int _time;
  final Duration duration;
  late Timer _timer;
  final _seconds = StreamController<int>.broadcast();
  Stream<int> get seconds => _seconds.stream;

  CountDown(this._time, {this.duration = const Duration(seconds: 1)});

  void start() {
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        if (_time == 0) {
          stop();
        } else {
          _time--;
          _seconds.sink.add(_time);
        }
      },
    );
  }

  void stop() {
    _timer.cancel();
    _seconds.close();
  }
}
