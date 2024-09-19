import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class OutlinedFilePicker extends StatelessWidget {
  final Function onChange;
  final Widget childWidget;
  final FileType type;

  const OutlinedFilePicker({
    super.key,
    required this.onChange,
    required this.childWidget,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () async {
            if (type != FileType.custom) {
              FilePickerResult? result =
                  await FilePicker.platform.pickFiles(type: type);

              if (result != null && type == FileType.image) {
                File file = File(result.files.single.path!);
                Uint8List bytes = await file.readAsBytes();
                onChange('image', base64.encode(bytes));
              }
            } else {
              FilePickerResult? result = await FilePicker.platform
                  .pickFiles(type: type, allowedExtensions: ['txt', 'csv']);
              if (result != null) {
                File file = File(result.files.single.path!);
                String data = await file.readAsString();
                onChange(data);
              }
            }
          },
          child: childWidget,
        ));
  }
}
