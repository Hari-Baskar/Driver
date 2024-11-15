import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Commons/constant_strings.dart';
import 'package:driver/Custom_Widgets/custom_Button.dart';
import 'package:driver/Custom_Widgets/custom_appBar.dart';
import 'package:driver/Custom_Widgets/custom_textFieldWidget.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:driver/Services/db_Service.dart';
import 'package:driver/Custom_Widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class Passengers extends StatefulWidget {
  const Passengers({super.key});

  @override
  State<Passengers> createState() => _PassengersState();
}

class _PassengersState extends State<Passengers> {
  bool checked = true;
  late double divHeight, divWidth;
  DBService dbService = DBService();
  bool selected = true;
  List passenger = [
    {
      "studentName": "Praveen",
      "classAndSec": "X-C",
      "studentId": "Sec21it053",
      "checked": true
    },
    {
      "studentName": "Vasanth",
      "classAndSec": "X-C",
      "studentId": "Sec21it053",
      "checked": true
    },
    {
      "studentName": "Madhu",
      "classAndSec": "X-C",
      "studentId": "Sec21it053",
      "checked": true
    },
    {
      "studentName": "Ashwin",
      "classAndSec": "X-C",
      "studentId": "Sec21it053",
      "checked": true
    },
    {
      "studentName": "Ajith",
      "classAndSec": "X-C",
      "studentId": "Sec21it053",
      "checked": true
    },
  ];
  List upcoming = [
    {
      "studentName": "Pranau",
      "classAndSec": "X-C",
      "studentId": "Sec21it053",
      "checked": false
    },
    {
      "studentName": "HariRaj",
      "classAndSec": "X-C",
      "studentId": "Sec21it053",
      "checked": false
    },
    {
      "studentName": "Roshin",
      "classAndSec": "X-C",
      "studentId": "Sec21it053",
      "checked": false
    },
    {
      "studentName": "Yoge",
      "classAndSec": "X-C",
      "studentId": "Sec21it053",
      "checked": false
    },
    {
      "studentName": "Aakash",
      "classAndSec": "X-C",
      "studentId": "Sec21it053",
      "checked": false
    },
  ];
  TextEditingController studentId = TextEditingController();
  List currentPassengersDocuments = [];
  String? userId;
  String? tripType;

  final TripType = GetStorage();

  @override
  Widget build(BuildContext context) {
    divHeight = MediaQuery.of(context).size.height;
    divWidth = MediaQuery.of(context).size.width;
    final user = Provider.of<User?>(context);
    String userId = user!.uid;
    tripType = TripType.read("type");
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: appBarWidget(
        title: passengers,
        fontsize: divHeight * 0.02,
      ),
      body: tripType == null
          ? Center(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(
                    text: "Select TripType :",
                    fontWeight: FontWeight.w900,
                    fontsize: divHeight * 0.02,
                    fontColor: borderColor),
                SizedBox(
                  height: divHeight * 0.02,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  chipButton(chipName: "PickUp"),
                  SizedBox(
                    width: divWidth * 0.02,
                  ),
                  chipButton(chipName: "Drop"),
                ])
              ],
            ))
          : StreamBuilder(
              stream:
                  dbService.todaysPassengers(uid: userId, collectionName: date),
              builder: (context, snapshots) {
                if (!snapshots.hasData) return Loading();
                Map<dynamic, dynamic> todaysHistory = snapshots.data!;
                List passengersDocuments = [];
                print(tripType);
                if (todaysHistory
                    .containsKey("${tripType!.toLowerCase()}PassengersList")) {
                  passengersDocuments =
                      todaysHistory["${tripType!.toLowerCase()}PassengersList"];

                  for (int i = 0; i < passengersDocuments.length; i++) {
                    currentPassengersDocuments
                        .add(passengersDocuments[i]['docId']);
                  }
                  currentPassengersDocuments =
                      currentPassengersDocuments.toSet().toList();
                  print(currentPassengersDocuments);
                } else {
                  currentPassengersDocuments = [];
                }

                return StreamBuilder(
                    stream: dbService.totalPassengers(
                      uid: userId,
                    ),
                    builder: (context, snapshots) {
                      if (!snapshots.hasData) return Loading();
                      QuerySnapshot upcomingQuerySnapshot = snapshots.data;
                      List<DocumentSnapshot> upcomingDocuments =
                          upcomingQuerySnapshot.docs;

                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  textWidget(
                                      text: "TripType :  ",
                                      fontWeight: FontWeight.w500,
                                      fontsize: divHeight * 0.017,
                                      fontColor: Colors.black),
                                  textWidget(
                                      text: tripType!,
                                      fontWeight: FontWeight.w500,
                                      fontsize: divHeight * 0.017,
                                      fontColor: tripType == "PickUp"
                                          ? Colors.green
                                          : Colors.red),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        tripType = null;
                                        TripType.write("type", null);
                                      });
                                    },
                                    child: buttonWidget(
                                        buttonName: "Edit TripType",
                                        buttonWidth: divWidth * 0.5,
                                        buttonColor: Colors.orangeAccent,
                                        fontSize: divHeight * 0.017,
                                        fontweight: FontWeight.w500,
                                        fontColor: secondaryColor),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: divHeight * 0.03,
                              ),
                              Row(
                                children: [
                                  textWidget(
                                      text: "Student Id :",
                                      fontWeight: FontWeight.w500,
                                      fontsize: divHeight * 0.022,
                                      fontColor: Colors.black),
                                  const Spacer(),
                                  Container(
                                      width: divWidth * 0.6,
                                      child: textFieldWidget(
                                        hintText: "",
                                        control: studentId,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: divHeight * 0.02,
                              ),
                              //StudentIdBox(),
                              Container(
                                height: divHeight * 0.06,
                                width: divWidth * 0.90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1.0, color: primaryColor),
                                    color: secondaryColor),
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = !selected;
                                          });
                                        },
                                        child: SwitchButtonWidget(
                                            title: tripType == "PickUp"
                                                ? "Passengers"
                                                : "Dropped",
                                            Selected: selected)),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selected = !selected;
                                        });
                                      },
                                      child: SwitchButtonWidget(
                                          title: tripType == "PickUp"
                                              ? "Upcoming"
                                              : "Passengers",
                                          Selected: !selected),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: divHeight * 0.02,
                              ),
                              selected
                                  ? passengersDocuments.length != 0
                                      ? SizedBox(
                                          height: divHeight * 0.4,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                passengersDocuments.length,
                                            itemBuilder: (context, index) {
                                              Map<String, dynamic> data =
                                                  passengersDocuments[index];

                                              return StudentIdBox(
                                                  checked: true,
                                                  passengerDetails: data,
                                                  uid: userId);
                                            },
                                          ))
                                      : Center(
                                          child: textWidget(
                                              text: "Currently 0 passengers",
                                              fontWeight: FontWeight.w500,
                                              fontsize: divHeight * 0.017,
                                              fontColor: borderColor))
                                  : SizedBox(
                                      height: divHeight * 0.65,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: upcomingDocuments.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot document =
                                              upcomingDocuments[index];
                                          Map<String, dynamic> data = document
                                              .data() as Map<String, dynamic>;
                                          data["docId"] = document.id;
                                          String documentId = document.id;
                                          return !currentPassengersDocuments
                                                  .contains(documentId)
                                              ? StudentIdBox(
                                                  checked: false,
                                                  passengerDetails: data,
                                                  uid: userId,
                                                )
                                              : SizedBox();
                                        },
                                      ),
                                    ),

                              SizedBox(
                                height: divHeight * 0.1,
                              ),
                              // selected
                              //     ? Row(
                              //         mainAxisAlignment: MainAxisAlignment.end,
                              //         children: [
                              //             InkWell(
                              //                 onTap: () {},
                              //                 child: buttonWidget(
                              //                     buttonName: "Submit All",
                              //                     buttonWidth: divWidth * 0.4,
                              //                     buttonColor: primaryColor,
                              //                     fontSize: divHeight * 0.017,
                              //                     fontweight: FontWeight.w500,
                              //                     fontColor: secondaryColor))
                              //           ])
                              //     : SizedBox(),
                            ],
                          ),
                        ),
                      );
                    });
              }),
    );
  }

  StudentIdBox({
    required Map passengerDetails,
    required bool checked,
    required String uid,
  }) {
    // final user = Provider.of<User?>(context);
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textWidget(
                        text: passengerDetails["studentName"],
                        fontWeight: FontWeight.w500,
                        fontsize: divHeight * 0.017,
                        fontColor: borderColor),
                    textWidget(
                        text: passengerDetails["classAndSec"],
                        fontWeight: FontWeight.w500,
                        fontsize: divHeight * 0.017,
                        fontColor: Colors.black45),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textWidget(
                        text: passengerDetails["studentId"],
                        fontWeight: FontWeight.w500,
                        fontsize: divHeight * 0.017,
                        fontColor: primaryColor),
                    //TextWidget(text: "1.00 pm", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (checked)
                      const Text("")
                    else
                      IconButton(
                        icon: const Icon(
                          Icons.check_box_outline_blank_rounded,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          await dbService.addPassengersInTodaysDate(
                              uid: uid,
                              uploadPassengerDetails: passengerDetails,
                              uploadTripType: tripType!);

                        },
                      ),
                    checked
                        ? IconButton(
                            onPressed: () async {
                              // print(currentPassengersDocuments);
                              await dbService.deletePassengerFromList(
                                  uid: uid,
                                  passengerDetails: passengerDetails,
                                  uploadTripType: tripType!);

                              setState(() {
                                //  Map passen=passenger[index]['checked'];
                                currentPassengersDocuments
                                    .remove(passengerDetails['docId']);
                              });
                            },
                            icon: const Icon(
                              Icons.delete_outline_outlined,
                              color: absentColor,
                            ))
                        : const Text(""),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  SwitchButtonWidget({required String title, required bool Selected}) {
    return Container(
      height: divHeight * 0.06,
      width: divWidth * 0.447,
      decoration: BoxDecoration(
          color: Selected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(9)),
      child: Center(
        child: textWidget(
            text: title,
            fontWeight: FontWeight.w700,
            fontsize: divHeight * 0.017,
            fontColor: Selected ? secondaryColor : borderColor),
      ),
    );
  }

  chipButton({
    required String chipName,
  }) =>
      InkWell(
        onTap: () {
          setState(() {
            TripType.write("type", chipName);
          });
        },
        child: Chip(
            backgroundColor: chipName == "PickUp" ? presentColor: absentColor,
            label: textWidget(
                text: chipName,
                fontWeight: FontWeight.w500,
                fontsize: divHeight * 0.017,
                fontColor: secondaryColor)),
      );
}
