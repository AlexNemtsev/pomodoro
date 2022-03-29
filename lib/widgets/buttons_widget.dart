import 'package:flutter/material.dart';
import 'package:pomodoro/src/state_provider.dart';
import '../buttons/buttons.dart';

class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = StateProvider.getButtons(context) ??
        [StartButton(onPressed: StateProvider.of(context)?.toWorkingState)];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }
}
