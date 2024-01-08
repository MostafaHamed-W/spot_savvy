import 'package:flutter/material.dart';
import 'package:spot_savvy/models/location/location.dart';

class LocationDataList extends StatelessWidget {
  const LocationDataList({
    super.key,
    required this.userLocationResponse,
  });

  final LocationModel? userLocationResponse;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const String unkown = 'Unknown';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Country: ${userLocationResponse?.address?.country ?? unkown}',
          style: textTheme.titleSmall,
        ),
        // Text(
        //   'Code: ${userLocationResponse?.address?.countryCode ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
        Text(
          'Display name: ${userLocationResponse?.displayName ?? unkown}',
          style: textTheme.titleSmall,
        ),
        // Text(
        //   'Government: ${userLocationResponse?.address?.government ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
        Text(
          'City: ${userLocationResponse?.address?.city ?? unkown}',
          style: textTheme.titleSmall,
        ),
        // Text(
        //   'House number: ${userLocationResponse?.address?.houseNumber ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
        // Text(
        //   'Latidute: ${userLocationResponse?.lat ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
        // Text(
        //   'Longtude: ${userLocationResponse?.lon ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
        Text(
          'Postal code: ${userLocationResponse?.address?.postcode ?? unkown}',
          style: textTheme.titleSmall,
        ),
        // Text(
        //   'Quarter: ${userLocationResponse?.address?.quarter ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
        // Text(
        //   'Road: ${userLocationResponse?.address?.road ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
        // Text(
        //   'State: ${userLocationResponse?.address?.state ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
        // Text(
        //   'State district: ${userLocationResponse?.address?.stateDistrict ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
        // Text(
        //   'Suburb: ${userLocationResponse?.address?.suburb ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
        // Text(
        //   'Boundingbox: ${userLocationResponse?.boundingbox ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
        // Text(
        //   'Licence: ${userLocationResponse?.licence ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
        // Text(
        //   'Osm iD: ${userLocationResponse?.osmId ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
        // Text(
        //   'Osm Type: ${userLocationResponse?.osmType ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
        // Text(
        //   'Place iD: ${userLocationResponse?.placeId ?? unkown}',
        //   style: textTheme.titleSmall,
        // ),
      ],
    );
  }
}
