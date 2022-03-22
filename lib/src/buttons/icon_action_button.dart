import 'package:flutter/material.dart';
import 'action_button.dart';

class IconActionButton extends StatelessWidget {
  late final Icon _icon;
  final Function onPressed;
  final Color color;

  IconActionButton({required IconData icon, required this.color, required this.onPressed}) {
    _icon = Icon(
        icon,
        size: 30.0,
        color: this.color,
      );
  }

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      onPressed: () {
        onPressed();
      },
      child: _icon,
      color: color,
    );
  }
}

