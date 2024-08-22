import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({
    super.key,
    required this.formName,
    required this.controller,
  });
  final String formName;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(formName,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                )),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: formName,
            hintStyle: const TextStyle(
              color: Color(0xff6C6C6C),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffF5F378)),
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffF5F378)),
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
