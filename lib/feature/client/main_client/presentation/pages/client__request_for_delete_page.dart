import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/default_button.dart';
import '../../../../../core/widgets/default_text_field.dart';
import '../../../../../core/widgets/snake_bars.dart';
import '../../../../auth/presentation/manager/auth_controller.dart';
import '../manager/main_nav_client_controller.dart';

class ClientRequestForDeleteAccount extends StatelessWidget {
   ClientRequestForDeleteAccount({super.key});

   final controller = sl<AuthController>();
   TextEditingController nameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController textEditingController = TextEditingController();
   var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double h = size.height/100;
    double w = size.width/100;
    return SafeArea(
        child: SizedBox(
          height: 100*h,
          width: 100*w,
          child: Form(
            key: formKey,
            child: Column(
              children: [


                SizedBox(height: 15*h,),

                Text('Describe the reason of why your are',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 3*w
                ),),

                Text('deleting your account',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 3*w
                ),),

                SizedBox(height: 5*h,),

                SizedBox(
                  width: 60*w,
                  child: CustomTextField(
                      controller: nameController,
                      text: 'Name',
                      hintText: 'Your Name',
                    validator: controller.validateNameField,

                  ),
                ),

                      SizedBox(height: 2*h,),

                      SizedBox(
                  width: 60*w,
                  child: CustomTextField(
                      controller: emailController,
                    text: 'Email',
                    hintText: 'Your Email',
                    validator: controller.validateEmailField,

                  ),
                ),

                SizedBox(height: 2*h,),

                SizedBox(
                  width: 60*w,
                  child: CustomTextField(
                      controller: textEditingController,
                      text: 'Reason',
                      hintText: 'Describe reason in short time',
                    validator: (txt){
                        if(txt!.isEmpty){
                          return 'Describe Reason';
                        }
                        return null;
                    },

                  ),
                ),

                SizedBox(height: 5*h,),

                SizedBox(
                  width: 50*w,
                  height: 5*w,
                  child: DefaultButton(text: 'Send Request', onPressed: () async {
                    final requestUid = Uuid().v4();
                    if(formKey.currentState!.validate()){
                      EasyLoading.show();
                      await FirebaseFirestore.instance.collection('deleteRequest').doc(requestUid).set({
                        // 'uid': controller.appUser!.uid,
                        'name': nameController.text.trim(),
                        'email': emailController.text.trim(),
                        'reason': textEditingController.text.trim(),
                      }).whenComplete((){
                        nameController.clear();
                        emailController.clear();
                        textEditingController.clear();
                        EasyLoading.dismiss();
                        CustomSnakeBars.snakeBanner(
                            context, 'Hello', 'Your request has been proceed', 'success');

                      });
                    }


                    EasyLoading.dismiss();
                  }),
                )

              ],
            ),
          ),
        ));
  }
}
