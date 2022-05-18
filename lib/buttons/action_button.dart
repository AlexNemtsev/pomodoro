import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {Key? key,
      required this.onPressed,
      required this.color,
      required this.child})
      : super(key: key);

  final void Function()? onPressed;
  final Widget? child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: color, width: 1.5),
      ),
      constraints: const BoxConstraints(minWidth: 80, minHeight: 40),
      child: child,
    );
  }
}
