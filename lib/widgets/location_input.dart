import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:spot_savvy/models/location/location.dart';
import 'package:spot_savvy/widgets/location_data_list.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onGeUsertLocation});
  final void Function(LocationModel? locationModel) onGeUsertLocation;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  bool isGettingLocation = false;
  LocationData? userLocationData;
  LocationModel? userLocationResponse;

  void getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      isGettingLocation = true;
    });
    locationData = await location.getLocation();
    userLocationData = locationData;

    log('Lat = ${locationData.latitude}');
    log('Long = ${locationData.longitude}');
    await getUserRealAddress();
    setState(() {
      isGettingLocation = false;
    });
    widget.onGeUsertLocation(userLocationResponse!);
    // print('userLocationResponse');
  }

  Future<void> getUserRealAddress() async {
    final url = Uri.parse(
      'https://us1.locationiq.com/v1/reverse?key=pk.fa18c436b64c2411ac5e71af7d591431&lat=${userLocationData!.latitude}&lon=${userLocationData!.longitude}&format=json',
    );
    Response response = await http.get(url);
    final jsonData = json.decode(response.body);
    setState(() {
      userLocationResponse = LocationModel.fromJson(jsonData);
    });
    log(jsonData.toString());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          height: 200,
          width: double.infinity,
          child: isGettingLocation
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : userLocationData == null
                  ? Center(
                      child: Text(
                        'There is no data, Please select location method',
                        style: textTheme.titleMedium,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: LocationDataList(
                          userLocationResponse: userLocationResponse,
                        ),
                      ),
                    ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: getUserRealAddress,
              icon: const Icon(
                Icons.map,
              ),
              label: const Text('Select on Map'),
            ),
            TextButton.icon(
              onPressed: getCurrentLocation,
              icon: const Icon(
                Icons.location_on,
              ),
              label: const Text('Get Current Location'),
            ),
          ],
        )
      ],
    );
  }
}
