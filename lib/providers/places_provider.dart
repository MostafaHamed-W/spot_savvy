import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_savvy/models/location/location.dart';
import 'package:spot_savvy/models/place_model.dart';

final userPlacesProvider = StateNotifierProvider<UserPlacesNotifier, List<PlaceModel>>(
  (ref) => UserPlacesNotifier(),
);

class UserPlacesNotifier extends StateNotifier<List<PlaceModel>> {
  UserPlacesNotifier() : super(const []);

  void addNewPlcae({required String title, File? image, LocationModel? locationData}) {
    state = [...state, PlaceModel(title: title, image: image, locationModel: locationData)];
  }
}
