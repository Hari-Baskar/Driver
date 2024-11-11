import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Commons/constant_strings.dart';
import 'package:driver/Custom_Widgets/custom_Button.dart';
import 'package:driver/Custom_Widgets/custom_appBar.dart';
import 'package:driver/Custom_Widgets/custom_textFieldWidget.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: secondaryColor,
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
                      fontColor: Colors.black),
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
              buttonWidget(
                  buttonName: "Send to parents and school",
                  buttonWidth: divWidth * 0.7,
                  buttonColor: absentColor,
                  fontSize: divHeight * 0.017,
                  fontweight: FontWeight.w500,
                  fontColor: secondaryColor),
              SizedBox(
                height: divHeight * 0.02,
              ),
              buttonWidget(
                  buttonName: " send only school",
                  buttonWidth: divWidth * 0.4,
                  buttonColor: absentColor,
                  fontSize: divHeight * 0.017,
                  fontweight: FontWeight.w500,
                  fontColor: secondaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
