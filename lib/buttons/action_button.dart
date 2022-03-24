import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {Key? key,
      required this.onPressed,
      required this.color,
      required this.child})
      : super(key: key);

  final onPressed;
  final child;
  final color;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: child,
      fillColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: color, width: 1.5),
      ),
      constraints: const BoxConstraints(minWidth: 80, minHeight: 40),
    );
  }
}
