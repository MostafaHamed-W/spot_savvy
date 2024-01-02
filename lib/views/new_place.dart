import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_savvy/providers/places_provider.dart';

import 'package:uuid/uuid.dart';

class NewPlcae extends ConsumerStatefulWidget {
  const NewPlcae({super.key});

  @override
  ConsumerState<NewPlcae> createState() => _NewPlcaeState();
}

class _NewPlcaeState extends ConsumerState<NewPlcae> {
  final TextEditingController _titleController = TextEditingController();

  void addNewPlace({
    String? placeId,
    required String placeTitle,
  }) {
    ref.read(placesProvider.notifier).addNewPlcae(
          title: placeTitle,
        );

    Navigator.pop(context);
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
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                addNewPlace(placeTitle: _titleController.text);
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
    );
  }
}
