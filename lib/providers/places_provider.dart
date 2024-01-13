import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_savvy/models/location/location.dart';
import 'package:spot_savvy/models/place_model.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat TEXT, lng TEXT, address TEXT, locationImage BLOB)');
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<PlaceModel>> {
  UserPlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    print('loading');
    try {
      final db = await _getDatabase();
      final data = await db.query('user_places');
      final places = data
          .map(
            (row) => PlaceModel(
              id: row['id'] as String,
              title: row['title'] as String,
              image: File(row['image'] as String),
              locationModel: LocationModel(
                lat: row['lat'] as String,
                lon: row['lng'] as String,
                displayName: row['address'] as String,
              ),
              locationImage: row['locationImage'] as Uint8List,
            ),
          )
          .toList();
      state = places;
    } catch (e) {
      print(e);
    }
    print('loaded');
  }

  void addNewPlcae({
    required String title,
    File? image,
    LocationModel? locationData,
    Uint8List? locationImage,
  }) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image!.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = PlaceModel(
      title: title,
      image: copiedImage,
      locationModel: locationData,
      locationImage: locationImage,
    );
    final db = await _getDatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image!.path,
      'lat': newPlace.locationModel!.lat,
      'lng': newPlace.locationModel!.lon,
      'address': newPlace.locationModel!.displayName,
      'locationImage': newPlace.locationImage
    });
    state = [newPlace, ...state];
  }
}

final userPlacesProvider = StateNotifierProvider<UserPlacesNotifier, List<PlaceModel>>(
  (ref) => UserPlacesNotifier(),
);
