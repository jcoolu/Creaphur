import 'package:flutter/material.dart';

class FilledActionButton extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;

  const FilledActionButton({
    super.key,
    this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2bca70)),
      child: Text(buttonText, style: const TextStyle(color: Colors.white)),
    );
  }
}
