import 'package:flutter/material.dart';
import 'package:pomodoro/src/blocs/state_manager.dart';
import 'package:provider/provider.dart';
import '../widgets/display_widget.dart';
import '../widgets/buttons_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sm = context.read<StateManager>();
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: StreamBuilder<AppState>(
              stream: sm.stream,
              initialData: sm.state,
              builder: (context, snapshot) {
                final title = snapshot.data!.title;
                return Text(title);
              },
            ),
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
                  child: DisplayWidget(),
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
    );
  }
}
