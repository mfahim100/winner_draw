import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/constants/const_styles.dart';


class PasswordTextField extends StatefulWidget {
  final String text, hintText;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final bool isPass;
  final Function(String val)? onChange;
  final Function(String? val)? onSave;
  final String? Function(String?)? validator;
  final String type;
  final Icon? prefix;

  const PasswordTextField(
      {super.key,
        required this.text,
        required this.hintText,
        this.controller,
        this.textInputType= TextInputType.text,
        this.type = 'other',
        this.isPass = false,
        this.onChange,
        this.onSave, this.validator, this.prefix});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool pass = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pass = widget.isPass;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.text,
                style: ConstStyle.titleTextStyle,)
          ),
          SizedBox(
            height: 0.5.h,
          ),
          TextFormField(
            validator: widget.validator,
            obscureText: pass,
            controller: widget.controller,
            keyboardType: widget.textInputType,
            onChanged: widget.onChange,
            onSaved: widget.onSave,
            style:  TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: 14.sp),
            decoration: InputDecoration(
                errorStyle:  TextStyle(color: Colors.redAccent,fontSize: 14.sp),
                labelStyle: TextStyle(color: Colors.black,fontSize: 14.sp),
                hintStyle: TextStyle(color: Colors.black,fontSize: 14.sp),
                prefixIcon: widget.prefix,
                suffixIcon: widget.isPass
                    ? GestureDetector(
                  onTap: () {
                    setState(() {
                      pass = !pass;
                    });
                  },
                  child: pass
                      ? const Icon(Icons.visibility_off_outlined,color: Colors.black,)
                      : const Icon(Icons.visibility_outlined,color: Colors.black,),
                )
                    : null,
                hintText: widget.hintText,
                contentPadding: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 5.w),
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
            height: 1.h,
          ),
        ],
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