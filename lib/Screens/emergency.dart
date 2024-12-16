
import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Commons/constant_strings.dart';
import 'package:driver/Custom_Widgets/custom_Button.dart';
import 'package:driver/Custom_Widgets/custom_appBar.dart';
import 'package:driver/Custom_Widgets/custom_textFieldWidget.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Student {
  final String name;
  final String photoUrl;

  Student({required this.name, required this.photoUrl});
}

class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  late double divHeight, divWidth;
  TextEditingController situation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    divHeight = MediaQuery.of(context).size.height;
    divWidth = MediaQuery.of(context).size.width;

    // Function to fetch current location
    Future<void> _sendToSchool() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enable location services'),
        ));
        return;
      }

      // Check location permission status
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Location permissions are denied'),
          ));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Location permissions are permanently denied'),
        ));
        return;
      }

      // Fetch the current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Prepare location data to send
      String locationMessage =
          'Emergency Situation: ${situation.text}\nLocation: Latitude: ${position.latitude}, Longitude: ${position.longitude}';

      // Simulate sending the location data to the school
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sent to school:\n$locationMessage'),
      ));
    }

    return Scaffold(
      backgroundColor: white,
      appBar: appBarWidget(title: emergency, fontsize: divHeight * 0.02),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  textWidget(
                      text: "Situation  :",
                      fontWeight: FontWeight.w500,
                      fontsize: divHeight * 0.022,
                      fontColor: black),
                  const Spacer(),
                  SizedBox(
                      width: divWidth * 0.6,
                      child: textFieldWidget(
                        hintText: "",
                        control: situation,
                      )),
                ],
              ),
              SizedBox(
                height: divHeight * 0.02,
              ),
              InkWell(child:buttonWidget(
                  buttonName: "Send to parents and school",
                  buttonWidth: divWidth * 0.7,
                  buttonColor: red,
                  fontSize: divHeight * 0.017,
                  fontweight: FontWeight.w500,
                  fontColor: white,
               ),),
              SizedBox(
                height: divHeight * 0.02,
              ),
              InkWell(
                onTap: (){},
                child:buttonWidget(
                  buttonName: "Send only school",
                  buttonWidth: divWidth * 0.4,
                  fontSize: divHeight * 0.017,
                  buttonColor: red,
                  fontweight: FontWeight.w500,
                  fontColor: white,
                 ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*late GoogleMapController mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  late List<LatLng> optimizedRoute;
  late LatLng schoolLocation;

  List<LatLng> studentLocations = [
    LatLng(13.0827, 80.27071), // Student 1
    LatLng(13.08305, 80.27067), // Student 2
    LatLng(13.08423, 80.27818), // Student 3
    LatLng(13.09022, 80.27758), // Student 4
  ];

  @override
  void initState() {
    super.initState();
    schoolLocation = LatLng(13.0827, 80.27071); // School location
    optimizedRoute = []; // Placeholder for optimized route
    _assignRoutes();
  }

  // Function to get optimized route
  Future<void> _assignRoutes() async {
    // Here you can call a route optimization API or use your own algorithm
    // For simplicity, I'm using a sample route
    optimizedRoute = [
      schoolLocation,
      studentLocations[0],
      studentLocations[1],
      studentLocations[2],
      studentLocations[3],
    ];

    // Adding markers for school and students
    _markers.add(Marker(
      markerId: MarkerId('school'),
      position: schoolLocation,
      infoWindow: InfoWindow(title: 'School'),
    ));

    for (int i = 0; i < studentLocations.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId('student_$i'),
        position: studentLocations[i],
        infoWindow: InfoWindow(title: 'Student ${i + 1}'),
      ));
    }

    // Adding polyline for optimized route
    _polylines.add(Polyline(
      polylineId: PolylineId('optimized_route'),
      points: optimizedRoute,
      color: Colors.blue,
      width: 5,
    ));

    // Adjust camera to fit the polyline
    if (mapController != null) {
      mapController.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(
            studentLocations.map((e) => e.latitude).reduce((a, b) => a < b ? a : b),
            studentLocations.map((e) => e.longitude).reduce((a, b) => a < b ? a : b),
          ),
          northeast: LatLng(
            studentLocations.map((e) => e.latitude).reduce((a, b) => a > b ? a : b),
            studentLocations.map((e) => e.longitude).reduce((a, b) => a > b ? a : b),
          ),
        ),
        100.0,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Routes'),
      ),
      body:Container(),
    );
  }
}*/
 /* late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  // Example data: Locations, profile pictures, and polyline points
  final List<LatLng> polylinePoints = [
    LatLng(37.7749, -122.4194), // Start point
    LatLng(37.7849, -122.4294), // Midpoint
    LatLng(37.7949, -122.4394), // End point
  ];

  final Map<LatLng, List<String>> dropLocations = {
    LatLng(37.7749, -122.4194): [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-_E9TLVzTnyqVmnVHgN_8t9264bPYuAeNaw&s',
    ], // Single passenger
    LatLng(37.7849, -122.4294): [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-_E9TLVzTnyqVmnVHgN_8t9264bPYuAeNaw&s',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-_E9TLVzTnyqVmnVHgN_8t9264bPYuAeNaw&s',
    ], // Multiple passengers
    LatLng(37.7949, -122.4394): [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-_E9TLVzTnyqVmnVHgN_8t9264bPYuAeNaw&s',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-_E9TLVzTnyqVmnVHgN_8t9264bPYuAeNaw&s',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-_E9TLVzTnyqVmnVHgN_8t9264bPYuAeNaw&s',
    ], // Multiple passengers
  };

  @override
  void initState() {
    super.initState();
    _addCustomMarkers();
    _addPolyline();
  }

  void _addPolyline() {
    _polylines.add(
      Polyline(
        polylineId: PolylineId('route'),
        points: polylinePoints,
        color: Colors.blue,
        width: 5,
      ),
    );
    setState(() {});
  }

  Future<void> _addCustomMarkers() async {
    for (final entry in dropLocations.entries) {
      final location = entry.key;
      final profiles = entry.value;

      Uint8List markerIcon;
      if (profiles.length == 1) {
        // Single passenger: Use their profile picture directly
        markerIcon = await _getBytesFromImageUrl(profiles[0], 100);
      } else {
        // Multiple passengers: Combine their profile pictures
        markerIcon = await _combineProfilePictures(profiles, 100);
      }

      _markers.add(
        Marker(
          markerId: MarkerId(location.toString()),
          position: location,
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: 'Drop Location',
            snippet: 'Passengers: ${profiles.length}',
          ),
        ),
      );
    }
    setState(() {});
  }

  Future<Uint8List> _getBytesFromImageUrl(String url, int size) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: size,
      targetHeight: size,
    );
    final frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  Future<Uint8List> _combineProfilePictures(
      List<String> imageUrls, int size) async {
    final images = <ui.Image>[];

    // Fetch all images and decode them
    for (final url in imageUrls) {
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;
      final codec = await ui.instantiateImageCodec(
        bytes,
        targetWidth: size ~/ 2,
        targetHeight: size ~/ 2,
      );
      final frame = await codec.getNextFrame();
      images.add(frame.image);
    }

    // Create a canvas to combine images
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint();

    // Define positions for the images in a grid layout
    final positions = [
      Offset(0, 0),
      Offset(size / 2, 0),
      Offset(0, size / 2),
      Offset(size / 2, size / 2),
    ];

    for (int i = 0; i < images.length && i < positions.length; i++) {
      canvas.drawImage(images[i], positions[i], paint);
    }

    final picture = pictureRecorder.endRecording();
    final img = await picture.toImage(size, size);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Polyline with Custom Markers')),
      body: GoogleMap(
        onMapCreated: (controller) => _mapController = controller,
        initialCameraPosition: CameraPosition(
          target: polylinePoints[0],
          zoom: 14,
        ),
        polylines: _polylines,
        markers: _markers,
      ),
    );
  }
}*/
  /*
  late GoogleMapController mapController;

  // Start and end locations
  final LatLng _startLocation = LatLng(12.928026, 80.120979);
  final LatLng _endLocation = LatLng(12.920466, 80.088365);

  // Drop locations and corresponding students
  final Map<LatLng, List<Student>> _dropLocations = {
    LatLng(12.921841, 80.093369): [
      Student(name: "Student 1", photoUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-_E9TLVzTnyqVmnVHgN_8t9264bPYuAeNaw&s"),
      Student(name: "Student 2", photoUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-_E9TLVzTnyqVmnVHgN_8t9264bPYuAeNaw&s"),
    ],
    LatLng(12.923256, 80.097178): [
      Student(name: "Student 3", photoUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-_E9TLVzTnyqVmnVHgN_8t9264bPYuAeNaw&s"),
    ],
    LatLng(12.923257, 80.09718): [
      Student(name: "Student 4", photoUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-_E9TLVzTnyqVmnVHgN_8t9264bPYuAeNaw&s"),
    ],
  };

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  String _apiKey = googleMapsApi;

  @override
  void initState() {
    super.initState();
    _setMarkers();
    _fetchRoute();
  }
// Create custom marker with rounded image from network
  Future<BitmapDescriptor> _createCustomMarker(String imageUrl) async {
    final http.Response response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode != 200) {
      throw Exception("Failed to load image");
    }

    final ui.Codec codec = await ui.instantiateImageCodec(
      response.bodyBytes,
      targetWidth: 150, // Adjust marker size
      targetHeight: 150,
    );
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image image = frameInfo.image;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final Paint paint = Paint();

    // Define a circular clip
    final double size = image.width.toDouble();
    final Rect rect = Rect.fromLTWH(0.0, 0.0, size, size);
    canvas.clipPath(Path()..addOval(rect));
    canvas.drawImageRect(image, rect, rect, paint);

    // Generate the final image
    final ui.Image roundedImage = await recorder
        .endRecording()
        .toImage(size.toInt(), size.toInt());
    final ByteData? byteData =
    await roundedImage.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

  Future<void> _setMarkers() async {
    _markers = {
      // Start Location Marker
      Marker(
        markerId: MarkerId("start"),
        position: _startLocation,
        infoWindow: InfoWindow(title: "Start Location"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        onTap: () {
          print("Start location tapped: $_startLocation");
        },
      ),
      // End Location Marker
      Marker(
        markerId: MarkerId("end"),
        position: _endLocation,
        infoWindow: InfoWindow(title: "End Location"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () {

          print("End location tapped: $_endLocation");
        },
      ),
    };

    // Drop Locations Markers
    for (var entry in _dropLocations.entries) {
      final location = entry.key;
      final students = entry.value;

      BitmapDescriptor icon;
      if (students.length == 1) {
        icon = await _createCustomMarker(students[0].photoUrl);
      } else {
        icon = await _createCustomMarker(students[0].photoUrl);
      }

      _markers.add(
        Marker(
          markerId: MarkerId("drop_${location.latitude}_${location.longitude}"),
          position: location,
          infoWindow: InfoWindow(
            title: "Drop Location",
            snippet: "Students: ${students.map((s) => s.name).join(', ')}",
          ),
          icon: icon,
          onTap: () {
            print("Drop location tapped at $location");
            print("Students: ${students.map((s) => s.name).join(', ')}");
          },
        ),
      );
    }

    setState(() {});
  }

  // Fetch directions from Google Maps Directions API
  Future<void> _fetchRoute() async {
    final String waypoints = _dropLocations.keys
        .map((loc) => "${loc.latitude},${loc.longitude}")
        .join('|');
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_startLocation.latitude},${_startLocation.longitude}&destination=${_endLocation.latitude},${_endLocation.longitude}&waypoints=$waypoints&key=$_apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final points = _decodePolyline(data['routes'][0]['overview_polyline']['points']);
      setState(() {
        _polylines.add(
          Polyline(
            polylineId: PolylineId("route"),
            points: points,
            color: Colors.blue,
            width: 4,
          ),
        );
      });
    } else {
      print("Failed to fetch directions: ${response.body}");
    }
  }

  // Decode polyline points
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polyline;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route with Drop Locations"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _startLocation,
          zoom: 14,
        ),
        markers: _markers,
        polylines: _polylines,
        mapType: MapType.satellite,
        onMapCreated: (controller) {
          mapController = controller;
        },
      ),
    );
  }
}
   */
