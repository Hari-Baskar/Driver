import 'dart:convert';

import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Commons/constant_strings.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission_handler/permission_handler.dart';


class SchoolDriverMap extends StatefulWidget {
  @override
  _SchoolDriverMapState createState() => _SchoolDriverMapState();
}

class _SchoolDriverMapState extends State<SchoolDriverMap> {
  late GoogleMapController mapController;
  late LatLng _position;
  late String _nearestDropLocation;
  bool _isLocationFetched = false;

  @override
  void initState() {
    super.initState();
    _position = const LatLng(37.7749, -122.4194); // Example: Default position (San Francisco)
    _nearestDropLocation = "Fetching nearest drop location...";
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Function to get current location
  Future<void> _getCurrentLocation() async {
    // Request location permission
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle denied permission
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _position = LatLng(position.latitude, position.longitude);
      _isLocationFetched = true;
    });

    // Fetch nearest drop location
    await _getNearestDropLocation(position.latitude, position.longitude);
  }

  // Function to find nearest drop location (nearest road or location)
  Future<void> _getNearestDropLocation(double latitude, double longitude) async {
    // Replace with your API key
    final url = Uri.parse(
      'https://roads.googleapis.com/v1/nearestRoads?points=$latitude,$longitude&key=$googleMapsApi',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data != null && data['snappedPoints'].isNotEmpty) {
        var road = data['snappedPoints'][0]['location'];

        setState(() {
          _nearestDropLocation = 'Nearest Drop Location: ${road['latitude']}, ${road['longitude']}';
        });
      } else {
        setState(() {
          _nearestDropLocation = 'No drop location found';
        });
      }
    } else {
      setState(() {
        _nearestDropLocation = 'Failed to fetch nearest drop location';
      });
    }
  }

  // Map controller setup
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("School Driver Map"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text("Get Current Location"),
            ),
          ),
          const SizedBox(height: 10),
          if (_isLocationFetched)
            Text(_nearestDropLocation, style: const TextStyle(fontSize: 18)),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _position,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('dropLocation'),
                  position: _position,
                  infoWindow: const InfoWindow(title: 'Drop Location'),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}






/*class ShowRoute extends StatefulWidget {
  const ShowRoute({super.key});

  @override
  State<ShowRoute> createState() => _ShowRouteState();
}

class _ShowRouteState extends State<ShowRoute> {

  late GoogleMapController mapController;
  //final LatLng _center = const LatLng(12.9716, 77.5946);
  Set<Marker> _markers = Set<Marker>();
  late Location _location;
  LatLng? _currentLocation;
  double divheight = 0, divwidth = 0;

  String Selected="One Way";
  //bool? _locationObtained;
 // final box=GetStorage();
  @override
  void initState() {
    super.initState();

    _location = Location();
    requestLocationPermission();
    _getCurrentLocation();
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
    }
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permission is required to show map details')),
      );
    }
  }
  final List<LatLng> vanHistory = [
    LatLng(37.42796133580664, -122.085749655962),
    LatLng(37.43096133580664, -122.081749655962),
    LatLng(37.43296133580664, -122.078749655962),
    // Add more locations as necessary
  ];

  Future<void> _getCurrentLocation() async {
    try {
      var locationData = await _location.getLocation();
      setState(() {
        _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
        _markers.add(Marker(
          markerId: MarkerId('current_location'),
          position: _currentLocation!,
          infoWindow: InfoWindow(title: 'Current Location'),
        ));
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(_currentLocation!, 14.0),
        );
      //  _locationObtained = true;
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body:  GoogleMap(
        initialCameraPosition: CameraPosition(
          target: vanHistory.first, // Start map view at the first location
          zoom: 14,
        ),
        onMapCreated: _onMapCreated,
        polylines: {
          Polyline(
            polylineId: PolylineId('vanRoute'),
            color: Colors.blue,
            width: 5,
            points: vanHistory, // Points from van history
          ),
        },
        markers: vanHistory.map((latLng) {
          return Marker(
            markerId: MarkerId(latLng.toString()),
            position: latLng,
          );
        }).toSet(),
      ),
    );
  }
}*/
