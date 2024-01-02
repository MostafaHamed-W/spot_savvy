import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class PlaceModel {
  final String title;
  final String id;

  PlaceModel({required this.title}) : id = uuid.v4();
}
