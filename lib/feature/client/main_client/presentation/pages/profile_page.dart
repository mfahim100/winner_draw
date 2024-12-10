import 'package:cached_network_image/cached_network_image.dart';
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
                                  : profileController.appUser!.profilePicture!.isEmpty
                                      ? CircleAvatar(
                                          radius: 20.h,
                                          backgroundImage: const AssetImage(
                                              'assets/images/task_placeholder.png'))
                                      : CircleAvatar(
                                          radius: 20.h,
                                          child: CachedNetworkImage(
                                            imageUrl: "${ConstString.baseUrlImage}${profileController.appUser!.profilePicture!}",
                                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                          // backgroundImage: NetworkImage(
                                          //     "${ConstString.baseUrlImage}${profileController.appUser!.profilePicture!}")
      )),
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

                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),

                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
