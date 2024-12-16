import 'package:driver/Screens/bottom_bar.dart';
import 'package:driver/student/locationPickerScreen.dart';
import 'package:driver/student/showRoute.dart';
import 'package:driver/userManagement/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CheckAuth extends StatefulWidget {
  const CheckAuth({super.key});

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User?>(context);
   // print(user);
    if(user!=null){
     // return ShowRoute();
      return const BottomBar();

    }
    return const Signup();
  }
}
