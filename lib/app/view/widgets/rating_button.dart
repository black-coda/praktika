import 'package:flutter/material.dart';

class ChipElevatedBtn extends StatelessWidget {
  const ChipElevatedBtn({
    super.key,
    required this.index,
    required this.ratings,
    this.isDurationField = false,
  });

  final int index;
  final String ratings;
  final bool isDurationField;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: isDurationField
          ? const SizedBox()
          : Icon(Icons.star_border_outlined,
              size: 16,
              color: (index % 3 == 0)
                  ? const Color(0xffEC704B)
                  : (index % 3 == 1)
                      ? const Color(0xffF5F378)
                      : const Color(0xffDCC1FF)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff2F2F2F),
        // backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      label: Text(ratings,
          style: TextStyle(
              fontSize: isDurationField
                  ? 10
                  : Theme.of(context).textTheme.labelSmall!.fontSize,
              color: (index % 3 == 0)
                  ? const Color(0xffEC704B)
                  : (index % 3 == 1)
                      ? const Color(0xffF5F378)
                      : const Color(0xffDCC1FF))),
    );
  }
}
