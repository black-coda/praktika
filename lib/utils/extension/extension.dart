import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

extension DurationParsing on String {
  Duration durationFromString() {
    List<String> parts = split(':');

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

// extension for animation in page builder

extension CustomRouteExtension on BuildContext {
  Route createCustomRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

// extension for animation on navigator

extension CustomNavigatorExtension on NavigatorState {
  Future<T?> animateTo<T>(Widget page) {
    return pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}



//? extension to  Check for internet availability
extension DioErrorX on DioException {
  bool get isNoConnectionError =>
      type == DioExceptionType.unknown && error == SocketException;
}