import 'dart:ui';

import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/controllers/theme_controller.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/default_button.dart';
import '../../../../../core/widgets/default_text_field.dart';
import '../../../../auth/presentation/manager/auth_controller.dart';
import '../manager/main_nav_client_controller.dart';

class PaymentOptionDialogBox extends StatelessWidget {
  PaymentOptionDialogBox({super.key});
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
        height: 35.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: 90.w,
              height: 35.h,
              decoration:
                  BoxDecoration(color: Colors.grey.shade200.withOpacity(0.2)),
              child: Form(
                key: mainController.formKey,
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
                            'Select Payment Option',
                            style: Get.theme.textTheme.titleMedium!.copyWith(
                              color: sl<ThemeController>().darkTheme.value
                                  ? ConstColors.black
                                  : ConstColors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              mainController.paymentOptionSelection.value = 0;
                              Navigator.pop(context);
                            },
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
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Container(
                          //   decoration: BoxDecoration(
                          //       color: mainController
                          //                   .paymentOptionSelection.value ==
                          //               1
                          //           ? ConstColors.kButtonBrownColor
                          //           : Colors.transparent,
                          //       borderRadius: BorderRadius.circular(15.sp)),
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       // Get.dialog(PaymentEasyPaisaDialogBox(
                          //       // ));
                          //       mainController.paymentOptionSelection.value = 1;
                          //     },
                          //     child: Image.asset(
                          //       'assets/images/easy_paisa.png',
                          //       height: 40.sp,
                          //       width: 40.sp,
                          //     ),
                          //   ),
                          // ),
                          Container(
                            decoration: BoxDecoration(
                                color: mainController
                                            .paymentOptionSelection.value ==
                                        2
                                    ? ConstColors.kButtonBrownColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(15.sp)),
                            child: GestureDetector(
                              onTap: () {
                                // Get.dialog(PaymentJazzCashDialogBox(
                                // ));
                                mainController.paymentOptionSelection.value = 2;
                              },
                              child: Image.asset(
                                'assets/images/jazz_cash.png',
                                height: 40.sp,
                                width: 40.sp,
                              ),
                            ),
                          ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //       color: mainController
                          //                   .paymentOptionSelection.value ==
                          //               3
                          //           ? ConstColors.kButtonBrownColor
                          //           : Colors.transparent,
                          //       borderRadius: BorderRadius.circular(15.sp)),
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       Get.dialog(PaymentBankDialogBox());
                          //       mainController.paymentOptionSelection.value = 3;
                          //     },
                          //     child: Image.asset(
                          //       'assets/images/bank.webp',
                          //       height: 40.sp,
                          //       width: 40.sp,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Obx(
                        () => mainController.paymentOptionSelection.value == 0
                            ? const SizedBox()
                            : CustomTextField(
                                maxLength: 11,
                                validator:
                                    sl<AuthController>().validateContactField,
                                text: 'Mobile Number',
                                hintText: 'Mobile Number',
                                controller: mainController.phoneNumber,
                                prefix: const Icon(Icons.contact_phone),
                                textInputType: TextInputType.phone),
                      ),
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment:
                            mainController.paymentOptionSelection.value == 0
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.sp),
                            child: DefaultButton(
                                isFixed: true,
                                text: 'Close',
                                onPressed: () {
                                  Navigator.pop(context);
                                  mainController.paymentOptionSelection.value =
                                      0;
                                  mainController.phoneNumber.clear();
                                }
                                //mainController.addParticipant()
                                ),
                          ),
                          mainController.paymentOptionSelection.value == 0
                              ? const SizedBox()
                              : Padding(
                                  padding: EdgeInsets.all(15.sp),
                                  child: DefaultButton(
                                      isFixed: true,
                                      text: 'Submit',
                                      onPressed: () =>
                                        mainController.callingPayApi(context)


                                      //mainController.addParticipant()
                                      ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
