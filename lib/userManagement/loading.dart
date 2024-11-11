import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:flutter/material.dart';
class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late double divHeight,divWidth;
  @override
  Widget build(BuildContext context) {
    divHeight=MediaQuery.of(context).size.height;
    divWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(child:textWidget(text: "Loading", fontWeight: FontWeight.bold, fontsize: divHeight*0.02, fontColor: borderColor)),
    );
  }
}
