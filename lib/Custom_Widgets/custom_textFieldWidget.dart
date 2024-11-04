import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

textFieldWidget({
  required String hintText,
  required  dynamic control,
  OnClick,
  bool? readonly,
  double? size,
  dynamic? suffixIcon,
  dynamic? prefix,
  dynamic? prefixIcon,
  TextInputType? textfieldType,
  void Function(dynamic?)? onsubmit,
}) async => TextField(
  onSubmitted: onsubmit,
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
