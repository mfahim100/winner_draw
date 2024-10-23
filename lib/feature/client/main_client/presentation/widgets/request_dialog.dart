
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:winner_draw/feature/client/main_client/presentation/widgets/select_photo_container.dart';

import '../../../../../core/controllers/check_provider.dart';
import '../../../../../core/widgets/default_button.dart';
import '../../../../../core/widgets/snake_bars.dart';

class RequestDialog extends StatelessWidget {
  const RequestDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(5.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.w)), //this right here
      child: Consumer<CheckProvider>(
        builder: ( context,checkProvider, child) {
          return Container(
              clipBehavior: Clip.antiAlias,
              height: 35.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp),
                  color: Colors.grey
              ),
              child: Column(
                children: [

                  SizedBox(height: 2.h,),


                  const SelectPhotoContainer(),

                  SizedBox(height: 3.h,),


                  DefaultButton(text: 'Upload Screen Shot', onPressed: ()async {

                    if(checkProvider.selectedImage == null ){
                      CustomSnakeBars.snakeBanner(context, 'Hello', 'Dear User please upload payment screenshot ', 'warning');
                    }
                    else{
                      await checkProvider.uploadRequestAndImage(context).whenComplete(()=>  Navigator.of(context).pop());

                    }

                  })


                ],
              )
          );
        },

      ),
    );
  }
}
