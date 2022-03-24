import 'package:flutter/material.dart';
import '../src/constants.dart';

class Display extends StatelessWidget {
  const Display({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerRight,
              width: 150,
              child: const Text(
                '25',
                style: kDisplayTextStyle,
              ),
            ),
            const Text(
              ':',
              style: kDisplayTextStyle,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: 150,
              child: const Text(
                '00',
                style: kDisplayTextStyle,
              ),
            ),
          ],
        ),
        const Text(
          'Pomo: 1',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            fontFamily: 'Encode Sans SC'
          ),
        ),
      ],
    );
  }
}
