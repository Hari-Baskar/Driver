import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Commons/common_Colors.dart';

import 'package:driver/Custom_Widgets/custom_Button.dart';
import 'package:driver/Custom_Widgets/custom_snackBar.dart';
import 'package:driver/Custom_Widgets/custom_textFieldWidget.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';

import 'package:driver/Screens/bottom_bar.dart';

import 'package:driver/Services/db_Service.dart';
import 'package:driver/student/showRoute.dart';
import 'package:driver/userManagement/sigin.dart';
import 'package:driver/Services/auth_Service.dart';
import 'package:flutter/material.dart';

import '../Custom_Widgets/custom_appBar.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late double divHeight, divWidth;
  TextEditingController name = TextEditingController();
  TextEditingController vechileId = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthService authService = AuthService();
 // VechileDetails vechileDetails = VechileDetails();
  Map vechileDetails={};
  DBService dbService = DBService();

  @override
  Widget build(BuildContext context) {
    divHeight = MediaQuery.of(context).size.height;
    divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: appBarWidget(fontsize: divHeight * 0.02, title: 'Sign Up'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "Assets/signupImg.png",
                height: divHeight * 0.35,
              ),
              SizedBox(
                height: divHeight * 0.02,
              ),
              textFieldWidget(
                  hintText: "Enter Driver Name",
                  control: name,
                  prefixIcon: const Icon(
                    Icons.person_outlined,
                    color: black,
                  )),
              SizedBox(
                height: divHeight * 0.02,
              ),
              textFieldWidget(
                  hintText: "Vechile Id or Number",
                  control: vechileId,
                  prefixIcon: const Icon(
                    Icons.perm_device_information_rounded,
                    color: black,
                  )),
              SizedBox(
                height: divHeight * 0.02,
              ),
              textFieldWidget(
                  hintText: "Enter your email",
                  control: email,
                  prefixIcon: const Icon(
                    Icons.mail_outline_rounded,
                    color: black,
                  )),
              SizedBox(
                height: divHeight * 0.02,
              ),
              textFieldWidget(
                  hintText: "Enter your password",
                  control: password,
                  prefixIcon: const Icon(
                    Icons.key_rounded,
                    color: black,
                  )),
              SizedBox(
                height: divHeight * 0.04,
              ),
              InkWell(
                onTap: signUpDetails,
                child: buttonWidget(
                    buttonName: "SignUp",
                    buttonWidth: divWidth * 0.45,
                    buttonColor: blue,
                    fontSize: divHeight * 0.017,
                    fontweight: FontWeight.w500,
                    fontColor: white),
              ),
              SizedBox(
                height: divHeight * 0.04,
              ),
              InkWell(
                onTap: ()async{
                  String uid = await authService.signUpUser(
                    userEmail: email.text,
                    userPassword: password.text,
                  );
                   await FirebaseFirestore.instance.collection("students").doc(uid).set({
        "studentName":name.text,
        "studentId":vechileId.text,
        "assignedVechile":false,
        "pickdrop":true,
        "classAndSec":"X-c",
        "uid":uid,

      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ShowRoute()));
                },
                child: buttonWidget(
                    buttonName: "SignUp Student",
                    buttonWidth: divWidth * 0.45,
                    buttonColor: blue,
                    fontSize: divHeight * 0.017,
                    fontweight: FontWeight.w500,
                    fontColor: white),
              ),
              SizedBox(
                height: divHeight * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(
                      text: "Already have an account?  ",
                      fontWeight: FontWeight.normal,
                      fontsize: divHeight * 0.019,
                      fontColor: black),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signin()));
                    },
                    child: textWidget(
                        text: "Login",
                        fontWeight: FontWeight.bold,
                        fontsize: divHeight * 0.019,
                        fontColor: blue),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  signUpDetails() async {
    vechileDetails["vechileID"] = vechileId.text;
    vechileDetails["email"] = email.text;
    vechileDetails["driverName"] = name.text;
    vechileDetails["pertolAllowanceAmount"] = 0;
    vechileDetails["vechileServiceAmount"] = 0;

    try {
      String uid = await authService.signUpUser(
        userEmail: email.text,
        userPassword: password.text,
      );
     /* await FirebaseFirestore.instance.collection("students").doc(vechileDetails.uid).set({
        "studentName":name.text,
        "studentId":vechileId.text,
        "assignedVechile":false,
        "pickdrop":true,
        "classAndSec":"X-c",
        "uid":vechileDetails.uid,

      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ShowRoute()));*/
      vechileDetails["uid"]=uid;
      await dbService.createUserWithDetails(vechileDetails:vechileDetails);
     Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const BottomBar()));
    } on FirebaseException catch (e) {
      message(
          context: context,
          Content: e.code.toString(),
          fontSize: divHeight * 0.017,
          fontColor: white,
          BarColor: red);
    }
  }
}
