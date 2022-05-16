import 'package:flutter/material.dart';
import 'package:pomodoro/src/blocs/countdown_manager.dart';
import 'package:provider/provider.dart';
import '../src/constants.dart';

class Display extends StatelessWidget {
  const Display({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cdm = context.read<CountDownManager>();
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
          stream: cdm.stream,
          initialData: cdm.state,
          builder: (context, snapshot){
            final seconds = snapshot.data!.seconds;
            return Text(
                '$seconds',
                style: kDisplayTextStyle,
              );
          },
        ),
              // child: const Text(
              //   '25',
              //   style: kDisplayTextStyle,
              // ),
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
