
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/const_styles.dart';
import '../../../../core/utils/injections.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../manager/auth_controller.dart';
import '../widgets/password_textfield.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});


  final  controller=sl<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ConstColors.kBGColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 7.h),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Password Reset',
                      style: ConstStyle.headerTextStyle,
                    ),
                  )
                ],
              ),
              SizedBox(height: 3.h),

              Center(
                child: Hero(
                  tag: 'forImage',
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal:15.w),
                    child: Image.asset(
                      'assets/images/app_logo.png',
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10.h),
              Form(
                key: controller.changePasswordKey,
                child: Column(children: [
                  Text(
                    'Change Password',
                    style: ConstStyle.headerTextStyle,
                  ),
                  SizedBox(height: 3.h,),
                  Container( padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15.sp)),
                    child: Column(children: [

                      CustomTextField(
                          validator: controller.validateEmailField,
                          text: 'Email',
                          hintText: 'Email',
                          controller: controller.changePasswordEmailController,
                          prefix: const Icon(Icons.alternate_email),
                          obscureText: false,
                          textInputType: TextInputType.emailAddress),
                      SizedBox(height: 1.h,),
                      PasswordTextField(
                          validator: controller.validatePasswordField,
                          text: 'Old Password',
                          hintText: 'Old Password',
                          controller: controller.oldPasswordController,
                          prefix: const Icon(Icons.lock),
                          isPass: true,
                          textInputType: TextInputType.text),
                      SizedBox(height: 1.h,),
                      PasswordTextField(
                          validator: controller.validateConfirmNewPasswordField,
                          text: 'New Password',
                          hintText: 'New Password',
                          controller: controller.newPasswordController,
                          prefix: const Icon(Icons.lock),
                          isPass: true,
                          textInputType: TextInputType.text),

                      SizedBox(height: 2.h),
                      Hero(
                        tag: 'forSubmit',
                        child: DefaultButton(
                            text: 'Change Password',
                            onPressed: ()
                            => controller.changePassword(context)
                        ),
                      ),

                    ],),)

                ],),
              ),

              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}