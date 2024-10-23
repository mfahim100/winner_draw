import 'dart:io';
import 'package:neumorphic_ui/neumorphic_ui.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../feature/admin/main_admin/presentation/manager/main_nav_admin_controller.dart';
import '../constants/const_strings.dart';
import '../constants/const_styles.dart';
import '../utils/injections.dart';

class PrizeTile extends StatelessWidget {
  final String status;
  final String title;
  final String price;
  final int no;
  final String? imgUrl;
  final File? file;
  final Color clr;
  final bool isAdmin;
  final String timer;

  PrizeTile(
      {Key? key,
      required this.status,
      required this.title,
      required this.price,
      this.file,
      required this.no,
      required this.clr,
      this.imgUrl,
      required this.isAdmin,
      required this.timer})
      : super(key: key);

  final mainController = sl<MainNavAdminController>();

  @override
  Widget build(BuildContext context) {
    print("${ConstString.baseUrlImage}${imgUrl.toString()}");
    return

      Column(
        children: [
          Container(
            height: 20.h,
            width: 93.w,
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(03.w),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),

            child: Padding(
              padding:  EdgeInsets.all(1.5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                      width: 33.w,
                      child: Image.network("${ConstString.baseUrlImage}${imgUrl.toString()}")),

                  SizedBox(width: 1.w,),
                  Container(
                    width: 55.w,
                    child: Column(
                      children: [

                        SizedBox(height: 1.2.h,),

                        Container(
                          color: Colors.red,
                          width: 30.w,
                          child: Visibility(
                            visible: !isAdmin,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage('assets/images/status.png')),
                                  borderRadius: BorderRadius.circular(15.sp)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 1.h),
                              child: Text(
                                status,
                                style: ConstStyle.tileTitleTextStyle,
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            no == 1
                                ? '1st Prize'
                                : no == 2
                                ? '2nd Prize'
                                : no == 3
                                ? '3rd Prize'
                                : '1st Prize',
                            style: ConstStyle.prizeContainerTextStyles,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Timer: ${no == 1
                                ? mainController.timerVal1.value
                                : no == 2
                                ? mainController.timerVal2.value
                                : no == 3
                                ? mainController.timerVal3.value
                                : mainController.timerVal1.value}',
                            style: ConstStyle.prizeContainerTextStyles,
                          ),
                        ),



                        // Align(alignment: Alignment.topLeft, child: Text(' Date:  ${DateTime.fromMillisecondsSinceEpoch(prize.timer!).day}/${DateTime.fromMillisecondsSinceEpoch(prize.timer!).month}/${DateTime.fromMillisecondsSinceEpoch(prize.timer!).year}', style: ConstStyle.prizeContainerTextStyles,)),
                        Align(alignment: Alignment.topLeft, child: Text(' Title:  $title', style: ConstStyle.prizeContainerTextStyles,)),
                        // Align(alignment: Alignment.topLeft, child: Text(' Description: ${prize.description!}', style: ConstStyle.prizeContainerTextStyles,)),
                        Align(alignment: Alignment.topLeft, child: Text(' Price: Rs/- $price', style: ConstStyle.prizeContainerTextStyles,)),




                      ],
                    ),
                  ),

                ],
              ),
            ),

          ),

          // Container(
          // height: 25.h,
          // color: Colors.green,
          // padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          // child: Stack(
          //   children: [
          //     Column(
          //       children: [
          //         SizedBox(
          //           width: 80.w,
          //           child: Align(
          //             alignment: Alignment.centerLeft,
          //             child: Obx(() => Row(
          //                   mainAxisSize: MainAxisSize.min,
          //                   children: [
          //                     Text(
          //                       "Timer  ",
          //                       style: ConstStyle.tileTitleTextStyle,
          //                     ),
          //                     Text(
          //                       no == 1
          //                           ? mainController.timerVal1.value
          //                           : no == 2
          //                               ? mainController.timerVal2.value
          //                               : no == 3
          //                                   ? mainController.timerVal3.value
          //                                   : mainController.timerVal1.value,
          //                       style: ConstStyle.tileTitleTextStyle,
          //                     ),
          //                   ],
          //                 )),
          //           ),
          //         ),
          //         Stack(
          //           children: [
          //             SizedBox(
          //               width: 30.w,
          //               child: Visibility(
          //                 visible: !isAdmin,
          //                 child: Container(
          //                   decoration: BoxDecoration(
          //                       image: const DecorationImage(
          //                           image: AssetImage('assets/images/status.png')),
          //                       borderRadius: BorderRadius.circular(15.sp)),
          //                   padding: EdgeInsets.symmetric(
          //                       horizontal: 5.w, vertical: 1.h),
          //                   child: Text(
          //                     status,
          //                     style: ConstStyle.tileTitleTextStyle,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               decoration: BoxDecoration(
          //                   image: const DecorationImage(
          //                       image: AssetImage('assets/images/prize_no.png')),
          //                   borderRadius: BorderRadius.circular(15.sp)),
          //               padding:
          //                   EdgeInsets.symmetric(horizontal: 14.w, vertical: 1.h),
          //               child: Text(
          //                 no == 1
          //                     ? '1st Prize'
          //                     : no == 2
          //                         ? '2nd Prize'
          //                         : no == 3
          //                             ? '3rd Prize'
          //                             : '1st Prize',
          //                 style: ConstStyle.headerTextStyle,
          //               ),
          //             ),
          //           ],
          //         ),
          //         Neumorphic(
          //           style: sl<ThemeController>().darkTheme.value
          //               ? ConstNeus.lastPrayerMainDark
          //               : ConstNeus.lastPrayerMainLight,
          //           child: Container(
          //             height: 8.h,
          //             width: double.infinity,
          //             padding: EdgeInsets.all(5.sp),
          //             color: sl<ThemeController>().darkTheme.value
          //                 ? ConstColors.colorBackgroundDark
          //                 : ConstColors.colorBackgroundLight,
          //             child: Neumorphic(
          //               padding: EdgeInsets.symmetric(horizontal: 25.sp),
          //               style: sl<ThemeController>().darkTheme.value
          //                   ? ConstNeus.lastPrayerDark
          //                       .copyWith(color: ConstColors.kPrimaryColor)
          //                   : ConstNeus.lastPrayerLight
          //                       .copyWith(color: ConstColors.kSecondaryColor),
          //               child: Align(
          //                 alignment: Alignment.centerLeft,
          //                 child: Text(
          //                   title,
          //                   style: ConstStyle.headerTextStyle
          //                       .copyWith(color: Colors.black45),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         SizedBox(
          //           width: 80.w,
          //           child: Align(
          //             alignment: Alignment.centerLeft,
          //             child: Text(
          //               'Rs/- $price',
          //               style: ConstStyle.tileTitleTextStyle,
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //     Positioned(
          //       top: 0,
          //       bottom: 0,
          //       right: 0,
          //       child: file != null
          //           ? Image.file(
          //               file!,
          //               height: 20.h,
          //               width: 30.w,
          //             )
          //           : Image.network(
          //             "${ConstString.baseUrlImage}${imgUrl.toString()}",
          //               height: 20.h,
          //               width: 30.w,
          //             ),
          //     ),
          //   ],
          // ),
          //     ),

          SizedBox(height: 2.h,)
        ],
      );
  }
}
