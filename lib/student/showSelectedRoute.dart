import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Custom_Widgets/custom_snackBar.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:driver/Custom_Widgets/loading.dart';
import 'package:driver/Services/db_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ShowSelectedRoute extends StatefulWidget {
  final String selectedRoute;
  const ShowSelectedRoute({required this.selectedRoute, super.key});

  @override
  State<ShowSelectedRoute> createState() => _ShowSelectedRouteState();
}

class _ShowSelectedRouteState extends State<ShowSelectedRoute> {
  late GoogleMapController _mapController;
  final List<Map<String, dynamic>> _dropLocations = [];
  final Set<Marker> _markers = {};
  List dropLoactionList=[];
  String? selectedDroplocationName;
  MarkerId? selectedMarkerId; // Store the ID of the currently selected marker
  bool isLoading = true;
  DBService dbservice = DBService();

  @override
  void initState() {
    super.initState();
    _fetchRouteDropLocations();
  }

  Future<void> _fetchRouteDropLocations() async {
    try {
      DocumentSnapshot documentSnapshot = await dbservice.selectedRoute(routeName: widget.selectedRoute);
      Map<String, dynamic> documentsData = documentSnapshot.data() as Map<String, dynamic>;
      dropLoactionList = documentsData["droplocations"];


    } catch (e) {
      print("Error fetching route data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }



  late double divHeight, divWidth;

  @override
  Widget build(BuildContext context) {
    divHeight = MediaQuery.of(context).size.height;
    divWidth = MediaQuery.of(context).size.width;
   List  data=dropLoactionList;
    int len = data.length;

    for (int i = 0; i < len; i++) {
      LatLng point = LatLng(data[i]["latlng"][0], data[i]["latlng"][1]);
      _markers.add(
        Marker(
          markerId: MarkerId(point.toString()),
          position: point,
          infoWindow: InfoWindow(title: data[i]["droplocationName"]),
          icon: BitmapDescriptor.defaultMarkerWithHue(selectedDroplocationName==data[i]["droplocationName"] ? BitmapDescriptor.hueGreen :BitmapDescriptor.hueRed),
          // Default color
          onTap: () {
           setState(() {
             selectedDroplocationName= data[i]["droplocationName"];
           });
          },
        ),
      );

    }

    return isLoading
        ? Loading()
        : Stack(
      children: [
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(13.0827, 80.2707),
            zoom: 12,
          ),
          markers: _markers,
          mapType: MapType.satellite,
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
        ),
        selectedDroplocationName!=null ?Positioned(
            bottom: 10,

            child:  _nameInputCard()):Text("")

      ],
    );
  }
  Widget _nameInputCard() {
    TextEditingController locationController = TextEditingController();
    DBService dbService = DBService();
    final user=Provider.of<User?>(context);
    return Card(
      color: white,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: divWidth*0.9,
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: divHeight * 0.02),
            textWidget(text: selectedDroplocationName!,
                fontsize: divHeight * 0.017,
                fontWeight: FontWeight.bold,
                fontColor: red,
                Spacing: null),

            SizedBox(height: divHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                     selectedDroplocationName=null;
                    });
                  },
                  child: textWidget(text: "cancel",
                      fontsize: divHeight * 0.017,
                      fontWeight: FontWeight.bold,
                      fontColor: red,
                      Spacing: null),),
                InkWell(
                  onTap: () async {


                      await dbService.confirmDroplocation(uid: user!.uid, droplocation: selectedDroplocationName!,route: widget.selectedRoute);
                      Navigator.pop(context);
                      //message(context: context, Content: "Your DropLocation is Confirmed", fontSize: divHeight*0.17, fontColor: white, BarColor: green);

                  },
                  child: textWidget(text: "confirm",
                      fontsize: divHeight * 0.017,
                      fontWeight: FontWeight.bold,
                      fontColor: green,
                      Spacing: null),),
              ],
            ),
          ],
        ),
        )
      ),
    );
  }
}
