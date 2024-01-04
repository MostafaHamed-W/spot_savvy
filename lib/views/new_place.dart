import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_savvy/providers/places_provider.dart';
import 'package:spot_savvy/widgets/image_input.dart';
import 'package:spot_savvy/widgets/location_input.dart';

class NewPlcae extends ConsumerStatefulWidget {
  const NewPlcae({super.key});

  @override
  ConsumerState<NewPlcae> createState() => _NewPlcaeState();
}

class _NewPlcaeState extends ConsumerState<NewPlcae> {
  final TextEditingController _titleController = TextEditingController();
  File? _selectedImage;

  void _savePlace({
    required String placeTitle,
  }) {
    if (placeTitle != "" && _selectedImage != null) {
      ref.read(userPlacesProvider.notifier).addNewPlcae(
            title: placeTitle,
            image: _selectedImage,
          );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Please Enter a Valid Place Data!'),
        ),
      );
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
              ImageInput(
                onSelectImage: (File? selectedImage) {
                  _selectedImage = selectedImage;
                },
              ),
              const SizedBox(height: 30),
              const LocationInput(),
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
