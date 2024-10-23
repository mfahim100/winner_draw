import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/constants/const_styles.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/default_button.dart';
import '../manager/main_nav_client_controller.dart';

class ProfileImagePickerDialogBox extends StatelessWidget {
  ProfileImagePickerDialogBox({super.key});
  final mainController = sl<MainNavClientController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(2.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.w)), //this right here
      child: Container(
        height: 55.h,
        decoration: BoxDecoration(
          // color: ConstColors.kBGColor,
            color: ConstColors.white,
            borderRadius: BorderRadius.circular(5.w)),
        width: 90.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.w,
                ),
                child: Text(
                  'Pick Profile Image',
                  style: ConstStyle.headerTextStyle
                      .copyWith(color: Colors.black54),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            DefaultButton(
              text: 'Camera',
              onPressed: () => mainController.getPicture(ImageSource.camera),
            ),
            SizedBox(
              height: 3.h,
            ),
            DefaultButton(
              text: 'Gallery',
              onPressed: () => mainController.getPicture(ImageSource.gallery),
            ),
            // SizedBox(
            //   height: 3.h,
            // ),
            // DefaultButton(
            //   text: 'Try Avatar',
            //   onPressed: () => mainController.tryAvatar(),
            // ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
