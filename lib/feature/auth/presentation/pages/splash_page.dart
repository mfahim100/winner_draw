import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:upgrader/upgrader.dart';

import '../../../../core/constants/const_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: Scaffold(
        backgroundColor: ConstColors.white,
        body: Padding(
          padding:  EdgeInsets.only(right:10.w),
          child: Center(
            child: Image.asset(
            'assets/images/app_logo.png',
            fit: BoxFit.contain,
          ),),
        ),
      ),
    );
  }
}
