import 'package:flutter/material.dart';
import 'package:spot_savvy/models/place_model.dart';
import 'package:spot_savvy/widgets/location_data_list.dart';

class Place extends StatelessWidget {
  final PlaceModel selectedPlace;
  const Place({super.key, required this.selectedPlace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Place Name: ${selectedPlace.title}',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              if (selectedPlace.image != null)
                SizedBox(
                  width: double.infinity,
                  // height: 250,
                  child: Image.file(
                    selectedPlace.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 10),
              LocationDataList(userLocationResponse: selectedPlace.locationModel)
            ],
          ),
        ),
      ),
    );
  }
}
