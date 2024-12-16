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


  void startLocationUpdates(BuildContext context) {
    final User? user = Provider.of<User?>(context, listen: false);
    if (user == null) {
      return;
    }

    if (_positionSubscription == null || _positionSubscription!.isPaused) {
      _positionSubscription = Geolocator.getPositionStream().listen((Position position) {
        _updateLocationToFirestore(user, position);
      });
    }
  }


  void stopLocationUpdates() {
    _positionSubscription?.cancel();
    _positionSubscription = null;
  }


  void _updateLocationToFirestore(User user, Position position) {
    double speedKmh = position.speed * 3.6;

    // Set a threshold to filter out noise
    if (speedKmh < 1.0) {
      speedKmh = 0.0; // Consider stationary if below threshold
    }

    _firestore
        .collection('driver')
        .doc(user.uid)
        .collection('locations')
        .doc('currentLocation')
        .set({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'speed_kmh': speedKmh,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }


  Future<bool> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    return status.isGranted;
  }


  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
}
