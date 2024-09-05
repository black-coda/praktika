import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    required this.title,
    required this.onTap,
    this.textStyle,
    this.iconSize = 24.0,
    this.contentPadding,
    this.isDense,
  });

  final String title;
  final void Function() onTap;
  final TextStyle? textStyle;
  final double iconSize;
  final EdgeInsetsGeometry? contentPadding;
  final bool ? isDense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: textStyle ?? const TextStyle(color: Colors.white),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: iconSize,
      ),
      onTap: onTap,
      contentPadding: contentPadding,
      dense: isDense,
    );
  }
}
