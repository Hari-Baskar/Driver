import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:flutter/material.dart';

appBarWidget({
  required String title,
  required double fontsize,
})  =>

    AppBar(
      iconTheme:  IconThemeData(
        color: secondaryColor, // Change the drawer icon color to white
      ),
      backgroundColor: primaryColor,
      centerTitle: true,
      title: textWidget(text: title, fontWeight: FontWeight.bold, fontsize: fontsize, fontColor: secondaryColor),

    );

//show to parents
//route coverage
//