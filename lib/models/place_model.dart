import 'dart:io';

import 'package:spot_savvy/models/location/location.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class PlaceModel {
  final String title;
  final String id;
  final File? image;
  final LocationModel? locationModel;

  PlaceModel({required this.title, this.image, this.locationModel}) : id = uuid.v4();
}
