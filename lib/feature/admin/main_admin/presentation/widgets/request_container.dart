
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_styles.dart';
import '../../domain/entities/request_model.dart';

class RequestContainer extends StatelessWidget {


  final RequestModel requestModel;
  final Function() onAccept,onReject;
  const RequestContainer({super.key, required this.requestModel, required this.onAccept, required this.onReject});

  @override
  Widget build(BuildContext context) {

    DateTime dt = DateTime.fromMillisecondsSinceEpoch(requestModel.date!);
    String date = '${dt.day}/${dt.month}/${dt.year}';

    return Column(
      children: [
        Container(
          height: 20.h,
          width: 90.w,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(03.w)
          ),
          child: Padding(
            padding:  EdgeInsets.all(1.5.w),
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (context){
                      return Dialog(
                        child: Container(
                          width: 100.w,
                          color: Colors.red,
                          child:CachedNetworkImage(
                            imageUrl: requestModel.screenShotUrl!,
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                          // Image.network(requestModel.screenShotUrl!),
                        ),
                      );
                    });
                  },
                  child: Container(
                    width: 35.w,
                    child: CachedNetworkImage(
                      imageUrl: requestModel.screenShotUrl!,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    // Image.network(requestModel.screenShotUrl!),
                  
                  ),
                ),

                Container(
                  width: 50.w,
                  child: Column(
                    children: [


                      SizedBox(height: 2.h,),

                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(requestModel.name!,style: ConstStyle.requestContainerText,)),

                      SizedBox(height: 0.7.h,),

                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(requestModel.phoneNumber!,style: ConstStyle.requestContainerText,)),

                      SizedBox(height: 0.7.h,),

                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(date, style: ConstStyle.requestContainerText,)),

                      SizedBox(height: 2.h,),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RequestButton(text: 'Accept',color: Colors.black,onPressed: onAccept,),
                          RequestButton(text: 'Reject',color: Colors.red,onPressed: onReject,),



                        ],
                      )


                    ],
                  ),

                )


              ],
            ),
          ),

        ),

        SizedBox(height: 1.h,)
      ],
    );
  }
}

class RequestButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function() onPressed;
  const RequestButton({super.key, required this.text, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onPressed,
      child: Container(
        width:20.w,
        margin: EdgeInsets.all(5.sp),
        padding: EdgeInsets.all(5.sp),
        alignment: Alignment.center,
        height: 3.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.w),
            color:color,
            // gradient: ConstColors.kButtonBG,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 15.sp,
                  spreadRadius: 5.sp,
                  offset: const Offset(1, 1),
                  blurStyle: BlurStyle.inner)
            ]),
        child: Text(text,
            style
                : ConstStyle.requestContainerButton),
      ),
    );
  }
}
