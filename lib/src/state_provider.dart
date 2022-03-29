import 'package:flutter/material.dart';
import 'package:pomodoro/buttons/buttons.dart';

class StateModel extends ChangeNotifier {
  List<Widget>? _buttons;
  Text _title = const Text('Начальное состояние');

  void toWorkingPauseState() {
    _buttons = [
      StartButton(onPressed: toWorkingState),
      StopButton(onPressed: toInitialState)
    ];
    _title = const Text('В работе');
    notifyListeners();
  }

  void toWorkingState() {
    _buttons = [PauseButton(onPressed: toWorkingPauseState)];
    _title = const Text('В работе');
    notifyListeners();
  }

  void toInitialState() {
    _buttons = [StartButton(onPressed: toWorkingState)];
    _title = const Text('Начальное состояние');
    notifyListeners();
  }

  void toBreakingState() {
    _buttons = [PauseButton(onPressed: toBreakingPauseState)];
    _title = const Text('Перерыв');
    notifyListeners();
  }

  void toBreakingPauseState() {
    _buttons = [
      StartButton(onPressed: toBreakingState),
      SkipPauseButton(onPressed: toWorkingPauseState),
      StopButton(onPressed: toInitialState)
    ];
    _title = const Text('Перерыв');
    notifyListeners();
  }
}

class StateProvider extends InheritedNotifier<StateModel> {
  const StateProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child, notifier: model);

  final StateModel model;

  static StateModel? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StateProvider>()?.model;
  }

  static List<Widget>? getButtons(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StateProvider>()?.model._buttons;
  }

  static Text? getTitle(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StateProvider>()?.model._title;
  }
}