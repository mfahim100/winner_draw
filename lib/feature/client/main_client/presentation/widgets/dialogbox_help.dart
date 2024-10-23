import 'dart:ui';
import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/controllers/theme_controller.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/default_button.dart';
import '../manager/main_nav_client_controller.dart';

class HelpDialogBox extends StatelessWidget {
  HelpDialogBox({super.key});
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
              width: 200.0,
              height: 200.0,
              decoration:
                  BoxDecoration(color: Colors.grey.shade200.withOpacity(0.2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        Text(
                          'Select Option',
                          style: Get.theme.textTheme.titleMedium!.copyWith(
                            color: sl<ThemeController>().darkTheme.value
                                ? ConstColors.black
                                : ConstColors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: EdgeInsets.all(5.sp),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15.sp)),
                        child: GestureDetector(
                          onTap: () => mainController.callWhatsApp(),
                          child: Image.asset(
                            'assets/images/WhatsApp.svg.webp',
                            height: 40.sp,
                            width: 40.sp,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15.sp)),
                        child: GestureDetector(
                          onTap: () => mainController.callTelegram(),
                          child: Image.asset(
                            'assets/images/telegram.png',
                            height: 40.sp,
                            width: 40.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: DefaultButton(
                        isFixed: true,
                        text: 'Close',
                        onPressed: () => Get.back()),
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
