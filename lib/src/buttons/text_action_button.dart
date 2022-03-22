import 'package:flutter/material.dart';
import 'action_button.dart';

class TextActionButton extends StatelessWidget {
  late final Text _text;
  final Function onPressed;
  final Color color;

  TextActionButton(
      {required String text, required this.color, required this.onPressed}) {
    _text = Text(text,
        style: TextStyle(
          color: color,
          fontSize: 20,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      onPressed: () {
        onPressed();
      },
      color: color,
      child: _text,
    );
  }
}
