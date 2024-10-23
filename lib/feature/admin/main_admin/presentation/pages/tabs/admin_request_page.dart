import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../core/utils/injections.dart';
import '../../../data/data_sources/admin_database_main.dart';
import '../../../domain/entities/request_model.dart';
import '../../manager/main_nav_admin_controller.dart';
import '../../widgets/request_container.dart';


class AdminRequestPage extends StatelessWidget {
  AdminRequestPage({super.key});

  final mainController = sl<MainNavAdminController>();

  @override
  Widget build(BuildContext context) {
    return Obx(()=>

    mainController.isRequestLoading.value ?

        const Center(child: CircularProgressIndicator())
    :

        Container(
      height: 100.h,
      width: 100.w,
      color: Colors.white,
      child: Column(
        children: [

          SizedBox(
            height: 5.w,
          ),
          SizedBox(
            height: 5.w,
          ),

          Text(
            'All Request',
            style: Get.theme.textTheme.titleLarge!.copyWith(
              color: Colors.black,
            ),
          ),


          Container(
            height: 77.h,
            child: mainController.getAllRequest.length==0 ?

                Center(child: Text('NO Request',style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold
                ),))

            :

            ListView.builder(
                itemCount: mainController.getAllRequest.length,
                itemBuilder: (context,index){
                  RequestModel mdl = mainController.getAllRequest[index];
                  return RequestContainer(requestModel: mdl, onAccept: () async {
                    EasyLoading.show();
                    await sl<AdminMainDatabase>().addParticipant(mdl.userUid.toString()).whenComplete((){
                      FirebaseFirestore.instance.collection('request').doc(mdl.userUid).delete();
                      mainController.loadData();
                    });
                    EasyLoading.dismiss();
                  }, onReject: ()async {
                    EasyLoading.show();
                    await FirebaseFirestore.instance.collection('request').doc(mdl.userUid).delete();
                    mainController.loadData();
                    EasyLoading.dismiss();

                  });
                }),
          )


        ],
      ),
    ));
  }
}


