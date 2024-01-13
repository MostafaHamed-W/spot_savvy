import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:spot_savvy/models/location/location.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class PlaceModel {
  final String title;
  final String id;
  final File? image;
  final LocationModel? locationModel;
  final Uint8List? locationImage;

  PlaceModel({
    required this.title,
    this.image,
    this.locationModel,
    this.locationImage,
    String? id,
  }) : id = id ?? uuid.v4();
}
