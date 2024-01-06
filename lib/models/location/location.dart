import 'address.dart';

class LocationModel {
  String? placeId;
  String? licence;
  String? osmType;
  String? osmId;
  String? lat;
  String? lon;
  String? displayName;
  AddressModel? address;
  List<dynamic>? boundingbox;

  LocationModel({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.displayName,
    this.address,
    this.boundingbox,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        placeId: json['place_id'] as String?,
        licence: json['licence'] as String?,
        osmType: json['osm_type'] as String?,
        osmId: json['osm_id'] as String?,
        lat: json['lat'] as String?,
        lon: json['lon'] as String?,
        displayName: json['display_name'] as String?,
        address: json['address'] == null
            ? null
            : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
        boundingbox: json['boundingbox'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'place_id': placeId,
        'licence': licence,
        'osm_type': osmType,
        'osm_id': osmId,
        'lat': lat,
        'lon': lon,
        'display_name': displayName,
        'address': address?.toJson(),
        'boundingbox': boundingbox,
      };
}
