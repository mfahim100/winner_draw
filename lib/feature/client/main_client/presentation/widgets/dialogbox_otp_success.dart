import 'dart:ui';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/default_button.dart';
import '../../../../auth/presentation/manager/auth_controller.dart';

class OtpSuccessDialogBox extends StatelessWidget {
  final String msg;
  final Function() onTap;
  OtpSuccessDialogBox({super.key,  this.msg="Your account has been successfully created", required this.onTap});
  final authController = sl<AuthController>();

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
              width: 200.0,
              height: 200.0,
              decoration:
                  BoxDecoration(color: Colors.grey.shade200.withOpacity(0.2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 5.h,),
                  // GestureDetector(
                  //   onTap: () => Get.back(),
                  //   child: Align(
                  //     alignment: Alignment.topRight,
                  //     child: CircleAvatar(
                  //       radius: 16.sp,
                  //       backgroundColor: Colors.blueGrey,
                  //       child: Icon(
                  //         Icons.close,
                  //         color: Colors.white,
                  //         size: 18.sp,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  NeumorphicText(
                    "Congratulations!!!",
                    textStyle: NeumorphicTextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                    style: const NeumorphicStyle(color: Colors.white),
                  ),
                  NeumorphicText(
                   msg ,
                    textStyle: NeumorphicTextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                    style: const NeumorphicStyle(color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: DefaultButton(
                        isFixed: true,
                        text: 'OK',
                        onPressed: () => onTap()//mainController.addParticipant()
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