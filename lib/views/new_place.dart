import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spot_savvy/providers/places_provider.dart';
import 'package:spot_savvy/widgets/image_input.dart';

class NewPlcae extends ConsumerStatefulWidget {
  const NewPlcae({super.key});

  @override
  ConsumerState<NewPlcae> createState() => _NewPlcaeState();
}

class _NewPlcaeState extends ConsumerState<NewPlcae> {
  final TextEditingController _titleController = TextEditingController();

  void _savePlace({
    required String placeTitle,
  }) {
    ref.read(userPlacesProvider.notifier).addNewPlcae(
          title: placeTitle,
          image: _image,
        );

    Navigator.pop(context);
  }

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(
          pickedFile.path,
        );
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new place',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                style: Theme.of(context).textTheme.titleSmall,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  label: Text('Title'),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                child: _image != null
                    ? InkWell(
                        onTap: _pickImage,
                        child: Image.file(
                          _image!,
                          key: ValueKey(_image),
                          fit: BoxFit.cover,
                        ),
                      )
                    : TextButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.camera),
                        label: const Text('Add photo'),
                      ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  _savePlace(placeTitle: _titleController.text);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    Text(
                      'Add place',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
