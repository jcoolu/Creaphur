import 'package:flutter/material.dart';

class OutlinedTextField extends StatelessWidget {
  final String initialValue;
  final String hintText;
  final String labelText;
  final void Function(String)? onChange;
  final String? Function(String?)? onValidate;
  final TextInputType? keyboardType;

  const OutlinedTextField(
      {super.key,
      required this.initialValue,
      required this.hintText,
      required this.labelText,
      this.onChange,
      this.onValidate,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        labelText: labelText,
      ),
      onChanged: onChange,
      validator: onValidate,
      keyboardType: keyboardType,
    );
  }
}