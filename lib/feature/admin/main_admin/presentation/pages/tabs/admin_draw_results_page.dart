import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:searchable_listview/searchable_listview.dart';
import '../../../../../../core/constants/const_colors.dart';
import '../../../../../../core/controllers/theme_controller.dart';
import '../../../../../../core/utils/injections.dart';
import '../../manager/main_nav_admin_controller.dart';
import '../../widgets/dialogbox_results.dart';
import '../../widgets/list_tile_results.dart';

class AdminDrawResultsPage extends StatelessWidget {
  AdminDrawResultsPage({Key? key}) : super(key: key);

  final mainController = sl<MainNavAdminController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => mainController.isResultLoaded.value
        ? Container(
      color: Colors.white,
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.w,
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  Text(
                    'Draw Results',
                    style: Get.theme.textTheme.titleLarge!.copyWith(
                      color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  Container(
                      height: 75.h,
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      child:
                      ListView.builder(
                              itemCount: mainController.resultsDates.length,
                              itemBuilder: (context, index) {
                                  // Text(mainController.resultsDates[index].toString(),style: TextStyle(color: Colors.white),),
                                List<String> ddd = mainController.resultsDates[index].toString().split(":");
                                return
                              Container(
                                      margin: EdgeInsets.symmetric(vertical: 15.sp),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.sp),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 5.sp,
                                              color: Colors.grey,
                                              spreadRadius: 5.sp,
                                              offset: Offset(5.sp, 5.sp),
                                              blurStyle: BlurStyle.outer),
                                        ],
                                      ),
                                      child:  ListTileResults(results: mainController.resultList[index][0], isClient: false,),

                                      // ListTile(
                                      //     onTap: () => showDialog(
                                      //         context: context,
                                      //         barrierDismissible: false,
                                      //         builder: (_) => ResultsDialogBox(
                                      //           index: int.parse(ddd[0].substring(1)),
                                      //           date: ddd[1]
                                      //               .substring(0, ddd[1].length - 1),
                                      //         )),
                                      //     title:
                                      //     ListTileResults(results: mainController.resultList[index][0], isClient: false,),
                                      //     // Text(
                                      //     //   ddd[1].substring(0, ddd[1].length - 1),
                                      //     //   style: const TextStyle(color: Colors.black),
                                      //     // ),
                                      // ),
                                    );}
                            ),

                    //   Obx(
                    //     () =>
                    //         mainController.isResultLoaded.value?SearchableList<dynamic>(
                    //
                    //       filter: (value) => mainController.resultsDates
                    //           .where(
                    //             (element) => element
                    //                 .toString()
                    //                 .toLowerCase()
                    //                 .contains(value),
                    //           )
                    //           .toList(),
                    //       spaceBetweenSearchAndList: 0,
                    //       autoFocusOnSearch: false,
                    //       initialList: mainController.resultsDates,
                    //
                    //           style: const TextStyle(color: Colors.white),
                    //       inputDecoration: InputDecoration(
                    //         labelText: "Search",
                    //         labelStyle: const TextStyle(color: Colors.white),
                    //         fillColor: Colors.white,
                    //         border: buildOutlineInputBorder(),
                    //         errorBorder: buildOutlineInputBorder(),
                    //         focusedErrorBorder: buildOutlineInputBorder(),
                    //         focusedBorder: buildOutlineInputBorder(),
                    //         disabledBorder: buildOutlineInputBorder(),
                    //         enabledBorder: buildOutlineInputBorder(),
                    //       ), builder: (List<dynamic> displayedList, int itemIndex, date) {   List<String> ddd = date.toString().split(":");
                    //     return Container(
                    //       margin: EdgeInsets.symmetric(vertical: 15.sp),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10.sp),
                    //         boxShadow: [
                    //           BoxShadow(
                    //               blurRadius: 5.sp,
                    //               color: Colors.grey,
                    //               spreadRadius: 5.sp,
                    //               offset: Offset(5.sp, 5.sp),
                    //               blurStyle: BlurStyle.outer),
                    //         ],
                    //       ),
                    //       child: ListTile(
                    //           onTap: () => showDialog(
                    //               context: context,
                    //               barrierDismissible: false,
                    //               builder: (_) => ResultsDialogBox(
                    //                 index: int.parse(ddd[0].substring(1)),
                    //                 date: ddd[1]
                    //                     .substring(0, ddd[1].length - 1),
                    //               )),
                    //           title: Text(
                    //             ddd[1].substring(0, ddd[1].length - 1),
                    //             style: const TextStyle(color: Colors.white),
                    //           )),
                    //     ); },
                    //     ):
                    // const SizedBox(),
                    //   ),
                      ),
                ],
              ),
            ),
        )
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Center(
              child: Text(
                'No Results',
                style: Get.theme.textTheme.titleMedium!.copyWith(
                  color: sl<ThemeController>().darkTheme.value
                      ? ConstColors.black
                      : ConstColors.white,
                ),
              ),
            ),
          ));
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.blue,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}
