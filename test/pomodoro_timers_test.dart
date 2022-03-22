import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/src/pomodoro_timers.dart';


void main() {
  test('Deserialization without file should return default timers', () async {
    Timers newTimers = await Timers.restoreData();
    Timers expected = new Timers();

    expect(newTimers, equals(expected));
  });

  test('Deserialization from file test', () async {
    Timers original = new Timers(pomodoroTimer: 30, shortBreakTimer: 5, longBreakTimer: 30, description: 'original');
    original.storeData();

    Timers restored = await Timers.restoreData();

    expect(restored, equals(original));
  });
}