import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_savvy/models/place_model.dart';

final placesProvider = StateNotifierProvider<NewPlcaeNotifier, List<PlaceModel>>(
  (ref) => NewPlcaeNotifier(),
);

class NewPlcaeNotifier extends StateNotifier<List<PlaceModel>> {
  NewPlcaeNotifier() : super([]);

  void addNewPlcae({required String title}) {
    state = [...state, PlaceModel(title: title)];
  }
}
