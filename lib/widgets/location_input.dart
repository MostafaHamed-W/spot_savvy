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
  final void Function(LocationModel? locationModel, Image? locationImage) onGeUsertLocation;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Image? image;
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
    await fetchImage();
    setState(() {
      isGettingLocation = false;
    });
    widget.onGeUsertLocation(userLocationResponse!, image);
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
  }

  Future<void> fetchImage() async {
    final imageUrl = Uri.parse(
        'https://maps.geoapify.com/v1/staticmap?style=osm-bright-smooth&width=600&height=400&center=lonlat%3A${userLocationResponse!.lon}%2C${userLocationResponse!.lat}&zoom=14.3497&marker=lonlat%3A${userLocationResponse!.lon}%2C${userLocationResponse!.lat}%3Btype%3Aawesome%3Bcolor%3A%23bb3f73%3Bsize%3Ax-large%3Bicon%3Apaw%7Clonlat%3A${userLocationResponse!.lon}%2C${userLocationResponse!.lat}%3Btype%3Amaterial%3Bcolor%3A%234c905a%3Bicon%3Atree%3Bicontype%3Aawesome%7Clonlat%3A${userLocationResponse!.lon}%2C${userLocationResponse!.lat}%3Btype%3Amaterial%3Bcolor%3A%234c905a%3Bicon%3Atree%3Bicontype%3Aawesome&apiKey=4ac3bb5bbbe74dc4ace0af6bccaac247');
    try {
      final response = await http.get(imageUrl);

      if (response.statusCode == 200) {
        setState(() {
          // Use Image.memory to decode and display the image
          image = Image.memory(
            response.bodyBytes,
            fit: BoxFit.cover,
          );
        });
        print(response.statusCode);
      } else {
        print("Failed to fetch the image: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching the image: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          width: double.infinity,
          child: isGettingLocation
              ? const SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : userLocationData == null
                  ? SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          'There is no data, Please select location method',
                          style: textTheme.titleMedium,
                        ),
                      ),
                    )
                  : image == null
                      ? const CircularProgressIndicator()
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              image!,
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              //   child: LocationDataList(
                              //     userLocationResponse: userLocationResponse,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {},
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
