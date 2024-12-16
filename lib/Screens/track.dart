import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Custom_Widgets/custom_appBar.dart';

import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:driver/Services/auth_Service.dart';
import 'package:driver/Services/locationService.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
class TrackVechile extends StatefulWidget {
  const TrackVechile({super.key});

  @override
  State<TrackVechile> createState() => _TrackVechileState();
}

class _TrackVechileState extends State<TrackVechile> {

  bool _isTracking = false;
  double _currentSpeed = 0.0;

  void _toggleTracking() async {
    bool hasPermission = await LocationService().requestLocationPermission();

    if (!hasPermission) {
      return;
    }

    bool serviceEnabled = await LocationService().isLocationServiceEnabled();
    if (!serviceEnabled) {
      //message(context: context, Content: "Location services are disabled.", fontSize: divHeight*0.17, fontColor: secondaryColor, BarColor: absentColor);
      return;
    }

    if (_isTracking) {
      LocationService().stopLocationUpdates();
    }
    else {
      LocationService().startLocationUpdates(context);

      Geolocator.getPositionStream().listen((position) {
        setState(() {
          _currentSpeed = position.speed * 3.6;
        });
      });
    }

    setState(() {
      _isTracking = !_isTracking;
    });
  }

  late double divHeight, divWidth;

  @override
  Widget build(BuildContext context) {
    divHeight = MediaQuery.of(context).size.height;
    divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
          appBarWidget(title: "Location Tracker", fontsize: divHeight * 0.02),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
                onPressed: _toggleTracking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isTracking ? red : green,
                ),
                child: textWidget(
                    text: _isTracking ? "Stop Tracking" : "Start Tracking",
                    fontWeight: FontWeight.w500,
                    fontsize: divHeight * 0.017,
                    fontColor: white)),
            SizedBox(height: divHeight * 0.01),
            textWidget(
                text: "Current Speed: ${_currentSpeed.toStringAsFixed(2)} km/h",
                fontWeight: FontWeight.w500,
                fontsize: divHeight * 0.017,
                fontColor: white),
            ElevatedButton(
                onPressed: (){
                  AuthService().logOut();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isTracking ? red : green,
                ),
                child: textWidget(
                    text: _isTracking ? "Tracking" : "Tracking",
                    fontWeight: FontWeight.w500,
                    fontsize: divHeight * 0.017,
                    fontColor: white)),
            SizedBox(height: divHeight * 0.01),
            textWidget(
                text: "Current Speed: ${_currentSpeed.toStringAsFixed(2)} km/h",
                fontWeight: FontWeight.w500,
                fontsize: divHeight * 0.017,
                fontColor: white),
          ],
        ),
      ),
    );
  }
}

/*class RoutePath extends StatefulWidget {
  const RoutePath({super.key});

  @override
  State<RoutePath> createState() => _RoutePathState();
}

class _RoutePathState extends State<RoutePath> {
  String? latLng;
  TextEditingController _sourceaddress = TextEditingController();
  TextEditingController _destinationAddress=TextEditingController();
  var distance;
  String? landmark;
  Future<void> _getLatLngFromAddress() async {


    try {


      List<Location> sourcelocations = await locationFromAddress(_sourceaddress.text);
      List<Location> destinlocations = await locationFromAddress(_destinationAddress.text);
      print(sourcelocations);
      if (sourcelocations.isNotEmpty && destinlocations.isNotEmpty) {
        double slat = sourcelocations[0].latitude;
        double slng = sourcelocations[0].longitude;
        double dlat = destinlocations[0].latitude;
        double dlng = destinlocations[0].longitude;
        print(slng);
        reverseGeocode(slat,slng);
        setState(() {
          distance= (Geolocator.distanceBetween(slat, slng, dlat, dlng)/1000).toStringAsFixed(1);

        }); //double distance= Geolocator.distanceBetween(slat, slng, dlat, dlng)/1000;


      }
    } catch (e) {
      print(e.toString());

    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _sourceaddress,
            decoration: InputDecoration(
              labelText: 'Enter Source address',
            ),
          ),
          SizedBox(height: 20),
          TextField(controller:_destinationAddress,
            decoration: InputDecoration(
              labelText: 'Enter Source address',
            ),
          ),
          ElevatedButton(
            onPressed: _getLatLngFromAddress,
            child: Text('Get Distance'),
          ),
          SizedBox(height: 20),
          distance==null ? Text("0km") : Text(distance.toString() ),
          landmark==null ? Text("0km") : Text(landmark.toString() ),
          ElevatedButton(
            onPressed: _getLatLngFromAddress,
            child: Text('Get Distance'),
          ),
        ],
      ),
    );
  }


  // Step 2: Reverse geocode to get the nearest road or landmark
  Future<void> reverseGeocode(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      print("ibinbn");
      if (placemarks.isNotEmpty) {
        setState(() {
          // Here we try to fetch street or any landmark nearby
          landmark = placemarks[0].street ??
              placemarks[0].name ??
              'No common landmark or road found';
        });
      } else {
        setState(() {
          landmark = 'No landmark found for this location.';
        });
      }
    } catch (e) {
      setState(() {
        landmark = 'Error retrieving landmark: $e';
      });
    }
  }
}
*/
/* late double divHeight, divWidth;

  TextEditingController schoolLocation = TextEditingController();
  TextEditingController LastDropLocation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    divHeight = MediaQuery.of(context).size.height;
    divWidth = MediaQuery.of(context).size.width;

    return StreamBuilder(stream: , builder: (context,snapshot)
    {
      Scaffold(
        backgroundColor: secondaryColor,
        appBar: appBarWidget(title: route, fontsize: divHeight * 0.02),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [

                SizedBox(
                  height: divHeight * 0.02,
                ),
                textFieldWidget(
                    hintText: "Enter your school location",
                    control: schoolLocation,
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: absentColor,
                    )),
                SizedBox(
                  height: divHeight * 0.02,
                ),
                textFieldWidget(
                    hintText: "Enter your last drop location",
                    control: LastDropLocation,
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: presentColor,
                    )),
                SizedBox(
                  height: divHeight * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ShowRoute()));
                      },
                      child: buttonWidget(
                          buttonName: "Edit Route",
                          buttonWidth: divWidth * 0.4,
                          buttonColor: absentColor,
                          fontSize: divHeight * 0.017,
                          fontweight: FontWeight.w500,
                          fontColor: secondaryColor),
                    ),
                    buttonWidget(
                        buttonName: "Show Route",
                        buttonWidth: divWidth * 0.4,
                        buttonColor: primaryColor,
                        fontSize: divHeight * 0.017,
                        fontweight: FontWeight.w500,
                        fontColor: secondaryColor),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
    );
  }

  Container switchButtonWidget({required String title, required bool Selected}) {
    return Container(
      height: divHeight * 0.08,
      width: divWidth * 0.447,
      decoration: BoxDecoration(
          color: Selected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: textWidget(
            text: title,
            fontWeight: FontWeight.w700,
            fontsize: divHeight * 0.017,
            fontColor: Selected ? secondaryColor : borderColor),
      ),
    );
  }
}*/
