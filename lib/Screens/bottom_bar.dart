import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Commons/constant_strings.dart';
import 'package:driver/Screens/emergency.dart';
import 'package:driver/Screens/history.dart';
import 'package:driver/Screens/home.dart';
import 'package:driver/Screens/passengers.dart';
import 'package:driver/Screens/route.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var index = 0;
  List Screen = [Home(), Passengers(), RoutePath(), Emergency(), History()];
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Screen[i],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: i,
        onTap: (index) {
          setState(() {
            i = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: home),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: passengers),
          BottomNavigationBarItem(
              icon: Icon(Icons.alt_route_rounded), label: route),
          BottomNavigationBarItem(
              icon: Icon(Icons.bus_alert), label: emergency),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: history),
        ],
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.poppins(),
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'location_service.dart';
import 'second_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isTracking = false;
  double _currentSpeed = 0.0;

  void _toggleTracking() {
    if (_isTracking) {
      LocationService().stopLocationUpdates();
    } else {
      LocationService().startLocationUpdates();
      // Listen to the stream directly in the UI if desired
      Geolocator.getPositionStream().listen((position) {
        setState(() {
          _currentSpeed = position.speed * 3.6;  // Convert m/s to km/h
        });
      });
    }
    setState(() {
      _isTracking = !_isTracking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Location Tracker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _toggleTracking,
              style: ElevatedButton.styleFrom(
                primary: _isTracking ? Colors.red : Colors.green,
              ),
              child: Text(_isTracking ? "Stop Tracking" : "Start Tracking"),
            ),
            SizedBox(height: 20),
            Text("Current Speed: ${_currentSpeed.toStringAsFixed(2)} km/h"),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Go to Other Page"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

 */