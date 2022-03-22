import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'icon_action_button.dart';

class StartButton extends StatelessWidget {
  final Function onPressed;

  StartButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconActionButton(
      onPressed: () {
        onPressed();
      },
      color: Color(0xFF388E3C),
      icon: LineIcons.play,
    );
  }
}

class PauseButton extends StatelessWidget {
  final Function onPressed;

  PauseButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconActionButton(
      onPressed: () {
        onPressed();
      },
      color: Color(0xFF388E3C),
      icon: LineIcons.pause,
    );
  }
}

class StopButton extends StatelessWidget {
  final Function onPressed;

  StopButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconActionButton(
      onPressed: () {
        onPressed();
      },
      color: Colors.redAccent,
      icon: LineIcons.stop,
    );
  }
}

class SkipPauseButton extends StatelessWidget {
  final Function onPressed;

  SkipPauseButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconActionButton(
      onPressed: () {
        onPressed();
      },
      color: Colors.orangeAccent,
      icon: LineIcons.fastForward,
    );
  }
}
