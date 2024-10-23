import 'dart:ui';
import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/utils/injections.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../client/main_client/presentation/manager/main_nav_client_controller.dart';

class ForgotPassOTPErrorDialogBox extends StatelessWidget {
  ForgotPassOTPErrorDialogBox({super.key});
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
        height: 30.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: 80.w,
              height: 40.h,
              decoration:
                  BoxDecoration(color: Colors.grey.shade200.withOpacity(0.2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  NeumorphicText(
                    "OTP Error",
                    textStyle: NeumorphicTextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                    style: const NeumorphicStyle(color: Colors.white),
                  ),
                  NeumorphicText(
                    "User must put OTP",
                    textStyle: NeumorphicTextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                    style: const NeumorphicStyle(color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: DefaultButton(
                        isFixed: true,
                        text: 'Close',
                        onPressed: () => Navigator.pop(
                            context) //mainController.addParticipant()
                        ),
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
