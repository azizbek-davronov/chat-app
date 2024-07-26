import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool hasAsterisk;

  const LoginTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.hasAsterisk = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hasAsterisk,
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        }
      },
      controller: controller,
      decoration:
          InputDecoration(hintText: hintText, border: OutlineInputBorder()),
    );
  }
}
