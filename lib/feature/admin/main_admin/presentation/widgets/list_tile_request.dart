import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../auth/domain/entities/app_user.dart';
import '../manager/main_nav_admin_controller.dart';

class ListTileRequest extends StatelessWidget {
  final AppUser user;

  ListTileRequest({super.key, required this.user});

  final mainController = sl<MainNavAdminController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.sp),
      padding: EdgeInsets.all(10.sp),
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.all(Radius.circular(15.sp))),
          color: Colors.white70,
          // shadowLightColor: ConstColors.darkShadowLight,
          // shadowDarkColor: ConstColors.darkShadowDark,
          depth: 4,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.5.h),
          width: 90.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NeumorphicText(
                      user.name!.length>13?"${user.name!.substring(0,10)}.":user.name!,
                      textStyle: NeumorphicTextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                      style: const NeumorphicStyle(color: Colors.black54),
                    ),
                    NeumorphicText(
                      user.contact!,
                      // user.phone!,
                      textStyle: NeumorphicTextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                      style: const NeumorphicStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  NeumorphicButton(
                    onPressed: () => mainController.decline(user),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.all(Radius.circular(10.sp))),
                      color: Colors.redAccent,
                      // shadowLightColor: ConstColors.darkShadowLight,
                      // shadowDarkColor: ConstColors.darkShadowDark,
                      depth: 4,
                    ),
                    child: NeumorphicText(
                      "Decline",
                      textStyle: NeumorphicTextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                      style: const NeumorphicStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    child: user.status == 1
                        ? NeumorphicButton(
                            onPressed: () =>
                                mainController.addParticipant(user),
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.concave,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.all(Radius.circular(10.sp))),
                              color: Colors.green,
                              // shadowLightColor: ConstColors.darkShadowLight,
                              // shadowDarkColor: ConstColors.darkShadowDark,
                              depth: 4,
                            ),
                            child: NeumorphicText(
                              "Accept",
                              textStyle: NeumorphicTextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.bold),
                              style: const NeumorphicStyle(color: Colors.white),
                            ),
                          )
                        : NeumorphicButton(
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.concave,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.all(Radius.circular(10.sp))),
                              color: Colors.green,
                              // shadowLightColor: ConstColors.darkShadowLight,
                              // shadowDarkColor: ConstColors.darkShadowDark,
                              depth: 4,
                            ),
                            child: NeumorphicText(
                              "Purchased",
                              textStyle: NeumorphicTextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.bold),
                              style: const NeumorphicStyle(color: Colors.white),
                            ),
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
