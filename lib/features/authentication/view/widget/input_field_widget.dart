import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({
    super.key,
    required this.formName,
    required this.controller,
    this.isPasswordField = false,
    this.validator,
    this.keyboardType,
  });

  final String formName;
  final bool isPasswordField;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formName,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          validator: validator ?? _isNotEmptyValidator,
          controller: controller,
          keyboardType: isPasswordField ? TextInputType.text : keyboardType,
          obscureText: isPasswordField,
          autocorrect: !isPasswordField,
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            errorStyle: const TextStyle(color: Colors.redAccent),
          ),
        ),
      ],
    );
  }

  String? _isNotEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}
