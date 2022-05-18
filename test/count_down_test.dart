import 'package:pomodoro/src/count_down.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Timer ', () {
    late CountDown timer;
    setUp(() {
      timer = CountDown(3, duration: const Duration(milliseconds: 10));
      timer.start();
    });

    test('should emit [2,1,0] in 3 seconds', () {
      expect(timer.seconds, emitsInOrder([2, 1, 0]));
    });

    test('should emit 0 at the end', () {
      expect(timer.seconds, emitsInOrder([emitsThrough(0), emitsDone]));
    });
  });

  test('Function stop should finish timer and close stream', () {
    final timer = CountDown(3, duration: const Duration(milliseconds: 10));
    final subscriber = timer.seconds;
    timer.start();
    
    subscriber.listen((event) {
      if (event == 1) {
        timer.stop();
      }
    });

    expect(timer.seconds, emitsInOrder([emitsThrough(1), emitsDone]));
  });
}
