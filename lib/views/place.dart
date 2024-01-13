import 'package:flutter/material.dart';
import 'package:spot_savvy/models/place_model.dart';
import 'package:spot_savvy/views/map_screen.dart';
import 'package:spot_savvy/widgets/location_data_list.dart';
import 'dart:typed_data';

class Place extends StatelessWidget {
  final PlaceModel selectedPlace;
  const Place({super.key, required this.selectedPlace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Stack(
        children: [
          if (selectedPlace.image != null)
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.file(
                selectedPlace.image!,
                fit: BoxFit.fitHeight,
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MapScreen(
                    selectedPlace: selectedPlace,
                  ),
                ),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.black87,
                    Colors.transparent,
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      Opacity(
                        opacity: 0.8,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: MemoryImage(
                            selectedPlace.locationImage!,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        selectedPlace.locationModel?.displayName ?? 'Unknown',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
