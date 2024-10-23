import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/constants/const_strings.dart';
import '../../../../../core/constants/const_styles.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../admin/main_admin/domain/entities/model_photos.dart';
import '../manager/main_nav_client_controller.dart';
import 'dialogbox_comments.dart';

class ListTilePhotosClient extends StatelessWidget {
  final ModelPhotos photos;

  ListTilePhotosClient({super.key, required this.photos});
  final mainController = sl<MainNavClientController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            padding: EdgeInsets.all(5.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 9,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          photos.description!,
                          style: ConstStyle.tileTitleTextStyle,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Date ${DateFormat.yMd().format(DateTime.fromMillisecondsSinceEpoch(int.parse(photos.millis!)))}",
                          style: ConstStyle.tileTitleTextStyle,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  padding: EdgeInsets.all(15.sp),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15.sp)),
                  child: Column(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
                        child: Image.network(
                          "${ConstString.baseUrlImage}${photos.imgUrl!}",
                          fit: BoxFit.cover,
                          height: 30.h,
                          width: 80.h,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => mainController.likeDislike(photos),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                   photos.status==1
                                      ? Icon(
                                          Icons.thumb_up_rounded,
                                          color: ConstColors.kButtonBrownColor,
                                          )
                                      : Icon(
                                          Icons.thumb_up_off_alt_outlined,
                                          color: ConstColors.kButtonBrownColor,
                                        ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    "Like (${photos.like!})",
                                    style: ConstStyle.tileTitleTextStyle
                                        .copyWith(color: Colors.black87),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: ()  {
                                mainController.getPhotoComment(photos.id!);
                              showDialog(
                              context: context,
                              builder: (context) => PhotosCommentsDialogBox(photos:photos)
                              );},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.chat_bubble_outlined,
                                    color: ConstColors.kButtonBrownColor,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    "Comments (${photos.comment!})",
                                    style: ConstStyle.tileTitleTextStyle
                                        .copyWith(color: Colors.black87),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

        SizedBox(height: 2.h,)
      ],
    );
  }
}
