import 'package:intl/intl.dart';

class LeaderboardEntryModel {
  LeaderboardEntryModel({
    required this.timestamp, 
    required this.durationInSeconds, 
    required this.username,
  });

  factory LeaderboardEntryModel.fromJson(Map<String, dynamic> json) => LeaderboardEntryModel(
    timestamp: DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['timestamp']), 
    durationInSeconds: json['duration'], 
    username: json['username'],
  );

  final DateTime timestamp;
  final int durationInSeconds;
  final String username;

  Map<String, dynamic> toJson() => {
    'timestamp': DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp),
    'duration': durationInSeconds,
    'username': username,
  };
}
