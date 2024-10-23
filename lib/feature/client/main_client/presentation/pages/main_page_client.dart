import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:winner_draw/feature/client/main_client/presentation/pages/tabs/client_home_page.dart';
import 'package:winner_draw/feature/client/main_client/presentation/pages/tabs/client_live_page.dart';
import 'package:winner_draw/feature/client/main_client/presentation/pages/tabs/client_photo_page.dart';

import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../auth/presentation/manager/auth_controller.dart';
import '../manager/main_nav_client_controller.dart';
import '../widgets/client_bottom_icon.dart';

class MainPageClient extends StatefulWidget {
  const MainPageClient({Key? key}) : super(key: key);

  @override
  State<MainPageClient> createState() => _MainPageClientState();
}

class _MainPageClientState extends State<MainPageClient>
    with TickerProviderStateMixin {
  late AnimationController _fabAnimationController;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;

  final iconList = <IconData>[
    Icons.pending_actions,
    Icons.task_rounded,
  ];

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  final authController = sl<AuthController>();
  final mainNavController = sl<MainNavClientController>();

  @override
  Widget build(BuildContext context) {
    final autoSizeGroup = AutoSizeGroup();
    return Obx(
      () => Scaffold(
        backgroundColor: ConstColors.kBGColor,
        floatingActionButton: GestureDetector(

          onTap: () => mainNavController.setSelectedTabIndex(2),
          child: CircleAvatar
            (
            radius: 25.sp,
            backgroundColor: ConstColors.kWhiteTextColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: ConstColors.kButtonBrownColor,
                  size: 25.sp,
                ),
                AutoSizeText(
                  'Live',
                  group: autoSizeGroup,
                  maxLines: 1,
                  style: Get.theme.textTheme.titleMedium!.copyWith(
                    color: ConstColors.kButtonBrownColor,
                    fontSize: 14.sp
                  ),
                ),
              ],
            ),
          ),
          //params
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: mainNavController.bottomIcon.length,
          tabBuilder: (int index, bool isActive) {
            return ClientBottomIcon(
              onPressed: () => mainNavController.setSelectedTab(index),
              icon: mainNavController.bottomIcon[index],
              title: mainNavController.bottomTitle[index],
            );
          },
          backgroundColor: ConstColors.kPrimaryColor,
          activeIndex: mainNavController.selectedTab.value,
          splashColor: ConstColors.kSecondaryColor,
          // notchAndCornersAnimation: borderRadiusAnimation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => mainNavController.setSelectedTab(index),
          // hideAnimationController: _hideBottomBarAnimationController,
          shadow: BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 12,
            spreadRadius: 0.5,
            color: ConstColors.kPrimaryColor,
          ),
        ),
        body: SizedBox(
          height: 100.h,
          width: 100.w,
          child: SafeArea(
            child: NotificationListener<ScrollNotification>(
              onNotification: onScrollNotification,
              child: mainNavController.selectedTabIndex.value == 0
                  ? ClientHomePage()
                  : mainNavController.selectedTabIndex.value == 1
                      ? ClientPhotoPage()
                      : mainNavController.selectedTabIndex.value == 2
                          ? ClientLivePage()
                          : ClientHomePage(),
            ),
          ),
        ),
      ),
    );
  }
}
