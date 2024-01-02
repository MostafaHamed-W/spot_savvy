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
      body: Center(
        child: Text(
          'Place id: ${selectedPlace.id}\nPlace Name: ${selectedPlace.title}',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
