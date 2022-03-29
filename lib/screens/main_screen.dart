import 'package:flutter/material.dart';
import 'package:pomodoro/src/state_provider.dart';
import '../widgets/display.dart';
import '../widgets/buttons_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StateProvider.getTitle(context),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 10,
              child: Display(),
            ),
            const Expanded(
              flex: 3,
              child: ButtonsWidget(),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
