import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:flutter/material.dart';

buttonWidget({required String buttonName,
  required double buttonWidth,
  required Color  buttonColor,
  required dynamic fontSize,
  required FontWeight fontweight,
  required Color  fontColor,
  Color? borderColor


}){
  return
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border:Border.all(color:borderColor ?? buttonColor ),
          color: buttonColor
      ),
      width:buttonWidth ,
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 10),
        child:Center(child: textWidget(text: buttonName, fontsize: fontSize, fontWeight: fontweight, fontColor: fontColor, Spacing: null)
        ),

      ),

    );
}