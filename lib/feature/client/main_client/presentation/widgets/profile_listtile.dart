import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/const_styles.dart';

class ProfileListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function() onTap;

  const ProfileListTile({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black,
              offset: Offset(1.sp, 1.sp),
              blurStyle: BlurStyle.outer,
              blurRadius: 15.sp,
              spreadRadius: 5.sp)
        ],
        borderRadius: BorderRadius.circular(12.sp),
        color: Colors.black.withOpacity(.25)
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: Colors.black,
        ),
        title: Text(text,
            style: ConstStyle.tileTitleTextStyle.copyWith(color: Colors.black)),
      ),
    );
  }
}
