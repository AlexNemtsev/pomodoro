import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const Pomodoro());
}

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {
      //   MainScreen.id: (context) => MainScreen(timers: timers),
      //   SettingsScreen.id: (context) => SettingsScreen(timers: timers),
      // },
      // initialRoute: MainScreen.id,
      home: const MainScreen(),
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.teal),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(color: Color(0xFF388E3C) ),
          ),
        ),
      ),
    );
  }
}
