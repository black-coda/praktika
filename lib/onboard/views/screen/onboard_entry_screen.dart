import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardEntryScreen extends ConsumerStatefulWidget {
  const OnboardEntryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardEntryScreenState();
}

class _OnboardEntryScreenState extends ConsumerState<OnboardEntryScreen> {

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.blue,
        ),
      ],
    );
  }
}