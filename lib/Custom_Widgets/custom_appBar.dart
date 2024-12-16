import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:flutter/material.dart';

appBarWidget({
  required String title,
  required double fontsize,
  dynamic? actions,
  bool? drawer


})  =>

    AppBar(
      iconTheme:  const IconThemeData(
        color: white, // Change the drawer icon color to white
      ),
      backgroundColor: blue,
        automaticallyImplyLeading: drawer!=null ? true :false,
      centerTitle: true,
      title: textWidget(text: title, fontWeight: FontWeight.bold, fontsize: fontsize, fontColor: white),
      actions: actions
    );

//show to parents
//route coverage
//