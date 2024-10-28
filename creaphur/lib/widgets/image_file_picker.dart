import 'dart:convert';

import 'package:creaphur/widgets/outlined_file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageFilePicker extends StatelessWidget {
  final Function onFileChange;
  final Function()? onRotateImage;
  final IconData icon;
  final bool isFilePicked;

  const ImageFilePicker({
    super.key,
    required this.onFileChange,
    required this.onRotateImage,
    required this.icon,
    required this.isFilePicked,
  });

  Future<void> _pickImageFromCamera(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      // Read the file as bytes
      final bytes = await File(image.path).readAsBytes();

      // Convert the bytes to base64 string
      final base64String = base64Encode(bytes);

      // Pass the base64 string to onFileChange
      onFileChange('image', base64String);
    }
  }

  void _showImagePickerModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image to Upload'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedFilePicker(
                onChange: onFileChange,
                childWidget: const Text('Select Image'),
                type: FileType.image,
              ),
              const Text('Or'),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _pickImageFromCamera(context),
                  child: const Text('Take Photo With Camera'),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => _showImagePickerModal(context),
            child: const Text('Upload Image'),
          ),
        ),
        if (isFilePicked)
          OutlinedButton(
            onPressed: onRotateImage,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Rotate Image'),
                const SizedBox(width: 10),
                Icon(icon),
              ],
            ),
          ),
      ],
    );
  }
}
