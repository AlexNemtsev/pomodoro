import 'package:pomodoro/src/dataclasses/time_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeDataProvider {
  final sharedPreferences = SharedPreferences.getInstance();

  Future<TimeData> loadValues() async {
    final workingTime = (await sharedPreferences).getInt('workingTime') ?? 25;
    final shortBreakTime =
        (await sharedPreferences).getInt('shortBreakTime') ?? 5;
    final longBreakTime =
        (await sharedPreferences).getInt('longBreakTime') ?? 25;
    final setSize = (await sharedPreferences).getInt('setSize') ?? 3;

    return TimeData(
      workingTime: workingTime,
      shortBreakTime: shortBreakTime,
      longBreakTime: longBreakTime,
      setSize: setSize,
    );
  }

  Future<void> saveValues(TimeData timeData) async {
    (await sharedPreferences).setInt('workingTime', timeData.workingTime);
    (await sharedPreferences).setInt('shortBreakTime', timeData.shortBreakTime);
    (await sharedPreferences).setInt('longBreakTime', timeData.longBreakTime);
    (await sharedPreferences).setInt('setSize', timeData.setSize);
  }
}
