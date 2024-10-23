import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/default_button.dart';
import '../manager/main_nav_admin_controller.dart';
import 'default_textfiled_for_timer.dart';
import 'dialog_calender.dart';
import 'dialogbox_image_picker.dart';

class AddingStepper extends StatelessWidget {
  AddingStepper({super.key});

  final mainController = sl<MainNavAdminController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            IconStepper(
              icons: mainController.icons,
              activeStep: mainController.activeStep.value,
              onStepReached: (index) =>mainController.setActiveStep(index)
              ,
            ),
            DefaultButton(
                text: 'Enter ${headerText()} Details', onPressed: () {}),
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
                            child: mainController.isImage.value
                                ? Image.file(mainController.file!)
                                : CircleAvatar(
                              radius: 30.sp,
                              child: CircleAvatar(
                                  radius: 29.sp,
                                  backgroundColor: ConstColors.kBGColor,
                                  child: Icon(
                                    color: Colors.white,
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
                            mainController.savePrize();
                          },
                          validator: mainController.validateTitleField,
                          hnt: 'Title',
                          controller: mainController.titleController,
                          icon: Icons.title,
                          textInputType: TextInputType.text),
                      DefaultTextFieldForTimer(
                          onChanged: (txt) {
                            mainController.formKey.currentState!.validate();
                            mainController.savePrize();
                          },
                          validator: mainController.validatePriceField,
                          hnt: 'Price',
                          controller: mainController.priceController,
                          icon: Icons.price_change,
                          textInputType: TextInputType.number),
                      DefaultTextFieldForTimer(
                          onChanged: (txt) {
                            mainController.formKey.currentState!.validate();

                            mainController.savePrize();
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
                              mainController.savePrize();
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
                      DefaultButton(
                          text: 'Save ${headerText()}',
                          onPressed: () => mainController.savePrizeButton(context))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  /// Returns the header wrapping the header text.

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (mainController.activeStep.value) {
      case 0:
        return 'First Prize';

      case 1:
        return 'Second Prize';

      case 2:
        return 'Third Prize';

      default:
        return 'First Prize';
    }
  }
}