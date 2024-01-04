import 'package:flutter/material.dart';
import 'package:spot_savvy/models/place_model.dart';

class Place extends StatelessWidget {
  final PlaceModel selectedPlace;
  const Place({super.key, required this.selectedPlace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Text(
            'Place Name: ${selectedPlace.title}\n \nPlace id: ${selectedPlace.id}',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          if (selectedPlace.image != null)
            SizedBox(
              width: double.infinity,
              // height: 250,
              child: Image.file(
                selectedPlace.image!,
                fit: BoxFit.cover,
              ),
            )
        ],
      ),
    );
  }
}
