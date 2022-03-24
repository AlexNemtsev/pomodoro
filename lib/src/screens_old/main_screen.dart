import 'package:flutter/material.dart';
import 'package:pomodoro/src/states.dart';
import '../pointer.dart';
import 'package:flutter/services.dart';
import 'settings_screen.dart';
import '../pomodoro_timers.dart';
import 'dart:async';
import '../blocs/controller.dart';

class MainScreen extends StatefulWidget {
  static String id = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Timers timers = Timers();
  Future<Timers> future = Timers.restoreData();
  late Controller controller;

  _MainScreenState() {
    future.then((value) {
      setState(() {
        timers = value;
        controller.update(timers);
        // controller = Controller(timers);
      });
    });
    controller = Controller(timers);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: controller.newState,
          initialData: controller.initialState,
          builder: (context, AsyncSnapshot<AppState> snapshot) {
            return Text(snapshot.data!.header.toString());
          },
        ),
        // backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () async {
              final Timers newTimers = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(timers: timers),
                ),
              );
              setState(() {
                timers = newTimers;
                controller.update(timers);
                print('Функция завершена');
              });
            },
            icon: Icon(Icons.settings),
          ),
          SizedBox(width: 10),
        ],
      ),
      // backgroundColor: Color(0xFF00796B),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 10,
              child: Center(
                child: Pointer(
                  timers: timers,
                  controller: controller,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: StreamBuilder(
                stream: controller.newState,
                initialData: controller.initialState,
                builder: (context, AsyncSnapshot<AppState> snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: snapshot.data!.buttons,
                  );
                },
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
