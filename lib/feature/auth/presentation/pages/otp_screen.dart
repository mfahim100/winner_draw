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
import '../../../client/main_client/presentation/widgets/dialogbox_otp_resend.dart';
import '../manager/auth_controller.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({
    super.key,
  });

  final controller = sl<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ConstColors.kBGColor,
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 2.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 3.h),
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
                Form(
                  key: controller.forgetFormKey,
                  child: Column(
                    children: [
                      Text(
                        'Enter OTP',
                        style: ConstStyle.headerTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'We have successfully send  an OTP to this email address ',
                          textAlign: TextAlign.center,
                          style: ConstStyle.tileTitleTextStyle,
                        ),
                      ),
                      Text(
                        GetStorage().read("email"),
                        style: ConstStyle.buttonTextStyle.copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        padding: EdgeInsets.all(5.w),
                        width: 95.w,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15.sp)),
                        child: Column(
                          children: [
                            OTPTextField(
                              spaceBetween: 2.w,
                              keyboardType: TextInputType.number,
                              outlineBorderRadius: 2.w,
                              otpFieldStyle: OtpFieldStyle(
                                  borderColor: Colors.black,
                                  focusBorderColor: Colors.black,
                                  disabledBorderColor: Colors.black,
                                  enabledBorderColor: Colors.black,
                                  errorBorderColor: Colors.black),
                              fieldStyle: FieldStyle.box,
                              length: 6,
                              width: MediaQuery.of(context).size.width,
                              fieldWidth: 11.w,
                              style:
                                  TextStyle(fontSize: 20.sp, color: Colors.black),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              onCompleted: (pin) {
                                print("Completed: $pin");
                                controller.isOTPComplete.value = true;
                                controller.opt.value = int.parse(pin);
                              },
                            ),
                            SizedBox(height: 4.h),
                            Hero(
                              tag: 'forSubmit',
                              child: DefaultButton(
                                text: 'Submit',
                                onPressed: () => controller.verifyOTP(context),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Didn't receive Otp? ",
                                  style: ConstStyle.tileTitleTextStyle,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.reSendOTP();
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            OtpResendDialogBox());
                                  },
                                  child: Text(
                                    'Resend',
                                    style: ConstStyle.tileTitleTextStyle.copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.black),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
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
