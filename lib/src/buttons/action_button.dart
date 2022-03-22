import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {required this.onPressed, required this.color, required this.child});

  final Function onPressed;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        onPressed();
      },
      child: child,
      fillColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: color, width: 1.5),
      ),
      constraints: BoxConstraints(minWidth: 80, minHeight: 40),
    );
  }
}