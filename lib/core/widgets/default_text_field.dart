import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/const_styles.dart';

class CustomTextField extends StatelessWidget {
  final String text, hintText;
  final Icon? prefix;
  final IconButton? suffixButton;
  late final bool obscureText;
  final TextInputType textInputType;
  final Icon? suffix;
  final int? maxLength;
  final bool isPass;
  TextEditingController? controller = TextEditingController();
  final String? Function(String?)? validator;

  CustomTextField({
    super.key,
    required this.text,
    required this.hintText,
    this.obscureText = false,
    this.prefix,
    this.suffixButton,
    this.textInputType = TextInputType.text,
    this.suffix,
    this.maxLength,
    this.validator,
    this.isPass = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              text,
              style: ConstStyle.titleTextStyle,
            ),
          ),
          SizedBox(
            height: 0.2.h,
          ),
          TextFormField(
            maxLength: maxLength,
            validator: validator ,
            keyboardType: textInputType,
            obscureText: obscureText,
            controller: controller,
            style:  TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: 14.sp),
            decoration: InputDecoration(
                errorStyle:  TextStyle(color: Colors.redAccent,fontSize: 14.sp),
                labelStyle: TextStyle(color: Colors.black,fontSize: 14.sp),
                hintStyle: TextStyle(color: Colors.black,fontSize: 14.sp),
                suffix: suffixButton,
                hintText: hintText,
                prefixIcon: prefix,
                suffixIcon: suffix,
                contentPadding: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 5.w),
                // enabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(3.w),
                //   borderSide:  const BorderSide(
                //     color: Colors.black,
                //   ),
                // ),
                focusedBorder: buildOutlineInputBorder(),
                border: buildOutlineInputBorder(),
                enabledBorder: buildOutlineInputBorder(),
                errorBorder: buildOutlineInputBorder(),
                focusedErrorBorder: buildOutlineInputBorder(),
                disabledBorder: buildOutlineInputBorder(),
                fillColor: Colors.white,
                filled: true
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
        ],
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({bool isRed=false}) {
    return OutlineInputBorder(
      borderSide:  BorderSide(
          color:isRed?Colors.redAccent: Colors.black,
          style:isRed?BorderStyle.none: BorderStyle.solid
      ),
      borderRadius: BorderRadius.circular(3.w),
    );
  }
}