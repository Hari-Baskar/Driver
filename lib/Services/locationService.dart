import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;

  LocationService._internal();

  StreamSubscription<Position>? _positionSubscription;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Start listening for location updates
  void startLocationUpdates(BuildContext context) {
    final User? user = Provider.of<User?>(context, listen: false);
    if (user == null) {
      print("No user is logged in.");
      return;
    }

    if (_positionSubscription == null || _positionSubscription!.isPaused) {
      _positionSubscription = Geolocator.getPositionStream().listen((Position position) {
        _updateLocationToFirestore(user, position);
      });
    }
  }

  // Stop location updates
  void stopLocationUpdates() {
    _positionSubscription?.cancel();
    _positionSubscription = null;
  }

  // Save location to the same Firestore document
  void _updateLocationToFirestore(User user, Position position) {
    double speedKmh = position.speed * 3.6;  // Convert m/s to km/h

    _firestore
        .collection('driver')
        .doc(user.uid)
        .collection('locations')
        .doc('currentLocation')  // This document will be updated every time
        .set({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'speed_kmh': speedKmh,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true)); // Merge updates to avoid overwriting other fields
  }

  // Request location permission
  Future<bool> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    return status.isGranted;
  }

  // Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
}
