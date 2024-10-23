import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/default_button.dart';
import '../manager/main_nav_client_controller.dart';


class PaymentEasyPaisaDialogBox extends StatelessWidget {
  PaymentEasyPaisaDialogBox({super.key});
  final mainController = sl<MainNavClientController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(5.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.w)), //this right here
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: 80.w,
              decoration:
                  BoxDecoration(color: Colors.grey.shade200.withOpacity(0.2)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(height: 5.h,),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 16.sp,
                        backgroundColor: Colors.blueGrey,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NeumorphicText(
                          "Easypaisa Wallet Number: 0311-9973012",
                          textStyle: NeumorphicTextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                          style: const NeumorphicStyle(color: Colors.white),
                        ),
                        GestureDetector(


                          onTap: () async {
                            await Clipboard.setData(const ClipboardData(text: "03119973012"));
                            // copied successfully
                          },
                          child: const Icon(Icons.copy_rounded,color: Colors.white,),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NeumorphicText(
                          "Easypaisa Wallet Name: Adnan Khan",
                          textStyle: NeumorphicTextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                          style: const NeumorphicStyle(color: Colors.white),
                        ),

                        GestureDetector(


                          onTap: () async {
                            await Clipboard.setData(const ClipboardData(text: "Adnan Khan"));
                            // copied successfully
                          },
                          child: const Icon(Icons.copy_rounded,color: Colors.white,),
                        )
                      ],
                    ),
                  ),
                  //
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //       vertical: 10.sp, horizontal: 10.sp),
                  //   child: Divider(
                  //     height: 1.sp,
                  //   ),
                  // ),
                  // NeumorphicText(
                  //   "WhatsApp & Telegram Number: 0319-5652436",
                  //   textStyle: NeumorphicTextStyle(
                  //       fontSize: 16.sp, fontWeight: FontWeight.bold),
                  //   style: const NeumorphicStyle(color: Colors.white),
                  // ),

                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 10.sp,horizontal: 10.sp),
                    child: Divider(height: 1.sp,),
                  ),
                  NeumorphicText(
                    " براے مہربانی کر کے اوپر دے گئے ایزی پیسہ نمبر پر 5 روپے جمع کر کے سکرین شاٹ ہمارے ہیلپ سپورٹ ",
                    textStyle: NeumorphicTextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                    style: const NeumorphicStyle(color: Colors.white),
                  ),
                  NeumorphicText(
                    "  Whatsapp یا Telegram ",
                    textStyle: NeumorphicTextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                    style: const NeumorphicStyle(color: Colors.white),
                  ),
                  NeumorphicText(
                    " پرسینڈ کیجئے۔",
                    textStyle: NeumorphicTextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                    style: const NeumorphicStyle(color: Colors.white),
                  ),
                  NeumorphicText(
                    "جس کے بعد ہمارہ نمائندہ اپکی پر چیزنگ کر دیگا۔",
                    textStyle: NeumorphicTextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                    style: const NeumorphicStyle(color: Colors.white),
                  ),


                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.sp, horizontal: 10.sp),
                    child: Divider(
                      height: 1.sp,
                    ),
                  ),
                  NeumorphicText(
                    "نیچے دے گئے بٹن پر کلک کر کے پاک لکی ڈرا کے لئے اپلائی کیجئے۔",
                    textStyle: NeumorphicTextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                    style: const NeumorphicStyle(color: Colors.white),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 10.sp,horizontal: 10.sp),
                    child: Divider(height: 1.sp,),
                  ),
                  NeumorphicText(
                    "توجہ ! براہ مہربانی نوٹ فرمائیں ۔خبر دار! پیارے صارفین جاز کیش اور بینک سے پیمنٹ بھیجنا منع ہے ایزی پیسہ اکاؤنٹ میں صرف ایزی پیسہ اکاؤنٹ کا ہی استعمال کرے۔ ورنہ آپ کی رقم ضائع ہو جاۓ گے ۔جسکے بعد میں کمپنی زمہ دار نہیں ہوگی شکریہ۔",
                    textStyle: NeumorphicTextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                    style: const NeumorphicStyle(color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.sp, horizontal: 10.sp),
                    child: Divider(
                      height: 1.sp,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),

                  Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: DefaultButton(
                        text: 'Apply for Purchase',
                        onPressed: () => mainController.changeStatus()),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
