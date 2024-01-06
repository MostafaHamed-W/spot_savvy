class AddressModel {
  String? government;
  String? houseNumber;
  String? road;
  String? quarter;
  String? suburb;
  String? city;
  String? stateDistrict;
  String? state;
  String? postcode;
  String? country;
  String? countryCode;

  AddressModel({
    this.government,
    this.houseNumber,
    this.road,
    this.quarter,
    this.suburb,
    this.city,
    this.stateDistrict,
    this.state,
    this.postcode,
    this.country,
    this.countryCode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        government: json['government'] as String?,
        houseNumber: json['house_number'] as String?,
        road: json['road'] as String?,
        quarter: json['quarter'] as String?,
        suburb: json['suburb'] as String?,
        city: json['city'] as String?,
        stateDistrict: json['state_district'] as String?,
        state: json['state'] as String?,
        postcode: json['postcode'] as String?,
        country: json['country'] as String?,
        countryCode: json['country_code'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'government': government,
        'house_number': houseNumber,
        'road': road,
        'quarter': quarter,
        'suburb': suburb,
        'city': city,
        'state_district': stateDistrict,
        'state': state,
        'postcode': postcode,
        'country': country,
        'country_code': countryCode,
      };
}
