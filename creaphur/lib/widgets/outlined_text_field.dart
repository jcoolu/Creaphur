import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlinedTextField extends StatelessWidget {
  final String initialValue;
  final String hintText;
  final String labelText;
  final void Function(String)? onChange;
  final String? Function(String?)? onValidate;
  final TextInputType? keyboardType;
  final String? suffix;
  final String? prefix;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const OutlinedTextField(
      {super.key,
      required this.initialValue,
      required this.hintText,
      required this.labelText,
      this.onChange,
      this.onValidate,
      this.keyboardType,
      this.suffix,
      this.prefix,
      this.maxLines,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        labelText: labelText,
        suffixText: suffix,
        prefixText: prefix,
      ),
      onChanged: onChange,
      validator: onValidate,
      keyboardType: keyboardType,
    );
  }
}
