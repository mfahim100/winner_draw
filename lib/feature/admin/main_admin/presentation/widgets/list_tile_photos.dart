import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/constants/const_strings.dart';
import '../../../../../core/constants/const_styles.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../client/main_client/presentation/widgets/dialogbox_comments.dart';
import '../../domain/entities/model_photos.dart';
import '../manager/main_nav_admin_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ListTilePhotos extends StatelessWidget {
  final ModelPhotos photos;

  ListTilePhotos({super.key, required this.photos});
  final mainController = sl<MainNavAdminController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 1.h,
        ),
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
        Container(
          padding: EdgeInsets.all(5.sp),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15.sp),topRight: Radius.circular(15.sp)),

          ),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
            child: Stack(
              children: [

                CachedNetworkImage(
                  // imageUrl: "https://blurha.sh/12c2aca29ea896a628be.jpg",
                  imageUrl: "${ConstString.baseUrlImage}${photos.imgUrl!}",
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                // Image.network(
                //   "${ConstString.baseUrlImage}${photos.imgUrl!}",
                //   fit: BoxFit.cover,
                //   height: 30.h,
                //   width: 80.h,
                // ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => mainController.deletePhoto(context, photos),
                    child: Container(
                      width: 20.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.sp),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.sp),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.sp),bottomRight: Radius.circular(15.sp)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    photos.status == 1
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
                onTap: () {
                  mainController.getPhotoComment(photos.id!);
                  showDialog(
                      context: context,
                      builder: (context) =>
                          PhotosCommentsDialogBox(photos: photos,isAdmin: true,));
                },
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
    );
  }
}
