import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:flutter/material.dart';

appBarWidget({
  required String title,
  required double fontsize,
})=>
    AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white, // Change the drawer icon color to white
      ),
      backgroundColor: const Color(0xFF00A0E3),
      centerTitle: true,
      title: textWidget(text: title, fontWeight: FontWeight.bold, fontsize: fontsize, fontColor: Colors.white),

    );