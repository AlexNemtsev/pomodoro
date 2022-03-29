import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/main_screen.dart';
import 'src/state_provider.dart';

void main() {
  runApp(const Pomodoro());
}

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  final _model = StateModel();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StateProvider(
      model: _model,
      child: MaterialApp(
        home: const MainScreen(),
        theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.teal),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(color: Color(0xFF388E3C)),
            ),
          ),
        ),
      ),
    );
  }
}
