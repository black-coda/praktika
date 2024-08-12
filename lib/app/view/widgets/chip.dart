import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    super.key,
    required this.text,
    this.onTap,
    this.isSelected = false,
  });
  final String text;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isSelected ? const Color(0xff242424) : Colors.white,
                fontWeight: FontWeight.w400)),
        padding: const EdgeInsets.all(2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor:
            !isSelected ? const Color(0xff242424) : const Color(0xffDFDD56),
      ),
    );
  }
}
