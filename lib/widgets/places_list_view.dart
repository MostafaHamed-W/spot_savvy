import 'package:flutter/material.dart';
import 'package:spot_savvy/models/place_model.dart';
import 'package:spot_savvy/views/place.dart';

class PlacesListView extends StatelessWidget {
  const PlacesListView({
    super.key,
    required this.placesList,
  });

  final List<PlaceModel> placesList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: placesList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(placesList[index].image!),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Place(
                    selectedPlace: placesList[index],
                  ),
                ),
              );
            },
            title: Text(placesList[index].title),
          ),
        );
      },
    );
  }
}
