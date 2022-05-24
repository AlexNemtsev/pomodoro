import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../src/blocs/state_manager.dart';
import '../src/constants.dart';
import '../src/dataclasses/time.dart';

class DisplayWidget extends StatelessWidget {
  const DisplayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sm = context.read<StateManager>();
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
              child: StreamBuilder<Time>(
                stream: sm.timeStream,
                initialData: sm.time,
                builder: (context, snapshot) {
                  final seconds = snapshot.data?.seconds;
                  return Text(
                    '$seconds',
                    style: displayTextStyle,
                  );
                },
              ),
            ),
            const Text(
              ':',
              style: displayTextStyle,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: 150,
              child: const Text(
                '00',
                style: displayTextStyle,
              ),
            ),
          ],
        ),
        const Text(
          'Pomo: 1',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              fontFamily: 'Encode Sans SC'),
        ),
      ],
    );
  }
}
