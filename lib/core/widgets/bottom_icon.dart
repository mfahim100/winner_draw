import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/constants/const_neus.dart';
import '../constants/const_colors.dart';
import '../controllers/theme_controller.dart';
import '../utils/injections.dart';

class BottomIcon extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final String title;

  const BottomIcon({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final autoSizeGroup = AutoSizeGroup();

    return SizedBox(
      height: 5.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => NeumorphicButton(
                onPressed: onPressed,
                style: sl<ThemeController>().darkTheme.value
                    ? ConstNeus.appBarCirclesDark
                    : ConstNeus.appBarCirclesLight,
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  icon,
                  color: sl<ThemeController>().darkTheme.value
                      ? ConstColors.white
                      : ConstColors.black,
                ),
              )),
          SizedBox(
            height: 10.sp,
          ),
          Obx(
            () => AutoSizeText(
              title,
              group: autoSizeGroup,
              maxLines: 1,
              style: Get.theme.textTheme.titleMedium!.copyWith(
                color: sl<ThemeController>().darkTheme.value
                    ? ConstColors.black
                    : ConstColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
