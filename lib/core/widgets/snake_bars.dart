import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class CustomSnakeBars{




  static void snakeMaterialBanner(BuildContext context,String title,String msg,String type){

    final materialBanner = MaterialBanner(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    backgroundColor: Colors.transparent,
    forceActionsBelow: true,
    content: AwesomeSnackbarContent(
      title: title,
      message:msg,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType:
      type=='failure'?ContentType.failure:
      type=='success'?ContentType.success:
      type=='warning'?ContentType.warning:
      type=='help'?ContentType.help:
      ContentType.success
      ,
      // to configure for material banner
      inMaterialBanner: true,
    ),
    actions: const [SizedBox.shrink()],
  );
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);}


  static void snakeBanner(BuildContext context,String title,String msg,String type){

    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message:msg,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType:
        type=='failure'?ContentType.failure:
        type=='success'?ContentType.success:
        type=='warning'?ContentType.warning:
        type=='help'?ContentType.help:
            ContentType.success
        ,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);}


}
