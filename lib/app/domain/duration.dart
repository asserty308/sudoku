extension DurationExt on Duration {
  String get format {
    if (inHours > 0) {
      return _formatHMS;
    }

    return _formatMS;
  }

  /// Returns HH:mm:ss
  String get _formatHMS {
    final hours = inHours.toString().padLeft(2, '0');
    final minutes = (inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds h';
  }

  /// Returns mm:ss
  String get _formatMS {
    final minutes = inMinutes.toString().padLeft(2, '0');
    final seconds = (inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds m';
  }
}
