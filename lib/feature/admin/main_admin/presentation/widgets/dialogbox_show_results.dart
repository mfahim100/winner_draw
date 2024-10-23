import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/constants/const_styles.dart';
import '../../../../../core/controllers/theme_controller.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/default_button.dart';
import '../../../../../core/widgets/prize_tile.dart';
import '../manager/main_nav_admin_controller.dart';

class ShowResultsDialogBox extends StatelessWidget {
  ShowResultsDialogBox({Key? key}) : super(key: key);
  final mainController = sl<MainNavAdminController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(5.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.w)), //this right here
      child: Neumorphic(
        padding: const EdgeInsets.all(8),
        style: NeumorphicStyle(
          color: sl<ThemeController>().darkTheme.value
              ? ConstColors.colorBackgroundDark
              : ConstColors.colorBackgroundLight,
          shadowLightColorEmboss: sl<ThemeController>().darkTheme.value
              ? ConstColors.darkShadowLight
              : ConstColors.lightShadowLight,
          shadowDarkColorEmboss: sl<ThemeController>().darkTheme.value
              ? ConstColors.darkShadowDark
              : ConstColors.lightShadowDark,
          boxShape: NeumorphicBoxShape.roundRect(
            const BorderRadius.all(Radius.circular(28)),
          ),
          depth: -3,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5.h),
              PrizeTile(
                status: 'Pay Now',
                timer:'00:00',
                title: mainController.title1,
                price: mainController.price1,
                file: mainController.file1!,
                no: 1,
                clr: Colors.amberAccent,
                isAdmin: true,
              ),
              PrizeTile(
                status: 'Pay Now',
                timer:'00:00',
                title: mainController.title2,
                price: mainController.price2,
                file: mainController.file2!,
                no: 2,
                clr: Colors.blueGrey,
                isAdmin: true,
              ),
              PrizeTile(
                status: 'Pay Now',
                timer:'00:00',
                title: mainController.title3,
                price: mainController.price3,
                file: mainController.file3!,
                no: 3,
                clr: Colors.lightGreen,
                isAdmin: true,
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DefaultButton(
                    text: 'Save',
                    onPressed: () =>
                        mainController.saveAllPricesToDataBase(context),
                    isFixed: true,
                  ),
                  DefaultButton(
                    text: 'Cancel',
                    onPressed: () => mainController.cancelSaving(),
                    isFixed: true,
                  ),
                ],
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
