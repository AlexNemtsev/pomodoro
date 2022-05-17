import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro/screens/main_screen.dart';
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
      home: Provider<StateManager>(
        create: (_) => StateManager(),
        dispose: (_, sm) => sm.close,
        child: const MainScreen(),
      ),
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
