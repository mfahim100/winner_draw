import 'dart:io';
import 'package:neumorphic_ui/neumorphic_ui.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_strings.dart';
import '../../../../../core/constants/const_styles.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../admin/main_admin/domain/entities/model_prize.dart';
import '../manager/main_nav_client_controller.dart';

class ClientPrizeTile extends StatelessWidget {
  final String status;
  final File? file;
  final bool isAdmin;
  final String timer;
  final ModelPrize prize;

  ClientPrizeTile({
    Key? key,
    required this.status,
    this.file,
    required this.isAdmin,
    required this.timer,
    required this.prize,
  }) : super(key: key);

  var mainController = sl<MainNavClientController>();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                              child: Image.network("${ConstString.baseUrlImage}${prize.imgUrl!}")),

                          SizedBox(width: 1.w,),
                          Container(
                            width: 55.w,
                            child: Column(
                              children: [

                                SizedBox(height: 1.2.h,),

                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                               prize.no == 1
                                   ? '1st Prize'
                                   : prize.no == 2
                                   ? '2nd Prize'
                                   : prize.no == 3
                                   ? '3rd Prize'
                                   : '1st Prize',
                                style: ConstStyle.prizeContainerTextStyles,
                                                      ),
                            ),
                                                     Align(
                                                       alignment: Alignment.topLeft,
                                                       child: Text(
                                                        'Timer: ${prize.no == 1
                                                            ? mainController.timerVal1.value
                                                       : prize.no == 2
                                                            ? mainController.timerVal2.value
                                                            : prize.no == 3
                                                            ? mainController.timerVal3.value
                                                       : mainController.timerVal1.value}',
                                                        style: ConstStyle.prizeContainerTextStyles,
                                                                                                           ),
                                                     ),


                                Align(alignment: Alignment.topLeft, child: Text(' Date:  ${DateTime.fromMillisecondsSinceEpoch(prize.timer!).day}/${DateTime.fromMillisecondsSinceEpoch(prize.timer!).month}/${DateTime.fromMillisecondsSinceEpoch(prize.timer!).year}', style: ConstStyle.prizeContainerTextStyles,)),
                                Align(alignment: Alignment.topLeft, child: Text(' Title:  ${prize.title!}', style: ConstStyle.prizeContainerTextStyles,)),
                                // Align(alignment: Alignment.topLeft, child: Text(' Description: ${prize.description!}', style: ConstStyle.prizeContainerTextStyles,)),
                                Align(alignment: Alignment.topLeft, child: Text(' Price:  Rs/- ${prize.price!}', style: ConstStyle.prizeContainerTextStyles,)),




                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                  ),

                  SizedBox(height: 2.h,)
                ],
              );











    //   Container(
    //   padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
    //   child: Stack(
    //     children: [
    //       Column(
    //         children: [
    //           SizedBox(
    //             width: 80.w,
    //             child: Align(
    //               alignment: Alignment.centerLeft,
    //               child: Row(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Text(
    //                     "Date  ",
    //                     style: ConstStyle.tileTitleTextStyle,
    //                   ),
    //                   Text(
    //                     "${DateTime.fromMillisecondsSinceEpoch(prize.timer!).day}/${DateTime.fromMillisecondsSinceEpoch(prize.timer!).month}/${DateTime.fromMillisecondsSinceEpoch(prize.timer!).year}",
    //                     style: ConstStyle.tileTitleTextStyle,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             width: 80.w,
    //             child: Align(
    //               alignment: Alignment.centerLeft,
    //               child: Obx(() => Row(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       Text(
    //                         "Timer  ",
    //                         style: ConstStyle.tileTitleTextStyle,
    //                       ),
    //                       Text(
    //                         prize.no == 1
    //                             ? mainController.timerVal1.value
    //                             : prize.no == 2
    //                                 ? mainController.timerVal2.value
    //                                 : prize.no == 3
    //                                     ? mainController.timerVal3.value
    //                                     : mainController.timerVal1.value,
    //                         style: ConstStyle.tileTitleTextStyle,
    //                       ),
    //                     ],
    //                   )),
    //             ),
    //           ),
    //           Stack(
    //             children: [
    //               Align(
    //                 alignment: Alignment.centerLeft,
    //                 child: SizedBox(
    //                   width: 35.w,
    //                   child: Visibility(
    //                     visible: !isAdmin,
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                           image: DecorationImage(
    //                               image: status == 'Purchased'
    //                                   ? const AssetImage(
    //                                       'assets/images/status_paid.png')
    //                                   : const AssetImage(
    //                                       'assets/images/status.png')),
    //                           borderRadius: BorderRadius.circular(15.sp)),
    //                       padding: EdgeInsets.symmetric(
    //                           horizontal: 5.w, vertical: 1.h),
    //                       child: Text(
    //                         status,
    //                         style: ConstStyle.tileTitleTextStyle,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Align(
    //                 alignment: Alignment.center,
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                       image: const DecorationImage(
    //                           image: AssetImage('assets/images/prize_no.png')),
    //                       borderRadius: BorderRadius.circular(15.sp)),
    //                   padding:
    //                       EdgeInsets.symmetric(horizontal: 14.w, vertical: 1.h),
    //                   child: Text(
    //                     prize.no == 1
    //                         ? '1st Prize'
    //                         : prize.no == 2
    //                             ? '2nd Prize'
    //                             : prize.no == 3
    //                                 ? '3rd Prize'
    //                                 : '1st Prize',
    //                     style: ConstStyle.headerTextStyle,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Neumorphic(
    //             style: NeumorphicStyle(
    //               shape: NeumorphicShape.concave,
    //               boxShape: NeumorphicBoxShape.roundRect(
    //                   BorderRadius.all(Radius.circular(50.sp))),
    //               color: prize.no == 1
    //                   ? Colors.amber
    //                   : prize.no == 2
    //                       ? Colors.grey.shade500
    //                       : prize.no == 3
    //                           ? Colors.amberAccent
    //                           : Colors.amber,
    //               // shadowLightColor: ConstColors.darkShadowLight,
    //               // shadowDarkColor: ConstColors.darkShadowDark,
    //               depth: 4,
    //             ),
    //             child: Container(
    //               padding:
    //                   EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
    //               width: 90.w,
    //               child: Align(
    //                 alignment: Alignment.centerLeft,
    //                 child: Text(
    //                   prize.title!,
    //                   style: ConstStyle.headerTextStyle.copyWith(
    //                       color: Colors.black, fontWeight: FontWeight.normal),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           // SizedBox(
    //           //   width: 80.w,
    //           //   child: Align(
    //           //     alignment: Alignment.centerLeft,
    //           //     child: Text(
    //           //       prize.description!,
    //           //       style: ConstStyle.tileTitleTextStyle,
    //           //     ),
    //           //   ),
    //           // ),
    //           SizedBox(
    //             width: 80.w,
    //             child: Align(
    //               alignment: Alignment.centerLeft,
    //               child: Text(
    //                 'Rs/- ${prize.price!}',
    //                 style: ConstStyle.tileTitleTextStyle,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       Positioned(
    //           top: 0,
    //           bottom: 0,
    //           right: 0,
    //           child: file != null
    //               ? Image.file(
    //                   file!,
    //                   height: 20.h,
    //                   width: 30.w,
    //                 )
    //               : Image.network(
    //                   "${ConstString.baseUrlImage}${prize.imgUrl!}",
    //                   height: 20.h,
    //                   width: 30.w,
    //                 ))
    //     ],
    //   ),
    // );
  }
}
