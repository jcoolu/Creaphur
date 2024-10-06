import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class OutlinedFilePicker extends StatefulWidget {
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
  State<OutlinedFilePicker> createState() => _OutlinedFilePickerState();
}

class _OutlinedFilePickerState extends State<OutlinedFilePicker> {
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () async {
              if (widget.type == FileType.image) {
                FilePickerResult? result = await FilePicker.platform
                    .pickFiles(type: widget.type, withReadStream: true);

                sleep(Durations.long1);

                if (result != null && widget.type == FileType.image) {
                  File file = File(result.files.single.path!);
                  Uint8List bytes = await file.readAsBytes();
                  widget.onChange('image', base64Encode(bytes));
                  setState(() => errorText = "");
                }
              } else {
                // for csv files only...
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(type: widget.type);
                if (result != null) {
                  PlatformFile file = result.files.first;
                  if (file.extension != 'csv') {
                    // return error to flag that csv was not selected
                    setState(
                        () => errorText = "Error: Please select a .csv file.");
                  } else {
                    File file = File(result.files.single.path!);
                    String data = await file.readAsString();
                    widget.onChange(data);
                    setState(() => errorText = "");
                  }
                }
              }
            },
            child: widget.childWidget,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: Text(errorText, style: const TextStyle(color: Colors.red)),
        )
      ],
    );
  }
}
