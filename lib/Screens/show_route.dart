import 'package:driver/Commons/common_Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
class ShowRoute extends StatefulWidget {
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
}
