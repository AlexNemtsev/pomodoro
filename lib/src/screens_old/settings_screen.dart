import 'package:flutter/material.dart';
import '../buttons_old/text_action_button.dart';
import '../pomodoro_timers.dart';
import '../constants.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({required this.timers});

  //static String id = 'settings_screen';
  final Timers timers;

  @override
  _SettingsScreenState createState() => _SettingsScreenState(timers: timers);
}

class _SettingsScreenState extends State<SettingsScreen> {
  _SettingsScreenState({required Timers timers}) {
    pomodoroTimer = timers.pomodoroTimer;
    shortBreakTimer = timers.shortBreakTimer;
    longBreakTimer = timers.longBreakTimer;
    pomosBeforeLongBreak = timers.setSize;
  }

  late int pomodoroTimer;
  late int shortBreakTimer;
  late int longBreakTimer;
  late int pomosBeforeLongBreak;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pomodoro duration: $pomodoroTimer'),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                  activeTickMarkColor: Colors.teal,
                ),
                child: Slider(
                  value: pomodoroTimer.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      pomodoroTimer = value.toInt();
                    });
                  },
                  min: 10,
                  max: 60,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text('Short break duration: $shortBreakTimer'),
              Slider(
                value: shortBreakTimer.toDouble(),
                onChanged: (value) {
                  setState(() {
                    shortBreakTimer = value.toInt();
                  });
                },
                min: 1,
                max: 10,
              ),
            ],
          ),
          Column(
            children: [
              Text('Long break duration: $longBreakTimer'),
              Slider(
                value: longBreakTimer.toDouble(),
                onChanged: (value) {
                  setState(() {
                    longBreakTimer = value.toInt();
                  });
                },
                min: 10,
                max: 60,
              ),
            ],
          ),
          Column(
            children: [
              Text('Pomos before long break: $pomosBeforeLongBreak'),
              Slider(
                value: pomosBeforeLongBreak.toDouble(),
                onChanged: (value) {
                  setState(() {
                    pomosBeforeLongBreak = value.toInt();
                  });
                },
                min: 1,
                max: 10,
              ),
            ],
          ),
          TextActionButton(
            onPressed: () {
              Timers newTimers = Timers(
                pomodoroTimer: pomodoroTimer,
                shortBreakTimer: shortBreakTimer,
                longBreakTimer: longBreakTimer,
                setSize: pomosBeforeLongBreak,
              );
              newTimers.storeData();
              Navigator.pop(context, newTimers);
            },
            text: 'Save',
            color: kGreen,
          ),
        ],
      ),
    );
  }
}
