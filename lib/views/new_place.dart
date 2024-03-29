import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:spot_savvy/models/location/location.dart';
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
  LocationModel? _locationData;
  Uint8List? _locationImage;

  void _savePlace({
    required String placeTitle,
    File? selectedImage,
    LocationModel? locationData,
    Uint8List? locationImage,
  }) {
    if (placeTitle != "" &&
        selectedImage != null &&
        locationData != null &&
        locationImage != null) {
      ref.read(userPlacesProvider.notifier).addNewPlcae(
            title: placeTitle,
            image: selectedImage,
            locationData: locationData,
            locationImage: locationImage,
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
              LocationInput(
                onGeUsertLocation: (LocationModel? locationModel, Uint8List? locationImage) {
                  _locationData = locationModel;
                  _locationImage = locationImage;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _savePlace(
                    placeTitle: _titleController.text,
                    selectedImage: _selectedImage,
                    locationData: _locationData,
                    locationImage: _locationImage,
                  );
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
