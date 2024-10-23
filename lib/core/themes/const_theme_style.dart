import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/const_styles.dart';


class ThemeStyles {
  static ThemeData themeData(bool isDarkTheme, BuildContext buildContext) {
    print('ThemeData : $isDarkTheme');
    return isDarkTheme
        ? ThemeData(
            primaryColor: Colors.black,
            brightness: Brightness.dark,
            dividerColor: Colors.black12,
            fontFamily: 'arial',
            textTheme: TextTheme(
              headlineLarge: TextStyle(
                fontFamily: 'arial',
                fontSize: 42.sp,
                fontWeight: FontWeight.w600,
              ),
              headlineMedium: TextStyle(
                fontFamily: 'arial',
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
              ),
              headlineSmall: TextStyle(
                fontFamily: "arial",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              titleLarge: ConstStyle.buttonTextStyle,
              titleMedium: ConstStyle.tileTitleTextStyle,

            ),
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.grey,
              brightness: Brightness.light,

            )
                .copyWith(
                  secondary: const Color(0xff896277),
                  brightness: Brightness.dark,
                )
                .copyWith(background: const Color(0xFF212121)),
          )
        : ThemeData(
            primaryColor: const Color(0xffee8f8b),
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            dividerColor: Colors.white60,
            fontFamily: 'arial',
            textTheme: TextTheme(
              headlineLarge: TextStyle(
                fontFamily: 'arial',
                fontSize: 42.sp,
                fontWeight: FontWeight.w600,
              ),
              headlineMedium: TextStyle(
                fontFamily: 'arial',
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
              ),
              headlineSmall: TextStyle(
                fontFamily: "arial",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              titleLarge: ConstStyle.buttonTextStyle,
              titleMedium: ConstStyle.tileTitleTextStyle,
            ),
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.grey,
              brightness: Brightness.light,
            ).copyWith(
              secondary: const Color(0xff896277),
              brightness: Brightness.light,
            ),
          );
  }
}
