import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(
          pickedFile.path,
        );
      });
    } else {
      setState(() {
        _image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: _image != null
          ? Image.file(
              _image!,
              key: ValueKey(_image),
              fit: BoxFit.cover,
            )
          : TextButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.camera),
              label: const Text('Add photo'),
            ),
    );
  }
}
