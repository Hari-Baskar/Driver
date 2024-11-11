import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Custom_Widgets/custom_Button.dart';
import 'package:driver/Custom_Widgets/custom_appBar.dart';
import 'package:driver/Custom_Widgets/custom_snackBar.dart';
import 'package:driver/Custom_Widgets/custom_textFieldWidget.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:driver/Pojo/vechileDetails_Pojo.dart';
import 'package:driver/Screens/bottom_bar.dart';
import 'package:driver/Services/db_Service.dart';
import 'package:driver/userManagement/signup.dart';
import 'package:driver/Services/auth_Service.dart';

import 'package:flutter/material.dart';
class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  late double divHeight,divWidth;
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  AuthService authService=AuthService();
  VechileDetails vechileDetails=VechileDetails();
  DBService dbService=DBService();
  @override
  Widget build(BuildContext context) {
    divHeight=MediaQuery.of(context).size.height;
    divWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: appBarWidget(fontsize:divHeight*0.02 , title: 'Login'),
      body:SingleChildScrollView(

        child: Padding(padding: const EdgeInsets.all(15),child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("Assets/signInImg.png",height: divHeight*0.35,fit: BoxFit.cover,),
            SizedBox(height: divHeight*0.02,),
            textFieldWidget(hintText: "Enter your email", control: email,prefixIcon: const Icon(Icons.mail_outline_rounded,color: borderColor,)),
            SizedBox(height: divHeight*0.02,),
            textFieldWidget(hintText: "Enter your password", control: password,prefixIcon: const Icon(Icons.key_rounded,color: borderColor,)),
            SizedBox(height: divHeight*0.04,),
            InkWell(
              onTap: signInUser,

              child:buttonWidget(buttonName: "Login", buttonWidth: divWidth*0.45, buttonColor: primaryColor, fontSize: divHeight*0.017, fontweight: FontWeight.w500, fontColor: secondaryColor),),
            SizedBox(height: divHeight*0.06,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(text: "Don't have an account?  ", fontWeight: FontWeight.normal, fontsize: divHeight*0.019, fontColor: borderColor),
                InkWell(onTap:(){
                  Navigator.pop(context, MaterialPageRoute(builder: (context)=>const Signup()));
                },child:textWidget(text: "SignUp", fontWeight: FontWeight.bold, fontsize: divHeight*0.019, fontColor: primaryColor),)


              ],
            ),
          ],
        ),),
      ) ,
    );
  }
  signInUser() async{
    try {
      String uid =await  authService.loginUser(
        userEmail: email.text, userPassword: password.text,);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const BottomBar()));
    }
    on FirebaseException catch (e){
      message(context: context, Content: e.code.toString(), fontSize: divHeight*0.017, fontColor:secondaryColor , BarColor: Colors.red);
    }
  }
}


/*
 Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                tex
                Text("Don't have an account ?",style: TextStyle(

                  fontSize: height*0.019,

                ),),
                TextButton(
                  onPressed: () {
                    // Navigate to Sign Up screen
                 //   Get.off(()=>SignUp(),transition: Transition.rightToLeft);
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: height*0.019,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
 */