import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/const_colors.dart';
import '../constants/const_styles.dart';

class DefaultButtonAdmin extends StatelessWidget {
  final String text;
  final bool isFixed;
  final bool isFixedSmall;

  final VoidCallback onPressed;

  const DefaultButtonAdmin({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isFixed = false,
    this.isFixedSmall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: onPressed,
      child: Container(
        width: isFixed?25.w:80.w,
        margin: EdgeInsets.all(5.sp),
        padding: EdgeInsets.all(5.sp),
        alignment: Alignment.center,
        height:isFixed?4.h: 6.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.sp),
            // color: ConstColors.kButtonBrownColor,
            gradient: ConstColors.kButtonBG,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 15.sp,
                  spreadRadius: 5.sp,
                  offset: const Offset(1, 1),
                  blurStyle: BlurStyle.inner)
            ]),
        child: Text(text, style:isFixed?ConstStyle.tileSubTitleTextStyle :ConstStyle.buttonTextStyle),
      ),
    );
  }
}
