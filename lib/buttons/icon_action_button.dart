import 'package:flutter/material.dart';
import 'action_button.dart';

class IconActionButton extends StatelessWidget {
  late final _icon;
  final onPressed;
  final color;

  IconActionButton(
      {Key? key,
      required IconData icon,
      required this.color,
      required this.onPressed})
      : super(key: key) {
    _icon = Icon(
      icon,
      size: 30.0,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      onPressed: onPressed,
      child: _icon,
      color: color,
    );
  }
}
