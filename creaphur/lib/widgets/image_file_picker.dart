import 'package:creaphur/widgets/outlined_file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImageFilePicker extends StatelessWidget {
  final Function onFileChange;
  final Widget childWidget;
  final Function()? onRotateImage;
  final IconData icon;
  final bool isFilePicked;

  const ImageFilePicker({
    super.key,
    required this.onFileChange,
    required this.childWidget,
    required this.onRotateImage,
    required this.icon,
    required this.isFilePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: OutlinedFilePicker(
            onChange: onFileChange,
            childWidget: childWidget,
            type: FileType.image),
      ),
      if (isFilePicked) const SizedBox(width: 10),
      if (isFilePicked)
        OutlinedButton(
          onPressed: onRotateImage,
          child: Row(children: [
            const Text('Rotate Image'),
            const SizedBox(width: 10),
            Icon(icon)
          ]),
        )
    ]);
  }
}
