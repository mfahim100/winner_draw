import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/controllers/theme_controller.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../admin/main_admin/domain/entities/model_photos.dart';
import '../../../../admin/main_admin/presentation/manager/main_nav_admin_controller.dart';
import '../manager/main_nav_client_controller.dart';
import 'comments_box.dart';
import 'list_tile_photo_comment_client.dart';

class PhotosCommentsDialogBox extends StatelessWidget {
  final ModelPhotos photos;
  final bool isAdmin;

  const PhotosCommentsDialogBox(
      {super.key, required this.photos, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(5.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.w)), //this right here
      child: Neumorphic(
        padding: const EdgeInsets.all(8),
        style: NeumorphicStyle(
          color: sl<ThemeController>().darkTheme.value
              ? ConstColors.colorBackgroundDark
              : ConstColors.colorBackgroundLight,
          shadowLightColorEmboss: sl<ThemeController>().darkTheme.value
              ? ConstColors.darkShadowLight
              : ConstColors.lightShadowLight,
          shadowDarkColorEmboss: sl<ThemeController>().darkTheme.value
              ? ConstColors.darkShadowDark
              : ConstColors.lightShadowDark,
          boxShape: NeumorphicBoxShape.roundRect(
            const BorderRadius.all(Radius.circular(28)),
          ),
          depth: -3,
        ),
        child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              SizedBox(
              height: 9.h,
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),

                  child: CircleAvatar(
                    backgroundColor: ConstColors.kButtonBrownColor,
                    radius: 20.sp,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
                height: 65.h,
                child: Obx(() =>
                (isAdmin
                    ? sl<MainNavAdminController>().isPhotoCommentsLoaded.value
                    : sl<MainNavClientController>().isPhotoCommentsLoaded.value)
                    ? Align(
                  alignment: Alignment.bottomCenter,
                      child: ListView
                      .builder(
                        shrinkWrap: true,

                itemCount: isAdmin
                ? sl<MainNavAdminController>()
                      .photoCommentList
                      .length
                      : sl<MainNavClientController>().photoCommentList.length
                      ,
                      itemBuilder: (context, index) =>
                          ListTilePhotoCommentClient(
                            comments:
                            isAdmin
                                ? sl<MainNavAdminController>()
                                .photoCommentList[index]
                                : sl<MainNavClientController>()
                                .photoCommentList[index]
                            ,
                          )),
                    )
                    : Container()),
      ),
      SizedBox(height: 2.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CommentsBox(
              hintText: 'Comment',
              controller: isAdmin
                  ? sl<MainNavAdminController>().photoCommentController
                  : sl<MainNavClientController>().photoCommentController
              ,
              prefix: const Icon(Icons.comment),
              textInputType: TextInputType.text),
          InkWell(
            onTap: () =>
            isAdmin
                ? sl<MainNavAdminController>().addComment(photos)
                : sl<MainNavClientController>().addComment(photos)
            ,
            child: CircleAvatar(
              radius: 21.sp,
              backgroundColor: ConstColors.black,
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          )
        ],
      ),
      ],
    ),)
    ,
    )
    ,
    );
  }
}
