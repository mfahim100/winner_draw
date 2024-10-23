import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_styles.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/default_button.dart';
import '../manager/auth_controller.dart';

class ImagePickerDialogBox extends StatelessWidget {
  ImagePickerDialogBox({super.key});
  final mainController = sl<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(2.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.w)), //this right here
      child: Container(
        height: 35.h,
        decoration: BoxDecoration(
          // color: ConstColors.kBGColor,
          //   color: ConstColors.white,
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(5.w)),
        width: 85.w,
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
              height: 2.h,
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
            //   onPressed: () => mainController.cleanImage(),
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
