import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PdfDialogBox extends StatefulWidget {
  const PdfDialogBox({Key? key}) : super(key: key);

  @override
  State<PdfDialogBox> createState() => _PdfDialogBoxState();
}

class _PdfDialogBoxState extends State<PdfDialogBox> {
  String filePath = "assets/winnerDrawPdf.pdf";

  @override
  Widget build(BuildContext context) {
    final Completer<PDFViewController> controller =
        Completer<PDFViewController>();
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.all(2.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.w)), //this right here
      child: SizedBox(
        width: 90.w,
        height: 70.h,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: const DecorationImage(
                      image: AssetImage("assets/images/winnerDrawPdfPng.JPG")),
                  borderRadius: BorderRadius.circular(25.sp)),
              width: 90.w,
              height: 70.h,
            ),
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: CircleAvatar(
                  radius: 16.sp,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
