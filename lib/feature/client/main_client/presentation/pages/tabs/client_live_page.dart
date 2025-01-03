import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../core/constants/const_colors.dart';
import '../../../../../../core/utils/injections.dart';
import '../../manager/main_nav_client_controller.dart';
import '../../widgets/client_live_prize_tile.dart';
import '../../widgets/list_tile_results_client.dart';

class ClientLivePage extends StatelessWidget {
  ClientLivePage({super.key});

  final mainNavController = sl<MainNavClientController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => mainNavController.isCurrentLuckyDraw.value
          ? Container(
        color: Colors.white,
            child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5.w,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Live',
                          style: Get.theme.textTheme.titleLarge!.copyWith(
                            color: ConstColors.black

                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.w,
                    ),



                    Container(
                      height: 80.h,
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: mainNavController.luckyDrawList.length + 1,
                          itemBuilder: (context, index) => GestureDetector(
                            child: index == mainNavController.luckyDrawList.length
                                ? Container(
                                    height: 40.h,
                                    margin: EdgeInsets.only(top:15.sp,left:15.sp,right:15.sp,bottom:25.sp,),
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
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                          child: Center(
                                            child: NeumorphicText(
                                              "WINNERS",
                                              textStyle: NeumorphicTextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold),
                                              style: const NeumorphicStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30.h,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Obx(() => mainNavController.isTimer1.value && mainNavController
                                                          .currentResultList
                                                          .isNotEmpty
                                                  ? NeumorphicText(
                                                      "${DateTime.fromMillisecondsSinceEpoch(mainNavController.currentResultList[0].timer!).day}/${DateTime.fromMillisecondsSinceEpoch(mainNavController.currentResultList[0].timer!).month}/${DateTime.fromMillisecondsSinceEpoch(mainNavController.currentResultList[0].timer!).year}",
                                                      textStyle:
                                                          NeumorphicTextStyle(
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                      style: const NeumorphicStyle(
                                                          color: Colors.black),
                                                    )
                                                  : Container(child: Center(child: Text("No Current Winner Yet",style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold
                                              ),),),)),
                                              Obx(() => mainNavController
                                                          .isTimer1.value &&
                                                      mainNavController
                                                          .currentResultList
                                                          .isNotEmpty
                                                  ? ListTileResultsClient(
                                                      results: mainNavController
                                                          .currentResultList[0],
                                                    )
                                                  : Container()),
                                              Obx(() => mainNavController
                                                          .isTimer2.value &&
                                                      mainNavController
                                                              .currentResultList
                                                              .length >
                                                          1
                                                  ? ListTileResultsClient(
                                                      results: mainNavController
                                                          .currentResultList[1],
                                                    )
                                                  : Container()),
                                              Obx(() => mainNavController
                                                          .isTimer3.value &&
                                                      mainNavController
                                                              .currentResultList
                                                              .length >
                                                          2
                                                  ? ListTileResultsClient(
                                                      results: mainNavController.currentResultList[2],
                                                    )
                                                  : Container()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))
                                : ClientLivePrizeTile(
                                    status: mainNavController.isPayed.value
                                        ? 'Purchased'
                                        : 'Pay Now',
                                    imgUrl: mainNavController
                                        .luckyDrawList[index].imgUrl,
                                    prize: mainNavController.luckyDrawList[index],
                                    timer: '00:00',
                                  ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
          )
          : Container(
              height: 40.h,
              margin: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.sp)),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                    child: Center(
                      child: NeumorphicText(
                        "WINNERS",
                        textStyle: NeumorphicTextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                        style: const NeumorphicStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        mainNavController.currentResultList.isNotEmpty
                            ? NeumorphicText(
                                "${DateTime.fromMillisecondsSinceEpoch(mainNavController.currentResultList[0].timer!).day}/${DateTime.fromMillisecondsSinceEpoch(mainNavController.currentResultList[0].timer!).month}/${DateTime.fromMillisecondsSinceEpoch(mainNavController.currentResultList[0].timer!).year}",
                                textStyle: NeumorphicTextStyle(

                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                ),
                                style:
                                    const NeumorphicStyle(color: Colors.black),
                              )
                            :
                        Container(),
                        Obx(() => mainNavController
                                    .isCurrentResultLoaded.value &&
                                mainNavController.currentResultList.isNotEmpty
                            ? ListTileResultsClient(
                                results: mainNavController.currentResultList[0],
                              )
                            : Container()),
                        Obx(() => mainNavController
                                    .isCurrentResultLoaded.value &&
                                mainNavController.currentResultList.length > 1
                            ? ListTileResultsClient(
                                results: mainNavController.currentResultList[1],
                              )
                            : Container()),
                        Obx(() => mainNavController
                                    .isCurrentResultLoaded.value &&
                                mainNavController.currentResultList.length > 2
                            ? ListTileResultsClient(
                                results: mainNavController.currentResultList[2],
                              )
                            : Container()),






                      ],
                    ),
                  ),


                ],
              ),
            ),



    );
  }
}
