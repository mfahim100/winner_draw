import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/constants/const_styles.dart';


class DefaultTextFieldForTimer extends StatefulWidget {
  final String hnt;
  final TextEditingController controller;
  final IconData icon;
  final bool obscureText;
  final bool isComment;
  final bool isEnabled;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final Color borderColor;
  final double? wd;
  final int maxLength;
  final int maxLines;

  const DefaultTextFieldForTimer({
    Key? key,
    required this.hnt,
    this.validator,
    this.onChanged,
    required this.controller,
    required this.icon,
    this.obscureText = false,
    this.isComment = false,
    this.isEnabled = true,
    required this.textInputType,
    this.borderColor = Colors.white,
    this.wd,
    this.maxLength = 0,
    this.maxLines = 0,
  }) : super(key: key);

  @override
  State<DefaultTextFieldForTimer> createState() => _DefaultTextFieldForTimerState();
}

class _DefaultTextFieldForTimerState extends State<DefaultTextFieldForTimer> {
  bool pass = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pass = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: .5.h),
      width: widget.isComment?65.w:80.w,
      child: TextFormField(
        enabled: widget.isEnabled,
        maxLength: widget.maxLength != 0 ? widget.maxLength : null,
        maxLines: widget.obscureText
            ? 1
            : widget.maxLines != 0
            ? widget.maxLines
            : null,
        inputFormatters:widget.textInputType == TextInputType.name
            ? [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
        ]
            : widget.textInputType == TextInputType.number
            ? [
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ]
            : widget.textInputType == TextInputType.phone
            ? [
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ]
            : null,
        style: TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: 14.sp),
        validator: widget.validator,
        onChanged: widget.onChanged,
        keyboardType: widget.textInputType,
        obscureText: pass,
        controller: widget.controller,
        decoration: InputDecoration(
            focusedBorder: buildOutlineInputBorder(),
            border: buildOutlineInputBorder(),
            enabledBorder: buildOutlineInputBorder(),
            errorBorder: buildOutlineInputBorder(),
            focusedErrorBorder: buildOutlineInputBorder(),
            disabledBorder: buildOutlineInputBorder(),
            fillColor: Colors.white,
            filled: true,
          suffixIcon: widget.obscureText
              ? GestureDetector(
            onTap: () {
              setState(() {
                pass = !pass;
              });
            },
            child: pass
                ? const Icon(
              Icons.visibility_off_outlined,
              color: Colors.black,
            )
                : const Icon(
              Icons.visibility_outlined,
              color: Colors.black,
            ),
          )
              : null,
          prefixIcon: Icon(
            widget.icon,
            color: Colors.black,
          ),

          hintText: widget.hnt,
          errorStyle:  TextStyle(color: Colors.redAccent,fontSize: 14.sp),
          labelStyle: TextStyle(color: Colors.black,fontSize: 14.sp),
          hintStyle: TextStyle(color: Colors.black,fontSize: 14.sp),
          labelText: widget.hnt,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
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
