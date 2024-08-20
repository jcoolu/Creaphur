import 'package:flutter/material.dart';

class OutlinedDropdown extends StatelessWidget {
  final dynamic initialValue;
  final void Function(dynamic)? onChange;
  final List<DropdownMenuItem> items;
  final double width;
  final String? labelText;
  final double height;
  final Widget? hint;

  const OutlinedDropdown(
      {super.key,
      this.labelText,
      required this.initialValue,
      required this.onChange,
      required this.items,
      required this.width,
      required this.height,
      this.hint});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            hint: hint,
            value: initialValue,
            items: items,
            onChanged: onChange,
            isExpanded: true, // Ensures the dropdown takes the full width
          ),
        ),
      ),
    );
  }
}
