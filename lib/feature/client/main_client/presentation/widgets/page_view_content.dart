import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/const_colors.dart';

class PageViewContent extends StatelessWidget {
  final String image;
  final int index;
  final int count;

  const PageViewContent({Key? key, required this.image, required this.index, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(5.sp),
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15.sp)),
          child: Container(
            height: 30.h,
            width: 80.h,
            clipBehavior: Clip.antiAlias,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
            child:CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            // Image.network(image,fit: BoxFit.cover,),
          ),
        ),
        Positioned(
          bottom: 3.h,
          left: 0,
          right: 0,
          child: SizedBox(
            width: 80.w,
            height: 1.h,
            child: Center(
              child: ListView.builder(

                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: count,
                itemBuilder: (context, i) => Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.sp),
                  child: CircleAvatar(
                    radius: 10.sp,
                    backgroundColor:
                        index == i ? ConstColors.kButtonBrownColor : Colors.grey,
                  ),
                ),
              ),
            ),
          ),

        )
      ],
    );
  }
}
