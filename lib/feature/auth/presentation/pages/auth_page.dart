import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signin_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/constants/const_colors.dart';
import '../../../../core/utils/injections.dart';
import '../manager/auth_controller.dart';
import 'signup_screen.dart';


class AuthPage extends StatelessWidget {
   AuthPage({super.key});

  final  controller=sl<AuthController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isSignIn.value) {
          return true;
        } else {
          controller.toggleSignIn();
          return false;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ConstColors.kBGColor,
        body:
        // Padding(
          // padding: EdgeInsets.symmetric(horizontal: 5.w),
          // child:
          Obx(
            () => AnimatedSwitcher(
              switchInCurve: Curves.easeIn,
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: controller.isSignIn.value
                  ?  SignInScreen()
                  :  SignUpScreen(),
            ),
          ),
        ),
      // ),
    );
  }
}
