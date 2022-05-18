import 'package:flutter/material.dart';
import 'package:pomodoro/src/blocs/state_manager.dart';
import 'package:provider/provider.dart';

import '../src/blocs/app_states.dart';

class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sm = context.read<StateManager>();
    return StreamBuilder<AppState>(
      stream: sm.stream,
      initialData: sm.state,
      builder: (context, snapshot) {
        final buttons = snapshot.data!.buttons;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buttons,
        );
      },
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: buttons,
    // );
  }
}
