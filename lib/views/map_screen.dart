import 'package:flutter/material.dart';
import 'package:spot_savvy/models/place_model.dart';
import 'package:spot_savvy/widgets/location_data_list.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key, required this.selectedPlace});
  final PlaceModel selectedPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${selectedPlace.title} Location"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.memory(
              selectedPlace.locationImage!,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: LocationDataList(userLocationResponse: selectedPlace.locationModel),
            ),
          ],
        ),
      ),
    );
  }
}
