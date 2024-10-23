import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConstColors {
  /// FixedColors

  static const Color kBGColor = Color(0xFF100F1F);

  static Color  kSecondaryColor= const Color(0xffcad3c6);
  static Color kPrimaryColor = const Color(0xff373A36);
  static Color kButtonColor1 = const Color(0xffFB92CF);
  static Color kButtonColor2 = const Color(0xffB490FC);

  static LinearGradient kButtonBG = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [kButtonColor1, kButtonColor2]);

  static const Color colorTextLight = Color(0xFF434341);
  static const Color colorTextDark = Color(0xFFE9EDF0);
  // static const Color colorBackgroundLight = Color(0xFFF7F1E4);
  static const Color colorBackgroundLight = Color(0xFF4d5458);
  static const Color colorBackgroundDark = Color(0xFF4d5458);
  static const Color colorForegroundLight = Color(0xffa6a9ab);
  static const Color colorForegroundDark = Color(0xffa6a9ab);

  static const Color lightShadowLight = Color(0xFFFFFFFF);
  static Color lightShadowDark = const Color(0xFF000000).withOpacity(.5);
  static Color darkShadowLight = const Color(0xFFFFFFFF).withOpacity(.5);
  static const Color darkShadowDark = Color(0xFF000000);

  /// FixedColors

  static Color kButtonBrownColor = const Color(0xFF5F34A7);
  static Color kButtonTextColor = const Color(0xffffffff);
  static Color kWhiteTextColor = const Color(0xffffffff);
  static Color kTextFieldBGColor = const Color(0xff0F0F1F);

  // Custom Color
  static final Color blue = HexColor('75BDFF');
  static final Color darkBlue = HexColor('576EE6');
  static final Color teal = HexColor('67DEB3');
  static final Color darkTeal = HexColor('37B899');
  static final Color cyan = HexColor('43DBE5');
  static final Color pink = HexColor('FF4F75');
  static final Color orange = HexColor('FDA14D');
  static final Color lightOrange = HexColor('F5CC79');
  static final Color purple = HexColor('9B5DCE');
  static final Color white = HexColor('FFFFFF');
  static final Color black = HexColor('000000');




  static const Color p1Color = Color(0xFF243D66);
  static const Color p2Color = Color(0xFF315287);
  static const Color p3Color = Color(0xFF3C65A8);
  static const Color p4Color = Color(0xFF4F84DA);




  static const Color cardBgColor = Color(0xff363636);
  static const Color cardBgLightColor = Color(0xff999999);
  static const Color colorB58D67 = Color(0xffB58D67);
  static const Color colorE5D1B2 = Color(0xffE5D1B2);
  static const Color colorF9EED2 = Color(0xffF9EED2);
  static const Color colorEFEFED = Color(0xffEFEFED);


  static final BoxDecoration profileTileDecoration=BoxDecoration(
    gradient: profileGradient,
    borderRadius: BorderRadius.circular(5.w),
    boxShadow: [
      BoxShadow(color: Colors.grey.shade100.withOpacity(.5),
          blurRadius: 10,
          spreadRadius: 2,
          offset: const Offset(1,3))
    ],

  );
  static const LinearGradient profileGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.repeated,
      colors: [
        p1Color,
        p2Color,
        p3Color,
        p4Color,
      ]);
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
