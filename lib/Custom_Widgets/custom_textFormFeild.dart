import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

textFormFieldWidget({
  required String hintText,
  required  dynamic control,
  OnClick,
  bool? readonly,
  double? size,
  dynamic? suffixIcon,
  dynamic? prefix,
  dynamic? prefixIcon,
  required validateFunction,
  TextInputType? textfieldType,

}) => TextFormField(
  validator:validateFunction,

  keyboardType: textfieldType,
  onTap: OnClick,
  controller: control,
  readOnly: readonly ?? false,
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
