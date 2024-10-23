
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/controllers/check_provider.dart';



class SelectPhotoContainer extends StatelessWidget {
  const SelectPhotoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return

      Consumer<CheckProvider>(
        builder: (context, checkProvider ,child) {
          return  checkProvider.selectedImage == null ?
          Container(
            height: 20.h,
            child: Center(
              child: Column(
                children: [
                  IconButton(onPressed: (){
                    checkProvider.uploadRequestPhoto(context);
                  }, icon: Icon(Icons.upload,color: Colors.white,size: 9.h,)),
                  Text('Click The Icon To Upload Picture',style: TextStyle(
                      fontSize: 2.h,
                      color: Colors.white
                  ),)
                ],
              ),
            ),

            // child: Column,
          )


              :

          SizedBox(
            height: 22.h,
            child: Padding(
              padding:  EdgeInsets.only(left: 5.w),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(02.h),
                      child: Container(
                          height: 19.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            // color: Colors.red,
                              borderRadius: BorderRadius.circular(02.h)
                          ),
                          child: Image.memory(checkProvider.selImg!,fit: BoxFit.cover,)),
                    ),
                  ),
                  Positioned(
                      right: 2.h,
                      top: 1.h,
                      child: CircleAvatar(
                        radius: 3.h,
                        backgroundColor: Colors.red,
                        child: InkWell(
                            onTap: ()=> checkProvider.removeImage(),
                            child: const Icon(Icons.clear,color: Colors.white,)),
                      )
                  )
                ],
              ),
            ),
          );
        },

      );
  }
}
