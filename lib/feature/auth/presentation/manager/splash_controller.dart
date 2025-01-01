import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../../core/utils/injections.dart';
import '../../../../core/utils/use_case.dart';
import '../../domain/use_cases/get_user_use_case.dart';
import 'auth_controller.dart';



class SplashController extends GetxController {
  final GetUserUseCase getUserUseCase;
  SplashController({required this.getUserUseCase});
  void mainOrAuth() {
    _selectCamera();
    Timer(const Duration(seconds: 3), () {
      final isLogin = GetStorage().read("isLogin")??false;

      if (isLogin) {
        sl<AuthController>().loginFunc();
        // sl<MainNavClientController>().getCurrentLuckyDraw();
        // sl<MainNavAdminController>().getCurrentLuckyDraw();
      } else {
        Get.offAllNamed(Routes.AUTH);
      }
    });
  }

  Future<void> _selectCamera() async {
    // stocke in status var the result of request
    PermissionStatus status = await Permission.camera.request();
    PermissionStatus statusStorage = await Permission.camera.request();

    if (status == PermissionStatus.denied) {
      // if the user deny, so we cancel the function

      return;
    } else if (status == PermissionStatus.permanentlyDenied) {
      // if the user permanently deny (it's the case if user deny two times)
      // we display a popup for say "Hey, you absolutely need this access for use this fonctionnnality, do you want allow it in parameters ?"

      // showDialog<String>(
      //   context: context,
      //   builder: (BuildContext context) => AlertDialog(
      //     title: const Text('Allow app to acess your contacts list ?'),
      //     content: const Text(
      //         'You need to allow contact access in parameters for use your contacts list in the app'),
      //     actions: <Widget>[
      //       // if user deny again, we do nothing
      //       TextButton(
      //         onPressed: () => Navigator.pop(context),
      //         child: const Text('Don\'t allow'),
      //       ),
      //
      //       // if user is agree, you can redirect him to the app parameters :)
      //       TextButton(
      //         onPressed: () {
      //           openAppSettings();
      //           Navigator.pop(context);
      //         },
      //         child: const Text('Allow'),
      //       ),
      //     ],
      //   ),
      // );
      return;
    }

    // code to execute if access is granded
  }

  getUser(String uid) async {
    EasyLoading.show();

    var results = await getUserUseCase(Params(uid));

    results.fold((failure) => Get.offAllNamed(Routes.AUTH), (value) {
      if (value!.isAdmin!) {
        Get.offAllNamed(Routes.MAINADMIN);
      } else {
        Get.offAllNamed(Routes.MAINCLIENT);
      }
    });
    EasyLoading.dismiss();
  }
}
