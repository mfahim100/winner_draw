import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/constants/const_neus.dart';
import '../../../../../core/constants/const_styles.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/default_button.dart';
import '../../../../../core/widgets/default_text_field.dart';
import '../manager/main_nav_admin_controller.dart';

class PhotoPickerDialogBox extends StatelessWidget {
  PhotoPickerDialogBox({super.key});
  final mainController = sl<MainNavAdminController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(2.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.w)), //this right here
      child: Container(
        decoration: BoxDecoration(
            // color: ConstColors.kBGColor,
            color: ConstColors.white,
            borderRadius: BorderRadius.circular(5.w)),
        width: 90.w,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: NeumorphicButton(
                  onPressed: () => Navigator.pop(context),
                  style: ConstNeus.appBarCirclesDark,
                  padding: EdgeInsets.all(10.sp),
                  child: Icon(
                    Icons.clear,
                    color: ConstColors.white,
                    size: 20.sp,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.w,
                  ),
                  child: Text(
                    'Select Image To Upload',
                    style: ConstStyle.headerTextStyle
                        .copyWith(color: Colors.black54),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              InkWell(
                onTap: () => mainController.selectDate(context),
                child: Container(
                  width: 80.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25.sp),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 2.5.w,
                      ),
                       Icon(Icons.date_range_sharp,color: Colors.white,size: 19.sp,),
                      SizedBox(
                        width: 2.5.w,
                      ),
                      Obx(() => mainController.isPhotoDate.value
                          ? Text(
                              "${mainController.photoDateTime.day}/${mainController.photoDateTime.month}/${mainController.photoDateTime.year}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.sp),
                            )
                          : Text(
                              "${mainController.photoDateTime.day}/${mainController.photoDateTime.month}/${mainController.photoDateTime.year}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.sp),
                            )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              CustomTextField(
                  text: 'Description',
                  hintText: 'Description',
                  controller: mainController.photoDescController,
                  prefix: const Icon(Icons.description),
                  textInputType: TextInputType.text),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DefaultButton(
                    isFixed: true,
                    text: 'Camera',
                    onPressed: () =>
                        mainController.getPicturePhoto(ImageSource.camera),
                  ),
                  DefaultButton(
                    isFixed: true,
                    text: 'Gallery',
                    onPressed: () =>
                        mainController.getPicturePhoto(ImageSource.gallery),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(() => mainController.isImagePhoto.value
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.sp),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)),
                            child: Image.file(
                              mainController.filePhoto!,
                              height: 30.h,
                              width: 80.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        DefaultButton(
                          text: 'Done',
                          onPressed: () => mainController.savePhoto(context),
                        ),
                      ],
                    )
                  : Container()),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
