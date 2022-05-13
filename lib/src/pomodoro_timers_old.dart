import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Timers {
  int pomodoroTimer;
  int shortBreakTimer;
  int longBreakTimer;
  int setSize;
  String description;

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.json');
  }

  Timers({
    this.pomodoroTimer = 25,
    this.longBreakTimer = 25,
    this.shortBreakTimer = 5,
    this.setSize = 3,
    this.description = 'default pomodoro',
  });

  Map<String, dynamic> _toJSON() {
    return <String, dynamic>{
      'pomodoroTimer': pomodoroTimer,
      'shortBreakTimer': shortBreakTimer,
      'longBreakTimer': longBreakTimer,
      'pomosBeforeLongBreak' : setSize,
      'description': description
    };
  }

  Timers._fromJSON (Map<String, dynamic> json)
      : pomodoroTimer = json['pomodoroTimer'],
        shortBreakTimer = json['shortBreakTimer'],
        longBreakTimer = json['longBreakTimer'],
        setSize = json['pomosBeforeLongBreak'],
        description = json['description'];

  static Future<Timers> restoreData() async{
    var file = await _localFile;
    Timers timers;
    try {
      timers = Timers._fromJSON(jsonDecode(await file.readAsString()));
    } catch (e) {
      timers = new Timers();
    }
    return timers;
  }

  Future<File> storeData() async {
    var file = await _localFile;
    var encoder = JsonEncoder.withIndent(' ');
    return file.writeAsString(encoder.convert(this._toJSON()), mode: FileMode.write);
  }

  @override
  String toString() =>
      '$description, $pomodoroTimer/$shortBreakTimer/$longBreakTimer';

  @override
  bool operator == (dynamic otherTimers) =>
      this.toString() == otherTimers.toString();

  @override
  int get hashCode =>
      setSize * 100000 +
      pomodoroTimer * 10000 +
      shortBreakTimer * 100 +
      longBreakTimer;
}
