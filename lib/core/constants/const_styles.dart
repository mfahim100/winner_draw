import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'const_colors.dart';

class ConstStyle {
  static var buttonTextStyle = TextStyle(
      color: ConstColors.kButtonTextColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.w700);
  static var headerTextStyle = TextStyle(
      color: ConstColors.kTextFieldBGColor,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold);

  static var tileTitleTextStyle = TextStyle(
      color: ConstColors.kTextFieldBGColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.bold);

  static var prizeContainerTextStyles = TextStyle(
      color: ConstColors.kTextFieldBGColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.bold);


  static var tileSubTitleTextStyle = TextStyle(
      color: ConstColors.kWhiteTextColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.normal);



  static var titleTextStyle = GoogleFonts.lato(
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: 16.sp,
      decoration: TextDecoration.none);

  static var requestContainerText = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 16.sp

  );


  static var requestContainerButton = TextStyle(
      color: ConstColors.kButtonTextColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400);


}
