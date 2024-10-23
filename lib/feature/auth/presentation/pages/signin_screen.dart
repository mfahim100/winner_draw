
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/constants/const_neus.dart';
import '../../../../core/constants/const_styles.dart';
import '../../../../core/utils/injections.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../manager/auth_controller.dart';
import '../widgets/password_textfield.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final controller = sl<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 5.h),
              Center(
                child: Hero(
                  tag: 'forImage',
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Image.asset(
                      height: 30.h,
                      width: 80.w,
                      fit: BoxFit.cover,
                      'assets/images/app_logo.png',
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 10.h),
              SizedBox(height: 5.h),
              // Text(
              //   'Sign In',
              //   style: ConstStyle.headerTextStyle,
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              Container(
                width: 95.w,
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15.sp)),
                child: Form(
                  key: controller.signInFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          validator: controller.validateEmailField,
                          text: 'Email',
                          hintText: 'Email',
                          controller: controller.signInEmailController,
                          prefix: const Icon(Icons.alternate_email),
                          obscureText: false,
                          textInputType: TextInputType.emailAddress),
                      PasswordTextField(
                          validator: controller.validatePasswordField,
                          text: 'Password',
                          hintText: 'Password',
                          controller: controller.signInPasswordController,
                          prefix: const Icon(Icons.lock),
                          isPass: true,
                          textInputType: TextInputType.text),
                      SizedBox(height: 2.h),
                      // Visibility(
                      //   visible: true,
                      //   child: Align(
                      //     alignment: AlignmentDirectional.centerEnd,
                      //     child: GestureDetector(
                      //       onTap: () => Get.toNamed(Routes.FORGOTPASS),
                      //       child: Padding(
                      //         padding: EdgeInsets.all(8.sp),
                      //         child: Text(
                      //           "Forgot Password ?",
                      //           style: ConstStyle.headerTextStyle
                      //               .copyWith(fontSize: 16.sp,color: Colors.black),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 2.h),
                      // Hero(
                      //   tag: 'forSubmit',
                      //   child:
                      DefaultButton(
                          text: 'Sign In',
                          onPressed: () => controller.signInSubmit(context)),
                      // ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?    ",
                            style: ConstStyle.tileTitleTextStyle,
                          ),
                          GestureDetector(
                            onTap: () => controller.toggleSignIn(),
                            child: Text(
                              'Sign Up',
                              style: ConstStyle.tileTitleTextStyle,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.h),

              Text('Follow us on:',
                style: ConstStyle.headerTextStyle,
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 12.w,
                    height: 12.w,
                    child: NeumorphicButton(
                      onPressed: () =>controller.openFacebook(),
                      style: ConstNeus.appBarCirclesDark.copyWith(color: Colors.white),
                      padding:  EdgeInsets.all(5.sp),
                      child: Image.asset("assets/images/fb.png"),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  SizedBox(
                    width: 12.w,
                    height: 12.w,
                    child: NeumorphicButton(
                      onPressed: () =>controller.openTiktok(),
                      style: ConstNeus.appBarCirclesDark.copyWith(color: Colors.white),
                      padding:  EdgeInsets.all(5.sp),
                      child: Image.asset("assets/images/tt.png"),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  SizedBox(
                    width: 12.w,
                    height: 12.w,
                    child: NeumorphicButton(
                      onPressed: () =>controller.openYoutube(),
                      style: ConstNeus.appBarCirclesDark.copyWith(color: Colors.white),
                      padding:  EdgeInsets.all(5.sp),
                      child: Image.asset("assets/images/yt.png"),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  SizedBox(
                    width: 12.w,
                    height: 12.w,
                    child: NeumorphicButton(
                      onPressed: () =>controller.callWhatsApp(),
                      style: ConstNeus.appBarCirclesDark.copyWith(color: Colors.white),
                      padding:  EdgeInsets.all(5.sp),
                      child: Image.asset("assets/images/WhatsApp.svg.webp"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}