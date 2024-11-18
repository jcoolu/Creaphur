import 'dart:convert';
import 'package:flutter/material.dart';

class SummaryImage extends StatelessWidget {
  final String image; // The image string
  final IconData icon; // The fallback icon

  const SummaryImage({
    Key? key,
    required this.image,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image.isEmpty || image == "null"
        ? Icon(icon, color: const Color(0xff2900cc))
        : Image.memory(base64.decode(image));
  }
}
