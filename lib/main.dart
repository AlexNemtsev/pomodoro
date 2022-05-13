import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro/screens/main_screen.dart';
import 'package:pomodoro/src/blocs/countdown_manager.dart';
import 'package:provider/provider.dart';
import 'src/blocs/state_manager.dart';

void main() {
  runApp(const Pomodoro());
}

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      home: MultiProvider(
        providers: [
          Provider<CountDownManager>(
            create: (_) => CountDownManager(),
            dispose: (_, cdm) => cdm.close,
          ),
          ProxyProvider<CountDownManager, StateManager>(
            update: (_, cdm, __) => StateManager(cdm),
            dispose: (_, sm) => sm.close,
          ),
        ],
        // builder: (context, child) => const MainScreen().build(context),
        child: const MainScreen(),
      ),
      // home: BlocProvider(
      //   create: (context) => StateManager(),
      //   child: const MainScreen(),
      // ),
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.teal),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(color: Color(0xFF388E3C)),
          ),
        ),
      ),
    );
  }
}
