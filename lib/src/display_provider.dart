import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayModel extends ChangeNotifier {
  int pomoTime = 25;
  int longBreakTime = 25;
  int shortBreakTime = 5;
  int setSize = 3;

  static const _kPomoTime = 'Pomo_time';
  static const _kLongBreakTime = 'Long_break_time';
  static const _kShortBreakTime = 'Short_break_time';
  static const _kSetSize = 'Set_size';

  Future<void> loadData() async {
    final prefs = SharedPreferences.getInstance();
    pomoTime = (await prefs).getInt(_kPomoTime) ?? 25;
    longBreakTime = (await prefs).getInt(_kLongBreakTime) ?? 25;
    shortBreakTime = (await prefs).getInt(_kShortBreakTime) ?? 5;
    setSize = (await prefs).getInt(_kSetSize) ?? 3;
  }

  DisplayModel() {
    loadData();
    notifyListeners();
  }
}

class StateProvider extends InheritedNotifier<DisplayModel> {
  const StateProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child, notifier: model);

  final DisplayModel model;

  static DisplayModel? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StateProvider>()?.model;
  }
}
