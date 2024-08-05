import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const ShimmerText(
    this.text, {
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
     baseColor: const Color(0xffEC704B),
      highlightColor: const Color(0xffF5F378),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
