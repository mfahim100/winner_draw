import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../core/constants/const_colors.dart';
import '../../../../../../core/controllers/theme_controller.dart';
import '../../../../../../core/utils/injections.dart';
import '../../../../../admin/main_admin/presentation/widgets/list_tile_photos.dart';
import '../../manager/main_nav_client_controller.dart';
import '../../widgets/list_tile_photos_client.dart';

class ClientPhotoPage extends StatelessWidget {
   ClientPhotoPage({super.key});

  final mainController = sl<MainNavClientController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Scrollbar(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 5.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Photos',
                    style: Get.theme.textTheme.titleLarge!.copyWith(
                      color:  ConstColors.black

                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                height: 80.h,
                child: Obx(() => mainController.isPhotosLoaded.value
                    ? ListView.builder(
                    itemCount: mainController.photosList.length,
                    itemBuilder: (context, index) => ListTilePhotosClient(photos: mainController.photosList[index]))
                    : Container()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
