import 'package:flutter/material.dart';
import 'action_button.dart';

class TextActionButton extends StatelessWidget {
  late final _text;
  final onPressed;
  final color;

  TextActionButton(
      {Key? key,
      required String text,
      required this.color,
      required this.onPressed})
      : super(key: key) {
    _text = Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      onPressed: onPressed,
      color: color,
      child: _text,
    );
  }
}
