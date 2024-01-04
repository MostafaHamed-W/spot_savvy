import 'dart:io';

import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class PlaceModel {
  final String title;
  final String id;
  final File? image;

  PlaceModel({required this.title, this.image}) : id = uuid.v4();
}
