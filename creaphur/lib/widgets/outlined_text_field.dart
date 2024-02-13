import 'package:flutter/material.dart';

class OutlinedTextField extends StatelessWidget {
  final String initialValue;
  final String hintText;
  final String labelText;
  final void Function(String)? onChange;
  final String? Function(String?)? onValidate;
  final TextInputType? keyboardType;
  final String? suffix;
  final int? maxLines;

  const OutlinedTextField(
      {super.key,
      required this.initialValue,
      required this.hintText,
      required this.labelText,
      this.onChange,
      this.onValidate,
      this.keyboardType,
      this.suffix,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        labelText: labelText,
        suffixText: suffix,
      ),
      onChanged: onChange,
      validator: onValidate,
      keyboardType: keyboardType,
    );
  }
}
