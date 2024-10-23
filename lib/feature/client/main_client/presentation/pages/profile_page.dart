import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/constants/const_neus.dart';
import '../../../../../core/constants/const_strings.dart';
import '../../../../../core/constants/const_styles.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../auth/presentation/manager/auth_controller.dart';
import '../manager/main_nav_client_controller.dart';
import '../widgets/dialogbox_profile_picture.dart';
import '../widgets/profile_listtile.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final profileController = sl<MainNavClientController>();

  final controller = sl<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ConstColors.kBGColor,
        body: SizedBox(
          // color: Colors.white,
          width: 100.w,
          height: 100.h,
          child: Container(
            color: Colors.white,
              // decoration: ConstColors.profileTileDecoration
              //     .copyWith(borderRadius: BorderRadius.zero),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      // SizedBox(height: 1.h,),
                      Container(
                        padding: EdgeInsets.only(right: 80.w),
                        height: 10.h,
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: CircleAvatar(
                              backgroundColor:
                                  Colors.black,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 20.sp,
                              )),
                        ),
                      ),

                      SizedBox(
                        height: 3.h,
                      ),
      
                      GestureDetector(
                        child: SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: Stack(
                            children: [
                              Obx(() => profileController.isImage.value
                                  ? CircleAvatar(
                                      radius: 20.h,
                                      backgroundImage: MemoryImage(
                                          profileController.imageFile!))
                                  // : profileController.appUser!.imgUrl!.isEmpty
                                  : profileController
                                          .appUser!.profilePicture!.isEmpty
                                      ? CircleAvatar(
                                          radius: 20.h,
                                          backgroundImage: const AssetImage(
                                              'assets/images/task_placeholder.png'))
                                      : CircleAvatar(
                                          radius: 20.h,
                                          backgroundImage: NetworkImage(
                                              "${ConstString.baseUrlImage}${profileController.appUser!.profilePicture!}"))),
                              Positioned(
                                bottom: 10.sp,
                                right: 10.sp,
                                child: GestureDetector(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ProfileImagePickerDialogBox();
                                      }),
                                  child: CircleAvatar(
                                    radius: 2.5.h,
                                    backgroundColor: ConstColors.black,
                                    child: CircleAvatar(
                                      radius: 2.h,
                                      backgroundColor: Colors.black,
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
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      // Obx(() =>
                      // SizedBox(
                      //   width: 85.w,
                      //   child: DropdownButtonFormField2<String>(
                      //     isExpanded: true,
                      //     hint: const Text(
                      //       'Select Your Province',
                      //       style: TextStyle(color: Colors.white, fontSize: 14),
                      //     ),
                      //     items: profileController.pakistanStates
                      //         .map((item) => DropdownMenuItem<String>(
                      //       value: item,
                      //       child: Text(
                      //         item,
                      //         style: const TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 14,
                      //         ),
                      //       ),
                      //     ))
                      //         .toList(),
                      //     validator: (value) {
                      //       if (value == null) {
                      //         return 'Please select Province.';
                      //       }
                      //       return null;
                      //     },
                      //     value: profileController.selectedProvince.value,
                      //     onChanged: (value) =>
                      //         profileController.setProvince(value!),
                      //     onSaved: (value) =>
                      //         profileController.setProvince(value!),
                      //     buttonStyleData: const ButtonStyleData(
                      //       padding: EdgeInsets.only(right: 8),
                      //     ),
                      //     iconStyleData: const IconStyleData(
                      //       icon: Icon(
                      //         Icons.arrow_drop_down,
                      //         color: Colors.white,
                      //       ),
                      //       iconSize: 24,
                      //     ),
                      //     dropdownStyleData: DropdownStyleData(
                      //       decoration: BoxDecoration(
                      //         color: ConstColors.kBGColor,
                      //         borderRadius: BorderRadius.circular(25.sp),
                      //       ),
                      //     ),
                      //     menuItemStyleData: const MenuItemStyleData(
                      //       padding: EdgeInsets.symmetric(horizontal: 16),
                      //     ),
                      //     decoration: InputDecoration(
                      //       // Add Horizontal padding using menuItemStyleData.padding so it matches
                      //       // the menu padding when button's width is not specified.
                      //       contentPadding:
                      //       const EdgeInsets.symmetric(vertical: 16),
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(12.sp),
                      //           borderSide:
                      //           const BorderSide(color: Colors.white)),
                      //       focusedErrorBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(12.sp),
                      //           borderSide:
                      //           const BorderSide(color: Colors.white)),
                      //       focusedBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(12.sp),
                      //           borderSide:
                      //           const BorderSide(color: Colors.white)),
                      //       errorBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(12.sp),
                      //           borderSide:
                      //           const BorderSide(color: Colors.white)),
                      //       enabledBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(12.sp),
                      //           borderSide:
                      //           const BorderSide(color: Colors.white)),
                      //       disabledBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(12.sp),
                      //           borderSide:
                      //           const BorderSide(color: Colors.white)),
                      //       // Add more decoration..
                      //     ),
                      //   ),
                      // ),),
                      SizedBox(height: 1.h),
                      ProfileListTile(
                        icon: Icons.person,
                        text: profileController.appUser!.name ?? "",
                        onTap: () {},
                      ),
                      ProfileListTile(
                        icon: Icons.phone,
                        text: profileController.appUser!.contact!,
                        // text: profileController.appUser!.phone!,
                        onTap: () {},
                      ),
                      ProfileListTile(
                        icon: Icons.alternate_email,
                        text: profileController.appUser!.email!,
                        onTap: () {},
                      ),
      
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Follow us on:',
                        style: ConstStyle.headerTextStyle,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 12.w,
                            height: 12.w,
                            child: NeumorphicButton(
                              onPressed: () => controller.openFacebook(),
                              style: ConstNeus.appBarCirclesDark
                                  .copyWith(color: Colors.white),
                              padding: EdgeInsets.all(5.sp),
                              child: Image.asset("assets/images/fb.png"),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          SizedBox(
                            width: 12.w,
                            height: 12.w,
                            child: NeumorphicButton(
                              onPressed: () => controller.openTiktok(),
                              style: ConstNeus.appBarCirclesDark
                                  .copyWith(color: Colors.white),
                              padding: EdgeInsets.all(5.sp),
                              child: Image.asset("assets/images/tt.png"),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          SizedBox(
                            width: 12.w,
                            height: 12.w,
                            child: NeumorphicButton(
                              onPressed: () => controller.openYoutube(),
                              style: ConstNeus.appBarCirclesDark
                                  .copyWith(color: Colors.white),
                              padding: EdgeInsets.all(5.sp),
                              child: Image.asset("assets/images/yt.png"),
                            ),
                          ),
                          // SizedBox(width: 3.w),
                          // SizedBox(
                          //   width: 12.w,
                          //   height: 12.w,
                          //   child: NeumorphicButton(
                          //     onPressed: () =>controller.callWhatsApp(),
                          //     style: ConstNeus.appBarCirclesDark.copyWith(color: Colors.white),
                          //     padding:  EdgeInsets.all(5.sp),
                          //     child: Image.asset("assets/images/WhatsApp.svg.webp"),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      // ProfileListTile(
                      //   icon: Icons.logout,
                      //   text: 'Logout',
                      //   onTap: () =>sl<AuthController>().logout(context),
                      // ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
