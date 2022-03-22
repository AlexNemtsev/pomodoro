import 'package:flutter/material.dart';
import 'src/screens/main_screen.dart';

void main() {
  runApp(Pomodoro());
}

class Pomodoro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {
      //   MainScreen.id: (context) => MainScreen(timers: timers),
      //   SettingsScreen.id: (context) => SettingsScreen(timers: timers),
      // },
      // initialRoute: MainScreen.id,
      home: MainScreen(),
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(backgroundColor: Colors.teal),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(color: Color(0xFF388E3C) ),
          ),
        ),
      ),
    );
  }
}
