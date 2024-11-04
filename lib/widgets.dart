import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
TextWidget({
  required String text,
  required FontWeight fontWeight,
  required double fontsize,
  required Color fontColor,
  double? Spacing,
}){
  return Text(text,style: GoogleFonts.poppins(
    fontSize: fontsize,
    color: fontColor,
    fontWeight: fontWeight,
  letterSpacing: Spacing!=null ? Spacing:null,
  ),

  );
}
TextFieldWidget({
  required String hintText,
  required  dynamic control,
  void Function()? OnClick,
  bool? readonly,
  double? size,
  dynamic? suffixIcon,
  dynamic? prefix,
  dynamic? prefixIcon,
  TextInputType? textfieldType,
  void Function(dynamic?)? onsubmit,
}){
  return TextField(
    onSubmitted: onsubmit,
    keyboardType: textfieldType,
    onTap: OnClick,
    controller: control,
    readOnly: readonly!=null ? readonly :false,
    decoration: InputDecoration(
        hintText:hintText ,
        hintStyle: GoogleFonts.poppins(

          fontSize: size,
        ),


        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefix:  prefix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        )
    ),
  );
}

DropdownButtonFormField<dynamic>  DropDownWidget({required List<dynamic> Items,
  required void Function(dynamic?) Onchange,
  required dynamic lableSize,
  required String hintText,
  required dynamic? Value,
  required void Function() OnClear,
}){

  return DropdownButtonFormField(
    hint: Align(
      alignment: Alignment.center,
      child: Text(
        hintText,
        style: GoogleFonts.poppins(fontSize: lableSize),
      ),

    ),
    decoration:InputDecoration(
      suffixIcon:Value!= null ?  IconButton(onPressed: OnClear, icon: Icon(Icons.clear)):null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),

    ),
    value: Value,

    items: Items.map((e)=>DropdownMenuItem<dynamic>(child: Text(e,style: GoogleFonts.poppins(
        fontSize:lableSize
    ),),
      value:e,
    )).toList(), onChanged: Onchange,)
  ;
}


ButtonWidget({required String buttonName,
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
          border:Border.all(color:borderColor!=null ? borderColor : buttonColor ),
          color: buttonColor
      ),
      width:buttonWidth ,
      child: Padding(padding: EdgeInsets.symmetric(vertical: 10),
        child:Center(child: TextWidget(text: buttonName, fontsize: fontSize, fontWeight: fontweight, fontColor: fontColor, Spacing: null)
        ),

      ),

    );
}
Message({
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
        duration: Duration(seconds: 3),
        content: TextWidget(text: Content, fontWeight:FontWeight.w500, fontsize:fontSize , fontColor: fontColor))
  );
}