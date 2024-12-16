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
  DBService dbservice = DBService();
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
  List arrangedDroplocations=[];
  @override
  Widget build(BuildContext context) {
    divHeight = MediaQuery.of(context).size.height;
    divWidth = MediaQuery.of(context).size.width;
    final user = Provider.of<User?>(context);
    String userId = user!.uid;
    tripType = TripType.read("type");
    return StreamBuilder(stream:dbservice.getVechileDetails(uid: userId) , builder: (context,driverData)

    {
      if(!driverData.hasData) return Scaffold(body:Loading());
      DocumentSnapshot? driverDocumentSnapshot=driverData!.data as DocumentSnapshot<Object?>?;
      Map<String,dynamic> data=driverDocumentSnapshot!.data() as Map<String,dynamic>;
      arrangedDroplocations=data["arrangedDroplocations"];
      int doclen=data["droplocations"].length;
      return data["droplocationArranged"]==false ? SafeArea(child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(child:Padding(padding:EdgeInsets.all(15), child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            data["route"]==null ? Column(
                children:[
                  SizedBox(height: divHeight*0.48,),
                  Center(child:textWidget(
                text: "Your route is not assigned ",
                fontWeight: FontWeight.w900,
                fontsize: divHeight * 0.02,
                fontColor: black))]
        ):Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                textWidget(
                    text: "Arrange the droplocation in order ,Start from the school",
                    fontsize: divHeight * 0.02,
                    fontColor: black, fontWeight: FontWeight.w500),
                   SizedBox(height: divHeight*0.02,),
                   ListView.builder(
                      shrinkWrap: true,
                      itemCount:doclen ,
                      itemBuilder: (context,index){
                        String dropLocationName=data["droplocations"][index]['droplocationName'];
                        bool arranged=arrangedDroplocations.contains(dropLocationName);
                    return Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 1.0, color: arranged ? green:red)
                          ),
                            child:ListTile(

                      onTap: ()async{
                        await dbservice.updateDroplocation( droplocation: dropLocationName, uid: userId);
                      },
                      title:  textWidget(
                          text: dropLocationName,
                          fontWeight: FontWeight.w900,
                          fontsize: divHeight * 0.02,
                          fontColor: black),
                                leading: textWidget(
                                    text: (arrangedDroplocations.indexOf(dropLocationName)+1).toString(),
                                    fontWeight: FontWeight.w500,
                                    fontsize: divHeight * 0.02,
                                    fontColor: black),
                      trailing:arranged ? InkWell(onTap: ()
                        async{
                          await dbservice.deleteDroplocation( droplocation: dropLocationName, uid: userId);

                      },child: Icon(Icons.delete,color: red,),):SizedBox()
                    )));
                  }),
                SizedBox(height: divHeight*0.02,),
                InkWell(
                  onTap: ()async{
                    if(doclen==arrangedDroplocations.length){
                      await dbservice.setArrangeDropLocationsToTrue(uid:userId);
                    }
                  },
                  child:buttonWidget(buttonName: "Confirm Locations", buttonWidth: divWidth*0.90, buttonColor: green, fontSize: divHeight*0.017, fontweight: FontWeight.w500,
                    fontColor: white),),
              ],
            )
          ],
        ),
        )
        )
      )):Scaffold(
        backgroundColor: white,
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
                    fontColor: black),
                SizedBox(
                  height: divHeight * 0.02,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            dbservice.todaysPassengers(uid: userId, collectionName: date),
            builder: (context, snapshots) {
              if (!snapshots.hasData) return Loading();
              Map<dynamic, dynamic> todaysHistory = snapshots.data!;
              List passengersDocuments = [];
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
              } else {
                currentPassengersDocuments = [];
              }
              List reversedDroplocations=[];
              if(tripType=="PickUp"){
                 reversedDroplocations=arrangedDroplocations.reversed.toList();
              }
              else{
                reversedDroplocations=arrangedDroplocations;
              }


              return StreamBuilder(
                  stream: dbservice.totalPassengers(
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
                                        ? green
                                        : red),
                                const Spacer(),
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
                                      fontColor: white),
                                )
                              ],
                            ),
                            SizedBox(
                              height: divHeight * 0.03,
                            ),
                           /* Row(
                              children: [
                                textWidget(
                                    text: "Student Id :",
                                    fontWeight: FontWeight.w500,
                                    fontsize: divHeight * 0.022,
                                    fontColor: borderColor),
                                const Spacer(),
                                SizedBox(
                                    width: divWidth * 0.6,
                                    child: textFieldWidget(
                                      hintText: "",
                                      control: studentId,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: divHeight * 0.02,
                            ),*/
                            //StudentIdBox(),
                            Container(
                              height: divHeight * 0.06,
                              width: divWidth * 0.90,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1.0, color: blue),
                                  color: white),
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          selected = !selected;
                                        });
                                      },
                                      child: switchButtonWidget(
                                          title: tripType == "PickUp"
                                              ? "Passengers"
                                              : "Dropped",
                                          selected: selected)),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selected = !selected;
                                      });
                                    },
                                    child: switchButtonWidget(
                                        title: tripType == "PickUp"
                                            ? "Upcoming"
                                            : "Passengers",
                                        selected: !selected),
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

                                    return studentIdBox(
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
                                    fontColor: black))
                                : SizedBox(
                              height: divHeight * 0.65,
                              child: ListView.builder(
                                  itemCount: reversedDroplocations.length,
                                  itemBuilder: (context,i){ return ListView.builder(
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
                                      ? reversedDroplocations[i]==data["droplocation"] ? studentIdBox(
                                    checked: false,
                                    passengerDetails: data,
                                    uid: userId,
                                  )
                                      : const SizedBox():const SizedBox();
                                },
                              );
                              }
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
    );
    }


  studentIdBox({
    required Map passengerDetails,
    required bool checked,
    required String uid,
  }) {
    // final user = Provider.of<User?>(context);
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
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
                        fontColor: black),
                    textWidget(
                        text: passengerDetails["studentId"],
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
                        text: passengerDetails["droplocation"],
                        fontWeight: FontWeight.w500,
                        fontsize: divHeight * 0.017,
                        fontColor: blue),

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
                          color: black,
                        ),
                        onPressed: () async {
                          await dbservice.addPassengersInTodaysDate(
                              uid: uid,
                              uploadPassengerDetails: passengerDetails,
                              uploadTripType: tripType!);
                        },
                      ),
                    checked
                        ? IconButton(
                            onPressed: () async {
                              // print(currentPassengersDocuments);
                              await dbservice.deletePassengerFromList(
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
                              color: red,
                            ))
                        : const Text(""),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  switchButtonWidget({required String title, required bool selected}) {
    return Container(
      height: divHeight * 0.06,
      width: divWidth * 0.447,
      decoration: BoxDecoration(
          color: selected ? blue : Colors.transparent,
          borderRadius: BorderRadius.circular(9)),
      child: Center(
        child: textWidget(
            text: title,
            fontWeight: FontWeight.w700,
            fontsize: divHeight * 0.017,
            fontColor: selected ? white : black),
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
            backgroundColor: chipName == "PickUp" ? green : red,
            label: textWidget(
                text: chipName,
                fontWeight: FontWeight.w500,
                fontsize: divHeight * 0.017,
                fontColor: white)),
      );
}

