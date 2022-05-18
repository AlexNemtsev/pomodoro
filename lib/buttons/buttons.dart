import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'icon_action_button.dart';

class StartButton extends StatelessWidget {
  final void Function()? onPressed;

  const StartButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconActionButton(
      onPressed: onPressed,
      color: const Color(0xFF388E3C),
      icon: LineIcons.play,
    );
  }
}

class PauseButton extends StatelessWidget {
  final void Function()? onPressed;

  const PauseButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconActionButton(
      onPressed: onPressed,
      color: const Color(0xFF388E3C),
      icon: LineIcons.pause,
    );
  }
}

class StopButton extends StatelessWidget {
  final void Function()? onPressed;

  const StopButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconActionButton(
      onPressed: onPressed,
      color: Colors.redAccent,
      icon: LineIcons.stop,
    );
  }
}

class SkipPauseButton extends StatelessWidget {
  final void Function()? onPressed;

  const SkipPauseButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconActionButton(
      onPressed: onPressed,
      color: Colors.orangeAccent,
      icon: LineIcons.fastForward,
    );
  }
}
