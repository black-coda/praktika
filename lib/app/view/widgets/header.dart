import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget(
    this.title, {
    super.key,
    this.style,
  });
  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style ?? Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
      textAlign: TextAlign.center,
    );
  }
}
