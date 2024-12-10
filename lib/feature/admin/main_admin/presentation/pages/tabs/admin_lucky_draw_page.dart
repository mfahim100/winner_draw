import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../core/constants/const_colors.dart';
import '../../../../../../core/constants/const_styles.dart';
import '../../../../../../core/utils/injections.dart';
import '../../../../../../core/widgets/default_button.dart';
import '../../../../../../core/widgets/prize_tile.dart';
import '../../manager/main_nav_admin_controller.dart';
import '../../widgets/dialogbox_edit_prize.dart';
import '../../widgets/stepper_adding.dart';

class AdminLuckyDrawPage extends StatelessWidget {
  AdminLuckyDrawPage({super.key});

  final mainController = sl<MainNavAdminController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => mainController.isCurrentLuckyDraw.value
        ? Container(
      color: Colors.white,
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.w,
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        NeumorphicButton(
                          onPressed: () => mainController.clearAll(context),
                          style:NeumorphicStyle(
                            shape: NeumorphicShape.convex,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.all(Radius.circular(50.sp))),
                            color: Colors.red,
                            shadowLightColor: ConstColors.lightShadowLight,
                            shadowDarkColor: ConstColors.lightShadowDark,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,

                            children: [
                              Text('Clear All',
                                style: ConstStyle.tileSubTitleTextStyle),
                              SizedBox(width: 3.w,),
                              Icon(
                                Icons.delete_forever_rounded,
                                color: ConstColors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  Text(
                    'Current Lucky Draw',
                    style: Get.theme.textTheme.titleLarge!.copyWith(
                      color: ConstColors.black

                    ),
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  SizedBox(
                    height: 80.h,
                    child: ListView.builder(
                      itemCount: mainController.mainList.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          mainController.editPrize(mainController.mainList[index]);
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => EditPrizeDialogBox(
                                  prize: mainController.mainList[index]));
                        },
                        child: PrizeTile(
                          status: 'Pay Now',
                          title: mainController.mainList[index].title!,
                          price: mainController.mainList[index].price.toString(),
                          imgUrl: mainController.mainList[index].imgUrl,
                          no: mainController.mainList[index].no!,
                          clr: Colors.amberAccent,
                          isAdmin: true,
                          timer: '00:00',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        )
        : mainController.isAddingLuckyDraw.value
            ? AddingStepper()
            : Container(
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Column(
                    children: [
                      Text(
                        'No Current Lucky Draw',
                        style: Get.theme.textTheme.titleMedium!.copyWith(
                          color:ConstColors.black
                        ),
                      ),
                      SizedBox(
                        height: 5.w,
                      ),
                      DefaultButton(
                          text: 'Start Lucky Draw',
                          onPressed: () =>
                              mainController.isAddingLuckyDraw.value = true),

                    ],
                  ),
                ),
            ));
  }
}


