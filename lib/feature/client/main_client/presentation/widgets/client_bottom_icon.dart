import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/const_colors.dart';

class ClientBottomIcon extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final String title;

  const ClientBottomIcon({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final autoSizeGroup = AutoSizeGroup();

    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            color: ConstColors.white,
            size: 20.sp,
          ),
          AutoSizeText(
            title,
            group: autoSizeGroup,
            maxLines: 1,
            style: Get.theme.textTheme.titleMedium!.copyWith(
              color: ConstColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
