import 'dart:async';

import 'package:pomodoro/src/blocs_old/controller.dart';


// TODO: Переделать этот класс в InheritedWidget
// Возможно, т.к. время тут задаётся из другого виджета, возможно, потребуется InheritedModel
class CountDown {
  late int _time;
  late Timer _timer;
  final _seconds = StreamController<int>.broadcast();
  Stream<int> get seconds => _seconds.stream;
  late Controller controller;

  CountDown(int minutes, this.controller) {
    _time = minutes;
    controller.getTime(_time);
  }

  void start() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_time == 0) {
          stop();
        } else {
          _time--;
          controller.getTime(_time);
        }
      },
    );
  }

  void stop() {
    _timer.cancel();
  }

  void dispose() {
    stop();
    _seconds.close();
  }
}
