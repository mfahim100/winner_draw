import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:winner_draw/feature/admin/main_admin/presentation/pages/tabs/admin_request_page.dart';

import '../../../../../core/constants/const_colors.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../../core/widgets/bottom_icon.dart';
import '../../../../auth/presentation/manager/auth_controller.dart';
import '../manager/main_nav_admin_controller.dart';
import 'tabs/admin_draw_results_page.dart';
import 'tabs/admin_lucky_draw_page.dart';
import 'tabs/admin_photo_page.dart';

class MainPageAdmin extends StatefulWidget {
  const MainPageAdmin({Key? key}) : super(key: key);

  @override
  State<MainPageAdmin> createState() => _MainPageAdminState();
}

class _MainPageAdminState extends State<MainPageAdmin> with TickerProviderStateMixin {

  late AnimationController _fabAnimationController;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;

  final iconList = <IconData>[
    Icons.local_activity,
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

  final mainNavController = sl<MainNavAdminController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() =>

        Scaffold(
          backgroundColor: ConstColors.kBGColor,

          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            height: 10.h,
            itemCount: mainNavController.bottomIcon.length,
            tabBuilder: (int index, bool isActive) {
              return BottomIcon(
                onPressed: () =>index<4?mainNavController.setSelectedTab(index): sl<AuthController>().logout(context),
                icon: mainNavController.bottomIcon[index],
                title: mainNavController.bottomTitle[index],
              );
            },
            backgroundColor: ConstColors.kPrimaryColor,
            activeIndex: mainNavController.selectedTab.value,
            splashColor: ConstColors.kSecondaryColor,
            // notchAndCornersAnimation: borderRadiusAnimation,
            splashSpeedInMilliseconds: 300,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            gapLocation: GapLocation.none,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            onTap: (index) => index<3?mainNavController.setSelectedTab(index): sl<AuthController>().logout(context),
            // hideAnimationController: _hideBottomBarAnimationController,
            shadow:  BoxShadow(
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
                    ? AdminLuckyDrawPage()
                    :mainNavController.selectedTabIndex.value == 1
                    ? AdminDrawResultsPage()
                    :mainNavController.selectedTabIndex.value == 2
                    ?  AdminRequestPage()
                    :mainNavController.selectedTabIndex.value == 3
                    ?  AdminPhotoPage()
                    : AdminLuckyDrawPage(),
              ),
            ),
          ),
        ),
    );
  }
}
