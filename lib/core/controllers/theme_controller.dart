import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final storage = GetStorage();

  RxBool darkTheme = true.obs;

  setDarkTheme(bool val) {
    darkTheme.value = val;
    storage.write('theme', val);
  }

  getDarkTheme() {
    var theme = storage.read('theme') ?? false;
    setDarkTheme(theme);
  }

  void loadTheme() {
    getDarkTheme();
    update();
  }
}
