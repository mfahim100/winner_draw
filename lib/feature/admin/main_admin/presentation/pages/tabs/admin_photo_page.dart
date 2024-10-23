import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../core/constants/const_colors.dart';
import '../../../../../../core/constants/const_neus.dart';
import '../../../../../../core/controllers/theme_controller.dart';
import '../../../../../../core/utils/injections.dart';
import '../../manager/main_nav_admin_controller.dart';
import '../../widgets/dialogbox_photo_picker.dart';
import '../../widgets/list_tile_photos.dart';

class AdminPhotoPage extends StatelessWidget {
  AdminPhotoPage({super.key});

  final mainController = sl<MainNavAdminController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
        child: SizedBox(
          height: 90.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: NeumorphicButton(
                  onPressed: () => showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => PhotoPickerDialogBox()),
                  style: sl<ThemeController>().darkTheme.value
                      ? ConstNeus.appBarCirclesDark
                      : ConstNeus.appBarCirclesLight,
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.add,
                    color: sl<ThemeController>().darkTheme.value
                        ? ConstColors.white
                        : ConstColors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                height: 72.h,
                child: Obx(() => mainController.isPhotosLoaded.value
                    ? ListView.builder(

                        itemCount: mainController.photosList.length,
                        itemBuilder: (context, index) => ListTilePhotos(photos: mainController.photosList[index]))
                    : Container()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
