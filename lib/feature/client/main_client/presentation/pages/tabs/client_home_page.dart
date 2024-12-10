import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../core/constants/const_colors.dart';
import '../../../../../../core/constants/const_strings.dart';
import '../../../../../../core/constants/const_styles.dart';
import '../../../../../../core/routes/app_pages.dart';
import '../../../../../../core/utils/injections.dart';
import '../../../../../../core/widgets/snake_bars.dart';
import '../../../../../auth/presentation/manager/auth_controller.dart';
import '../../manager/main_nav_client_controller.dart';
import '../../widgets/client_prize_tile.dart';
import '../../widgets/dialogbox_help.dart';
import '../../widgets/dialogbox_pdf.dart';
import '../../widgets/page_view_content.dart';
import '../../widgets/popup_menu.dart';
import '../../widgets/request_dialog.dart';

class ClientHomePage extends StatelessWidget {
  ClientHomePage({super.key});

  final mainNavController = sl<MainNavClientController>();

  @override
  Widget build(BuildContext context) {
    return
      // Obx(() =>
        Scrollbar(
          child: Container(
            height: 100.h,
            width: 100.w,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 70.w,
                          child: Row(
                            children: [
                              Text(
                                'Welcome, ',
                                style: Get.theme.textTheme.titleLarge!.copyWith(
                                  color: Colors.black
                                ),
                              ),
                              Obx(
                                    () =>
                                    mainNavController.isUser.value
                                    ? Text(
                                  '${mainNavController.appUser!.name}',
                                  style: Get.theme.textTheme.bodyMedium!
                                      .copyWith(
                                    color:Colors.black
                                  ),
                                )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                        PopUpMenu(
                          aboutUsCallback: () {
                            Future.delayed(
                                const Duration(seconds: 0),
                                    () =>
                                    showDialog(
                                        context: context,
                                        builder: (
                                            context) => const PdfDialogBox()));
                          },
                          accountCallback: () {
                            Future.delayed(const Duration(seconds: 0),
                                    () => Get.toNamed(Routes.PROFILE));
                          },
                          helpCallback: () {
                            Future.delayed(
                                const Duration(seconds: 0),
                                    () =>
                                    showDialog(
                                        context: context,
                                        builder: (context) => HelpDialogBox()));
                          },
                          logoutCallback: () =>
                              sl<AuthController>().logout(context),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  Container(
                    height: 30.h,
                    child: Obx(
                          () =>
                      mainNavController.isPageLoaded.value
                          ? PageView.builder(
                        controller: mainNavController.pageController,
                        onPageChanged: (val) =>
                            mainNavController.setPage(val),
                        itemCount: mainNavController.pageViewData.length,
                        itemBuilder: (context, index) {
                          print("${ConstString.baseUrlImage}${mainNavController.pageViewData[index].imgUrl}".toString());
                          return
                            PageViewContent(
                              index: index,
                              image:Uri.encodeFull(
                              "${ConstString.baseUrlImage}${mainNavController
                                  .pageViewData[index].imgUrl}"
                                  .toString()),
                              count: mainNavController.pageViewData.length,
                            );
                        },
                      )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  Obx(
                        () =>
                    mainNavController.isCurrentLuckyDraw.value
                        ? Column(
                      children: [
                        SizedBox(
                          height: 75.h,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            itemCount:
                            mainNavController.luckyDrawList.length,
                            itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () {},
                                        child: ClientPrizeTile(
                                          status: mainNavController.isPayed.value
                                              ? 'Purchased'
                                          : mainNavController.isProcessing.value
                                              ? 'Processing'
                                              : 'Pay Now',
                                          isAdmin: false,
                                          timer: '00:00',
                                          prize: mainNavController.luckyDrawList[index],
                                        ),
                                      ),
                                ),
                          ),
                        // ),
                        SizedBox(
                          height: 5.w,
                        ),

                        Obx(() =>
                        mainNavController.isPayed.value
                            ? GestureDetector(
                          onTap: () =>
                              CustomSnakeBars.snakeBanner(
                                  context,
                                  'Failed',
                                  'Already Paid',
                                  'failure'),
                          child: Container(
                            width: 40.w,
                            margin: EdgeInsets.all(5.sp),
                            padding: EdgeInsets.all(5.sp),
                            alignment: Alignment.center,
                            height: 5.h,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(25.sp),
                                color: const Color(0xFF05D92D),
                                // gradient: ConstColors.kButtonBG,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade100,
                                      blurRadius: 15.sp,
                                      spreadRadius: 5.sp,
                                      offset: const Offset(1, 1),
                                      blurStyle: BlurStyle.inner)
                                ]),
                            child: Text('Purchased',
                                style:
                                ConstStyle.tileSubTitleTextStyle),
                          ),
                        )
                        : mainNavController.isMyRequestAdded.value
                            ? Container(
                                width: 40.w,
                                margin: EdgeInsets.all(5.sp),
                                padding: EdgeInsets.all(5.sp),
                                alignment: Alignment.center,
                                height: 5.h,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(25.sp),
                                    color: ConstColors.kButtonBrownColor,
                                    // gradient: ConstColors.kButtonBG,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade100,
                                          blurRadius: 15.sp,
                                          spreadRadius: 5.sp,
                                          offset: const Offset(1, 1),
                                          blurStyle: BlurStyle.inner)
                                    ]),
                                child: Text('Processing',
                                    style:
                                        ConstStyle.tileSubTitleTextStyle),
                              )
                            : GestureDetector(
                          onTap: () {
                            showDialog(context: context, builder: (context){
                              return RequestDialog();
                            });
                          },
                          // onTap: () {
                          //   // mainNavController.changeStatus();
                          //   //  mainNavController.callingAuthApi();
                          //   showDialog(
                          //       context: context,
                          //       builder: (context) =>
                          //           PaymentOptionDialogBox());
                          // },
                          child: Container(
                            width: 40.w,
                            margin: EdgeInsets.all(5.sp),
                            padding: EdgeInsets.all(5.sp),
                            alignment: Alignment.center,
                            height: 6.h,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(3.w),
                                color: ConstColors.kButtonBrownColor,
                                // gradient: ConstColors.kButtonBG,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade100,
                                      blurRadius: 15.sp,
                                      spreadRadius: 5.sp,
                                      offset: const Offset(1, 1),
                                      blurStyle: BlurStyle.inner)
                                ]),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text('Pay Now',
                                    style: ConstStyle
                                        .tileSubTitleTextStyle.copyWith(
                                      color: ConstColors.kWhiteTextColor
                                    )),

                              ],
                            ),
                          ),
                        )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 10.w),
                          child: Center(
                            child: Text(
                              'Total Participants',
                              style:
                              Get.theme.textTheme.titleMedium!.copyWith(
                                color: ConstColors.kTextFieldBGColor,
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 41.sp,
                          backgroundColor: ConstColors.kButtonBrownColor,
                          child: CircleAvatar(
                            radius: 40.sp,
                            backgroundColor: ConstColors.kBGColor,
                            child: Center(
                              child: Obx(() =>
                                  Text(
                                    mainNavController
                                        .isParticipantsLoaded.value
                                        ? mainNavController
                                        .participantsData.length
                                        .toString()
                                        : "0",
                                    style: Get.theme.textTheme.titleMedium!
                                        .copyWith(
                                        color: ConstColors.kWhiteTextColor,
                                        fontSize: 25.sp),
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    )
                        : Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      child: Center(
                        child: Text(
                          'No Current Lucky Draw\nNew draw will be set as soon as possible Insha-Allah',
                          style: Get.theme.textTheme.titleMedium!.copyWith(
                            color: ConstColors.kTextFieldBGColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    // );
  }
}
