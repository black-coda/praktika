// ignore_for_file: unused_local_variable

import 'dart:developer';

extension DurationParsing on String {
  Duration durationFromString() {
    List<String> parts = split(':');
    log(parts.toString());
    if (parts.length != 3) {
      throw const FormatException('Invalid duration format');
    }
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);
    final duration = Duration(hours: hours, minutes: minutes, seconds: seconds);
    return duration;
  }
}

extension DurationFormatter on Duration {
  String toFormattedString({
    bool showHours = true,
    bool showMinutes = true,
    bool showSeconds = true,
    String separator = ':',
  }) {
    final hours = inHours;
    final minutes = inMinutes.remainder(60).abs().toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).abs().toString().padLeft(2, '0');

    final buffer = StringBuffer();
    if (showHours) buffer.write('$hours$separator');
    if (showMinutes) buffer.write('$minutes$separator');
    if (showSeconds) buffer.write(seconds);

    return buffer.toString().trim();
  }
}
