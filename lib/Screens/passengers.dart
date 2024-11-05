import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Commons/constant_strings.dart';
import 'package:driver/Custom_Widgets/custom_Button.dart';
import 'package:driver/Custom_Widgets/custom_appBar.dart';
import 'package:driver/Custom_Widgets/custom_textFieldWidget.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:flutter/material.dart';

class Passengers extends StatefulWidget {
  const Passengers({super.key});

  @override
  State<Passengers> createState() => _PassengersState();
}

class _PassengersState extends State<Passengers> {
  bool checked = true;
  late double divHeight, divWidth;
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

  @override
  Widget build(BuildContext context) {
    divHeight = MediaQuery.of(context).size.height;
    divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBarWidget(title: passengers, fontsize: divHeight * 0.02),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
                    border: Border.all(width: 1.0, color: primaryColor),
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
                            title: "Passengers", Selected: selected)),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selected = !selected;
                        });
                      },
                      child: SwitchButtonWidget(
                          title: "Upcoming", Selected: !selected),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: divHeight * 0.02,
              ),
              selected
                  ? SizedBox(
                      height: divHeight * 0.55,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: divHeight * 0.02,
                          );
                        },
                        shrinkWrap: true,
                        itemCount: passenger.length,
                        itemBuilder: (context, index) {
                          return StudentIdBox(
                              studentName: passenger[index]["studentName"],
                              classAndSec: passenger[index]["classAndSec"],
                              studentId: passenger[index]["studentId"],
                              checked: passenger[index]["checked"],
                              index: index);
                        },
                      ))
                  : SizedBox(
                      height: divHeight * 0.65,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: divHeight * 0.02,
                          );
                        },
                        shrinkWrap: true,
                        itemCount: upcoming.length,
                        itemBuilder: (context, index) {
                          return StudentIdBox(
                              studentName: upcoming[index]["studentName"],
                              classAndSec: upcoming[index]["classAndSec"],
                              studentId: upcoming[index]["studentId"],
                              checked: upcoming[index]["checked"],
                              index: index);
                        },
                      ),
                    ),
              SizedBox(
                height: divHeight * 0.1,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: selected
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: divWidth * 0.04,
                    ),
                    textWidget(
                        text: "Count : 23",
                        fontWeight: FontWeight.bold,
                        fontsize: divHeight * 0.02,
                        fontColor: Colors.green),
                    const Spacer(),
                    FloatingActionButton.extended(
                        backgroundColor: primaryColor,
                        onPressed: () {},
                        label: InkWell(
                            onTap: () {},
                            child: buttonWidget(
                                buttonName: "Submit All",
                                buttonWidth: divWidth * 0.4,
                                buttonColor: primaryColor,
                                fontSize: divHeight * 0.017,
                                fontweight: FontWeight.w500,
                                fontColor: secondaryColor)))
                  ]))
          : null,
    );
  }

  StudentIdBox({
    required String studentName,
    required String classAndSec,
    required String studentId,
    required bool checked,
    required int index,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(
                    text: studentName,
                    fontWeight: FontWeight.w500,
                    fontsize: divHeight * 0.017,
                    fontColor: borderColor),
                textWidget(
                    text: classAndSec,
                    fontWeight: FontWeight.w500,
                    fontsize: divHeight * 0.017,
                    fontColor: Colors.black45),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(
                    text: studentId,
                    fontWeight: FontWeight.w500,
                    fontsize: divHeight * 0.017,
                    fontColor: primaryColor),
                //TextWidget(text: "1.00 pm", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                checked
                    ? const Text("")
                    : IconButton(
                        icon: const Icon(
                          Icons.check_box_outline_blank_rounded,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            // checked=!checked;
                            passenger.insert(0, {
                              "studentName": upcoming[index]["studentName"],
                              "classAndSec": upcoming[index]["classAndSec"],
                              "checked": true,
                              "studentId": upcoming[index]["studentId"]
                            });
                            upcoming.removeAt(index);
                          });
                        },
                      ),
                checked
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            //  Map passen=passenger[index]['checked'];
                            upcoming.insert(0, {
                              "studentName": passenger[index]["studentName"],
                              "classAndSec": passenger[index]["classAndSec"],
                              "checked": false,
                              "studentId": passenger[index]["studentId"]
                            });
                            passenger.removeAt(index);
                          });
                        },
                        icon: const Icon(
                          Icons.delete_outline_outlined,
                          color: Colors.redAccent,
                        ))
                    : const Text(""),
              ],
            ),
          ),
        ],
      ),
    );
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
}
