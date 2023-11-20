import 'package:flutter/material.dart';

class FilledFloatingActionButton extends StatelessWidget {
  final void Function()? onPressed;

  const FilledFloatingActionButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: const Color(0xff2bca70),
      splashColor: const Color(0xff1d874b),
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
    );
  }
}
