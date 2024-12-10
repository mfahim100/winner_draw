import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/constants/const_strings.dart';
import '../../../../../core/controllers/theme_controller.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/default_button.dart';

import '../../domain/entities/model_prize.dart';
import '../manager/main_nav_admin_controller.dart';
import 'default_textfiled_for_timer.dart';
import 'dialog_calender.dart';
import 'dialogbox_image_picker.dart';

class EditPrizeDialogBox extends StatelessWidget {
  final ModelPrize prize;

  EditPrizeDialogBox({super.key, required this.prize});
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
        child: Container(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: SizedBox(height: 80.h,
              child: Column(
                children: [
                  Text(
                    'Edit Draw Details',
                    style: Get.theme.textTheme.titleLarge!.copyWith(
                      color: sl<ThemeController>().darkTheme.value
                          ? ConstColors.black
                          : ConstColors.white,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    '${prize.no == 1 ? "1st" : prize.no == 2 ? "2nd" : prize.no == 3 ? "3rd" : "1st"} Prize Details',
                    style: Get.theme.textTheme.titleMedium!.copyWith(
                      color: sl<ThemeController>().darkTheme.value
                          ? ConstColors.black
                          : ConstColors.white,
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      child: Form(
                        key: mainController.formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.sp),
                              child: GestureDetector(
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ImagePickerDialogBox();
                                    }),
                                child: SizedBox(
                                  height: 15.h,
                                  child: mainController.editImageFromDatabase.value
                                      ? CachedNetworkImage(
                                    imageUrl: "${ConstString.baseUrlImage}${mainController.editImageFromDatabaseUrl.value}",
                                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  )
                                  // Image.network("${ConstString.baseUrlImage}${mainController.editImageFromDatabaseUrl.value}")
                                      :mainController.isImage.value
                                      ? Image.file(mainController.file!)
                                      : CircleAvatar(
                                    radius: 30.sp,
                                    child: CircleAvatar(
                                        radius: 29.sp,
                                        backgroundColor: ConstColors.kBGColor,
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: 25.sp,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.w,
                            ),
                            DefaultTextFieldForTimer(
                                onChanged: (txt) {
                                  mainController.formKey.currentState!.validate();

                                },
                                validator: mainController.validateTitleField,
                                hnt: 'Title',
                                controller: mainController.titleController,
                                icon: Icons.title,
                                textInputType: TextInputType.text),
                            DefaultTextFieldForTimer(
                                onChanged: (txt) {
                                  mainController.formKey.currentState!.validate();

                                },
                                validator: mainController.validatePriceField,
                                hnt: 'Price',
                                controller: mainController.priceController,
                                icon: Icons.price_change,
                                textInputType: TextInputType.number),
                            DefaultTextFieldForTimer(
                                onChanged: (txt) {
                                  mainController.formKey.currentState!.validate();

                                },
                                validator: mainController.validateDescField,
                                hnt: 'Description',
                                controller: mainController.descController,
                                icon: Icons.description,
                                textInputType: TextInputType.text),
                            GestureDetector(
                                onTap: () => showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => const DialogCalender()),
                                child: DefaultTextFieldForTimer(
                                  onChanged: (txt) {
                                    mainController.formKey.currentState!.validate();

                                  },
                                  validator: mainController.validateDateField,
                                  hnt: 'Timer',
                                  controller: mainController.timerController,
                                  icon: Icons.timer,
                                  textInputType: TextInputType.text,
                                  isEnabled: false,
                                )),
                            SizedBox(
                              height: 5.w,
                            ),
                            SizedBox(
                              width: 75.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultButton(
                                    text: 'Save',
                                    onPressed: () =>
                                        mainController.editPrizeButton(context,prize),
                                    isFixed: true,
                                  ),
                                  DefaultButton(
                                    text: 'Cancel',
                                    onPressed: () => mainController.cancelSaving(),
                                    isFixed: true,
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}