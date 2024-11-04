import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:flutter/material.dart';

message({
  required BuildContext context,
  required String Content,
  required double fontSize,
  required Color fontColor,
  required Color BarColor,

}) {
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor:BarColor , // Custom background color
          behavior: SnackBarBehavior.floating, // Float the snackbar
          //margin: EdgeInsets.only(top: 50, left: 20, right: 20), // Position it at the top
          duration: const Duration(seconds: 3),
          content: textWidget(text: Content, fontWeight:FontWeight.w500, fontsize:fontSize , fontColor: fontColor))
  );
}