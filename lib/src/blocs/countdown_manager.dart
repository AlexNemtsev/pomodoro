import 'dart:async';

import 'package:pomodoro/src/count_down.dart';

class CountDownManager {
  final int _initState = 25;
  late int _state;
  late CountDown _countDown;

  late Stream<int> _subscriber;

  final _controller = StreamController<int>.broadcast();

  int get state => _state;
  Stream<int> get stream => _controller.stream;

  CountDownManager() {
    init(_initState);
  }

  void init(int state) {
    _state = state;
    _controller.add(_state);
    _countDown = CountDown(_state);
  }

  void start() {
    _subscriber = _countDown.seconds;
    _countDown.start();

    _subscriber.listen((event) { 
      // TODO: Добавить отслеживание окончания работы таймера
      _state = event;
      _controller.add(event);
    });
  }

  void stop() {
    _countDown.stop();
    _countDown = CountDown(_state);
    init(_state);
  }

  void close() => _controller.close();
}