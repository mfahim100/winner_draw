import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/const_styles.dart';
import '../../../../core/utils/injections.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../manager/auth_controller.dart';
import '../widgets/password_textfield.dart';

class ForgotPassPage extends StatelessWidget {
  ForgotPassPage({super.key});

  final controller = sl<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ConstColors.kBGColor,
        body: Container(
          color: Colors.white,
          height: 100.h,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 2.5.h),
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Forgot Password',
                        style: ConstStyle.headerTextStyle.copyWith(fontSize: 18.5.sp),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 2.5.h),
                Center(
                  child: Hero(
                    tag: 'forImage',
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Image.asset(
                        height: 30.h,
                        width: 80.w,
                        fit: BoxFit.cover,
                        'assets/images/app_logo.png',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Obx(
                  () => controller.isForgot.value
                      ? Form(
                          key: controller.forgetFormKey,
                          child: Column(
                            children: [
                              Text(
                                'Forgot Password',
                                style: ConstStyle.headerTextStyle,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                padding: EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(3.w)),
                                child: Column(
                                  children: [
                                    CustomTextField(
                                        validator: controller.validateEmailField,
                                        text: 'Email',
                                        hintText: 'Email',
                                        controller:
                                            controller.forgotPassEmailController,
                                        prefix: const Icon(Icons.alternate_email),
                                        obscureText: false,
                                        textInputType:
                                            TextInputType.emailAddress),
                                    SizedBox(height: 2.h),
                                    SizedBox(height: 2.h),
                                    Hero(
                                      tag: 'forSubmit',
                                      child: DefaultButton(
                                          text: 'Submit',
                                          onPressed: () => controller
                                              .forgotPassSubmit(context)),
                                    ),
                                    SizedBox(height: 2.h),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      : Form(
                          key: controller.forgetPassFormKey,
                          child: Column(
                            children: [
                              Text(
                                'Enter OTP',
                                style: ConstStyle.headerTextStyle,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'we have successfully send  an OTP to this email address ',
                                  textAlign: TextAlign.center,
                                  style: ConstStyle.tileTitleTextStyle,
                                ),
                              ),
                              Text(
                                GetStorage().read("email"),
                                style: ConstStyle.buttonTextStyle,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                padding: EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15.sp)),
                                child: Column(
                                  children: [
                                    PasswordTextField(
                                        validator:
                                            controller.validatePasswordField,
                                        text: 'New Password',
                                        hintText: 'New Password',
                                        controller:
                                            controller.newPasswordController,
                                        prefix: const Icon(Icons.lock),
                                        isPass: false,
                                        textInputType: TextInputType.text),
                                    SizedBox(height: 2.h),
                                    OTPTextField(
                                      spaceBetween: 2.w,
                                      keyboardType: TextInputType.number,
                                      outlineBorderRadius: 2.w,
                                      otpFieldStyle: OtpFieldStyle(
                                          borderColor: Colors.white,
                                          focusBorderColor: Colors.white,
                                          disabledBorderColor: Colors.white,
                                          enabledBorderColor: Colors.white,
                                          errorBorderColor: Colors.white),
                                      fieldStyle: FieldStyle.box,
                                      length: 6,
                                      width: MediaQuery.of(context).size.width,
                                      fieldWidth: 11.w,
                                      style: TextStyle(
                                          fontSize: 20.sp, color: Colors.white),
                                      textFieldAlignment:
                                          MainAxisAlignment.spaceAround,
                                      onCompleted: (pin) {
                                        print("Completed: $pin");
                                        controller.isOTPComplete.value = true;
                                        controller.opt.value = int.parse(pin);
                                      },
                                    ),
                                    SizedBox(height: 2.h),
                                    SizedBox(height: 2.h),
                                    Hero(
                                      tag: 'forSubmit',
                                      child: DefaultButton(
                                        text: 'Submit',
                                        onPressed: () async {
                                              await controller.passOTP(context);
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     Text(
                                    //       "Didn't receive Otp? ",
                                    //       style: ConstStyle.tileTitleTextStyle,
                                    //     ),
                                    //     GestureDetector(
                                    //       onTap: () {controller.reSendOTP();
                                    //       showDialog(
                                    //           context: context,
                                    //           builder: (context) =>
                                    //               OtpResendDialogBox());},
                                    //       child: Text(
                                    //         'Resend',
                                    //         style: ConstStyle.tileTitleTextStyle.copyWith(
                                    //             decoration: TextDecoration.underline,
                                    //             decorationColor: Colors.white),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
