import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Commons/constant_strings.dart';
import 'package:driver/Custom_Widgets/custom_Button.dart';
import 'package:driver/Custom_Widgets/custom_appBar.dart';
import 'package:driver/Custom_Widgets/custom_textFieldWidget.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:driver/Screens/detailed_history.dart';
import 'package:driver/Services/db_Service.dart';
import 'package:driver/userManagement/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool selected = true;
  late double divHeight, divWidth;
  TextEditingController fromdate = TextEditingController();
  TextEditingController todate = TextEditingController();
  DBService dbService = DBService();

  setDate({
    required TextEditingController control,
  }) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(3000)) as DateTime?;
    if (picked != null) {
      setState(() {
        control.text = DateFormat("dd-MM-yyyy").format(picked);
      });
    }
  }

  String? select = "Yesterday";

  @override
  Widget build(BuildContext context) {
    divHeight = MediaQuery.of(context).size.height;
    divWidth = MediaQuery.of(context).size.width;
    final user = Provider.of<User?>(context);
    String userId = user!.uid;
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: appBarWidget(title: history, fontsize: divHeight * 0.02),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                spacing: divHeight * 0.01,
                children: [
                  chipButton(chipName: "Yesterday"),
                  chipButton(chipName: "Today"),
                  chipButton(chipName: "Custom"),
                  chipButton(chipName: "All")
                ],
              ),
              SizedBox(
                height: divHeight * 0.02,
              ),
              select == "Custom"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                          SizedBox(
                              width: divWidth * 0.45,
                              child: textFieldWidget(
                                  suffixIcon: const Icon(
                                    Icons.calendar_month_sharp,
                                  ),
                                  hintText: "From",
                                  control: fromdate,
                                  readonly: true,
                                  OnClick: () async {
                                    await setDate(control: fromdate);
                                  })),
                          SizedBox(
                              width: divWidth * 0.45,
                              child: textFieldWidget(
                                  suffixIcon:
                                      const Icon(Icons.calendar_month_sharp),
                                  hintText: "To",
                                  control: todate,
                                  readonly: true,
                                  OnClick: () async {
                                    await setDate(control: todate);
                                  })),
                        ])
                  : SizedBox(),
              SizedBox(
                height: divHeight * 0.02,
              ),
              select == "All"
                  ? SizedBox(
                height: divHeight*0.9,
                  child:StreamBuilder(
                      stream: dbService.showHistory(uid: userId,historyType: "All"),
                      builder: (context, snapshots) {
                        if (!snapshots.hasData) return Loading();

                        List<DocumentSnapshot> documentSnapshots =snapshots.data!.docs;

                        return ListView.builder(
                          shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return viewBox(
                                  docId: documentSnapshots[index].id, userUid: userId);
                            },
                            itemCount: documentSnapshots.length);
                      }))
                  : select == "Custom"
                      ? fromdate.text.isNotEmpty && todate.text.isNotEmpty
                          ? StreamBuilder(
                              stream: dbService.showHistory(
                                  uid: userId,
                                  fromDateStream: fromdate.text,
                                  toDateStream: todate.text),
                              builder: (context, snapshots) {
                                if (!snapshots.hasData) return Loading();
                                List<DocumentSnapshot> documentSnapshots =
                                    snapshots.data.docs;

                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return viewBox(
                                          docId: documentSnapshots[index].id, userUid: userId);
                                    },
                                    itemCount: documentSnapshots.length);
                              })
                          : Center(
                              child: textWidget(
                                  text: "Please Select From date and To date",
                                  fontWeight: FontWeight.w500,
                                  fontsize: divHeight * 0.017,
                                  fontColor: borderColor))
                      : StreamBuilder(
                          stream: dbService.showHistoryOnlyGivenDate(
                              uid: userId,
                              givenDate:select=="Today" ? date:yesterdayDate),

                          builder: (context, snapshots) {
                            if (!snapshots.hasData) return Loading();
                            if(snapshots.hasData!={}) {
                              Map<dynamic, dynamic> documentSnapshots =
                              snapshots.data!;
                              if (documentSnapshots.isNotEmpty) {
                                return viewBox(docId: select=="Today" ? date:yesterdayDate, userUid: userId);
                              }

                            }
                            return Center(
                                child: textWidget(
                                    text: "No Documents Found",
                                    fontWeight: FontWeight.w500,
                                    fontsize: divHeight * 0.017,
                                    fontColor: borderColor));
                          }),
              SizedBox(
                height: divHeight * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container switchButtonWidget(
          {required String title, required bool Selected}) =>
      Container(
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
              fontColor: Selected ? Colors.white : Colors.black),
        ),
      );

  viewBox({required String docId,
  required String userUid,
  }) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1.0)),
          child: ListTile(
              title: textWidget(
                  text: docId,
                  fontWeight: FontWeight.w500,
                  fontsize: divHeight * 0.017,
                  fontColor: Colors.black),
              trailing: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailedHistory(docId: docId, uid: userUid,)));
                  },
                  child: textWidget(
                    text: 'View Details',
                    fontWeight: FontWeight.w500,
                    fontsize: divHeight * 0.017,
                    fontColor: primaryColor,
                  ))),
        ));
  }

  chipButton({
    required String chipName,
  }) =>
      InkWell(
        onTap: () {
          if (select != chipName) {
            setState(() {
              select = chipName;
            });
          }
        },
        child: Chip(
            backgroundColor: select == chipName ? primaryColor : secondaryColor,
            label: textWidget(
                text: chipName,
                fontWeight: FontWeight.w500,
                fontsize: divHeight * 0.017,
                fontColor: select == chipName ? secondaryColor : borderColor)),
      );
}
