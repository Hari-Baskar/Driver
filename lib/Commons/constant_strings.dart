import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


const String emergency="Emergency";
const String passengers="Passengers";
const String history="History";
const String home="Home";
const String route="Route";
const String googleMapsApi="AIzaSyDtOzjLoQc0r8ABdx-PUs9hBaKl3yAMQyo";
final firestore=FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
DateTime currentDateTime=DateTime.now();
String date=DateFormat("dd-MM-yyyy").format(currentDateTime);
String yesterdayDate= DateFormat("dd-MM-yyyy").format(currentDateTime.subtract(Duration(days: 1)));



