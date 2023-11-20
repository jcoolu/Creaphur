import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class OutlinedFilePicker extends StatelessWidget {
  final Function onChange;
  final Widget childWidget;

  const OutlinedFilePicker({
    super.key,
    required this.onChange,
    required this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () async {
            FilePickerResult? result =
                await FilePicker.platform.pickFiles(type: FileType.image);

            if (result != null) {
              File file = File(result.files.single.path!);
              Uint8List bytes = await file.readAsBytes();
              onChange('image', base64.encode(bytes));
            }
          },
          child: childWidget,
        ));
  }
}
