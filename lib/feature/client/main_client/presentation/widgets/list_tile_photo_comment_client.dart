import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/constants/const_styles.dart';
import '../../../../../core/controllers/theme_controller.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../admin/main_admin/domain/entities/model_photos_comment.dart';


class ListTilePhotoCommentClient extends StatelessWidget {

 final  ModelPhotoComments comments;
  const ListTilePhotoCommentClient({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.sp,vertical: 10.sp),
      child: Neumorphic(
        style: NeumorphicStyle(
          color: sl<ThemeController>().darkTheme.value
              ? ConstColors.colorForegroundDark
              : ConstColors.colorForegroundLight,
          shadowLightColorEmboss: sl<ThemeController>().darkTheme.value
              ? ConstColors.darkShadowLight
              : ConstColors.lightShadowLight,
          shadowDarkColorEmboss: sl<ThemeController>().darkTheme.value
              ? ConstColors.darkShadowDark
              : ConstColors.lightShadowDark,
          boxShape: NeumorphicBoxShape.roundRect(
             BorderRadius.all(Radius.circular(10.sp)),
          ),
          depth: 3,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp,vertical: 12.sp),
          child: Text(
            comments.comment!,
            style: ConstStyle.tileTitleTextStyle,
          ),
        ),
      ),
    );
  }
}
