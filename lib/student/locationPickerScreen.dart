import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Commons/constant_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:provider/provider.dart';

class LocationPickerScreen extends StatefulWidget {
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late GoogleMapController _mapController;
  LatLng _centerLocation = LatLng(13.0827, 80.2707); // Default location
  String _address = "Fetching precise address...";
  String _apiKey = googleMapsApi; // Replace with your Google API Key

  Future<void> _fetchAddress(LatLng location) async {
    try {
      // Use Reverse Geocoding to get rough address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isNotEmpty) {
        print(placemarks);
        Placemark place = placemarks.first;
        setState(() {
          List<String> names = placemarks.map((place) => place.name ?? "").toList();
          List<String> street = placemarks.map((place) => place.street ?? "").toList();
          _address =
          "${place.name}, ${names},${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        _address = "Failed to fetch address.";
      });
      print("Error fetching address: $e");
    }
  }

  void _onCameraIdle() {
    _fetchAddress(_centerLocation);
  }

  void _onCameraMove(CameraPosition position) {
    _centerLocation = position.target;
  }

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _centerLocation,
              zoom: 14,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onCameraMove: _onCameraMove,
            onCameraIdle: _onCameraIdle,
          ),
          const Center(
            child: Icon(
              Icons.location_pin,
              size: 50,
              color: Colors.red,
            ),
          ),
          Positioned(
            top: 10,
            left: 16,
            right: 16,
            child: GooglePlaceAutoCompleteTextField(
              textEditingController: TextEditingController(),
              googleAPIKey: _apiKey,
              inputDecoration: const InputDecoration(
                hintText: "Search address...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              itemClick: (prediction) async {
                // Use Places API to refine the address
                setState(() {
                  _address = prediction.description!;
                });
                // Fetch LatLng of the selected location
                // (Optional: Use to move the map pin)
              },
            ),
          ),
          Positioned(
            bottom: 50,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Text(
                    _address,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Location Selected"),
                        content: Text("Address:\n$_address"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              FirebaseFirestore.instance.collection("students").doc(user!.uid).update({
                                "latlng":[_centerLocation.latitude,_centerLocation.longitude]
                              });
                              FirebaseAuth.instance.signOut();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text("Confirm Location"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}