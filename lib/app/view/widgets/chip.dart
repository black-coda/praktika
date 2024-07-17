import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    super.key, required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(text,style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white,fontWeight: FontWeight.w400)), padding: const EdgeInsets.all(2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), backgroundColor: const Color(0xff242424),);
  }
}