class Time {
  final int minutes;
  final int seconds;
  late int timeInSeconds;
  Time({
    required this.minutes,
    required this.seconds,
  }) : timeInSeconds = minutes * 60 + seconds;

  factory Time.fromSeconds(int seconds) {
    return Time(minutes: seconds ~/ 60, seconds: seconds % 60);
  }

  Time copyWith({
    int? minutes,
    int? seconds,
  }) {
    return Time(
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
    );
  }

  @override
  String toString() => 'Time(minutes: $minutes, seconds: $seconds)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Time &&
        other.minutes == minutes &&
        other.seconds == seconds;
  }

  @override
  int get hashCode => minutes.hashCode ^ seconds.hashCode;
}