import 'package:intl/intl.dart';

class LeaderboardEntryModel({
    required final DateTime timestamp,
    required final int durationInSeconds,
    required final String username,
  }) {
  factory fromJson(Map<String, dynamic> json) => LeaderboardEntryModel(
    timestamp: DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['timestamp']),
    durationInSeconds: json['duration'],
    username: json['username'],
  );

  Map<String, dynamic> toJson() => {
    'timestamp': DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp),
    'duration': durationInSeconds,
    'username': username,
  };

  String get formattedDuration {
    final duration = Duration(seconds: durationInSeconds);
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }
}
