
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/const_styles.dart';
import '../../../../core/utils/injections.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../manager/auth_controller.dart';
import '../widgets/dialogbox_picture.dart';
import '../widgets/password_textfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final controller = sl<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 2.5.h),
              Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: GestureDetector(
                            onTap: () => controller.toggleSignIn(),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                              size: 20.sp,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Sign Up',
                            style: ConstStyle.headerTextStyle,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 3.h),
                    GestureDetector(
                      child: Stack(
                        children: [
                          Obx(
                                () => controller.isImage.value ?
                                controller.file != null
                                ? CircleAvatar(
                              radius: 20.w,
                              backgroundImage:
                              FileImage(controller.file!),
                            )
                                : CircleAvatar(
                              radius: 20.w,
                              backgroundImage: const AssetImage(
                                  'assets/images/task_placeholder.png'),
                            )
                                : CircleAvatar(
                              radius: 20.w,
                              backgroundImage: const AssetImage(
                                  'assets/images/task_placeholder.png'),
                            ),
                          ),
                          Positioned(
                            bottom: 10.sp,
                            right: 10.sp,
                            child: GestureDetector(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ImagePickerDialogBox();
                                  }),
                              child: CircleAvatar(
                                radius: 2.h,
                                backgroundColor: ConstColors.kBGColor,
                                child: CircleAvatar(
                                  radius: 1.7.h,
                                  backgroundColor: Colors.blue.shade400,
                                  child: Icon(
                                    Icons.add,
                                    size: 20.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: 80.w,
                      child: DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          // Add Horizontal padding using menuItemStyleData.padding so it matches
                          // the menu padding when button's width is not specified.
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.w),
                              borderSide: const BorderSide(color: Colors.black)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.w),
                              borderSide: const BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.w),
                              borderSide: const BorderSide(color: Colors.black)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.w),
                              borderSide: const BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.w),
                              borderSide: const BorderSide(color: Colors.black)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.w),
                              borderSide: const BorderSide(color: Colors.black)),
                          // Add more decoration..
                        ),
                        hint: const Text(
                          'Select Your Province',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                        items: controller.pakistanStates
                            .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select Province.';
                          }
                          return null;
                        },
                        onChanged:  (value) => controller.setProvince(value!),
                        onSaved: (value) => controller.setProvince(value!),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3.w),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),

                    SizedBox(height: 3.h),
                    CustomTextField(
                        validator: controller.validateNameField,
                        text: 'Name',
                        hintText: 'Name',
                        controller: controller.signUpNameController,
                        prefix: const Icon(Icons.person),
                        obscureText: false,
                        textInputType: TextInputType.name),
                    SizedBox(height: 1.h),
                    CustomTextField(
                        validator: controller.validateEmailField,
                        text: 'Email',
                        hintText: 'Email',
                        controller: controller.signUpEmailController,
                        prefix: const Icon(Icons.alternate_email),
                        obscureText: false,
                        textInputType: TextInputType.emailAddress),
                    SizedBox(height: 1.h),
                    CustomTextField(
                        maxLength: 11,
                        validator: controller.validateContactField,
                        text: 'Mobile Number',
                        hintText: 'Mobile Number',
                        controller: controller.signUpPhoneController,
                        prefix: const Icon(Icons.contact_phone),
                        textInputType: TextInputType.phone),
                    PasswordTextField(
                        validator: controller.validatePasswordField,
                        text: 'Password',
                        hintText: 'Password',
                        controller: controller.signUpPasswordController,
                        prefix: const Icon(Icons.lock),
                        isPass: true,
                        textInputType: TextInputType.text),
                    SizedBox(height: 1.h),
                    PasswordTextField(
                        validator: controller.validateConfirmPasswordField,
                        text: 'Confirm Password',
                        hintText: 'Confirm Password',
                        controller: controller.signUpConfirmPasswordController,
                        prefix: const Icon(Icons.security),
                        isPass: true,
                        textInputType: TextInputType.text),
                    SizedBox(height: 3.h),
                    Hero(
                      tag: 'forSubmit',
                      child: DefaultButton(
                          text: 'Sign Up',
                          onPressed: () => controller.signUpSubmit(context)),
                    ),
                    SizedBox(height: 1.h),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
