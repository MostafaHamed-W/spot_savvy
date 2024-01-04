import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_savvy/models/place_model.dart';
import 'package:spot_savvy/providers/places_provider.dart';
import 'package:spot_savvy/views/new_place.dart';
import 'package:spot_savvy/widgets/places_list_view.dart';

class Places extends ConsumerWidget {
  const Places({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content = Center(
      child: Text(
        'No Data Yet',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
    List<PlaceModel> placesList = ref.watch(userPlacesProvider);

    if (placesList.isNotEmpty) {
      content = Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlacesListView(placesList: placesList),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your places',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NewPlcae(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: content,
    );
  }
}
