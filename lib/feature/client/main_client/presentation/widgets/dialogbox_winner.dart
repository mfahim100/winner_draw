import 'dart:ui';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_strings.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/default_button.dart';
import '../../../../admin/main_admin/domain/entities/model_results.dart';
import '../manager/main_nav_client_controller.dart';

class WinnerDialogBox extends StatelessWidget {
  final ModelResults prize;

  WinnerDialogBox({super.key, required this.prize});
  final mainController = sl<MainNavClientController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(5.w),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.w)), //this right here
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.2)),
                  child: Column(
                    children: [
                      //
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child:   GestureDetector(
                      //     onTap: () {
                      //       print("Clossssssed");
                      //       mainController.closeConfitte();
                      //       Get.back();
                      //       // Navigator.pop(context);
                      //     },
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
                        "Congratulations on",
                        textStyle: NeumorphicTextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                        style: const NeumorphicStyle(color: Colors.white),
                      ),
                      NeumorphicText(
                        "WINNING",
                        textStyle: NeumorphicTextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold),
                        style: const NeumorphicStyle(color: Colors.amber),
                      ),
                      NeumorphicText(
                        "Rs 5 Offer",
                        textStyle: NeumorphicTextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                        style: const NeumorphicStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      NeumorphicText(
                        prize.prizeNo == 1
                            ? '1st Prize'
                            : prize.prizeNo == 2
                                ? '2nd Prize'
                                : prize.prizeNo == 3
                                    ? '3rd Prize'
                                    : '1st Prize',
                        textStyle: NeumorphicTextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                        style: const NeumorphicStyle(color: Colors.amber),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        height: 20.h,
                        child: Image.network(
                          "${ConstString.baseUrlImage}${prize.imgUrl!}",
                          height: 30.h,
                          width: 50.w,
                        ),
                      ),

                      SizedBox(
                        height: 1.h,
                      ),
                      NeumorphicText(
                        prize.title!,
                        textStyle: NeumorphicTextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                        style: const NeumorphicStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      NeumorphicText(
                        prize.name!,
                        textStyle: NeumorphicTextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                        style: const NeumorphicStyle(color: Colors.white),
                      ),
                      NeumorphicText(
                        "${prize.phone!.substring(0, 4)}XXX${prize.phone!.substring(7)}",
                        textStyle: NeumorphicTextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                        style: const NeumorphicStyle(color: Colors.white),
                      ),
                 SizedBox(height: 2.h,),
                      GestureDetector(
                        // onTap: () {
                        //   mainController.closeConfitte();
                        //   Get.back();
                        //   // Navigator.pop(context);
                        // },
                        child: prize.userImg == null || prize.userImg!.isEmpty
                            ? CircleAvatar(
                                radius: 10.w,
                                backgroundImage: const AssetImage(
                                    'assets/images/task_placeholder.png'))
                            : CircleAvatar(
                                radius: 10.w,
                                backgroundImage: NetworkImage(
                                    "${ConstString.baseUrlImage}${prize.userImg!}")),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      DefaultButton(
                        clr: Colors.red,
                        isFixed: true,
                          text: "Close",
                          onPressed: () {
                            mainController.closeConfitte();
                            Get.back();
                          }),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            gravity: 0,
            particleDrag: .01,
            maxBlastForce: 30,
            emissionFrequency: .1,
            confettiController: mainController.controllerCenter,
            blastDirectionality: BlastDirectionality.explosive,
            // don't specify a direction, blast randomly
            shouldLoop: true,
            // start again as soon as the animation is finished
            colors: const [
              Colors.amberAccent,
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
            ],
            // manually specify the colors to be used
            createParticlePath:
                mainController.drawStar, // define a custom shape/path.
          ),
        )
      ],
    );
  }
}
